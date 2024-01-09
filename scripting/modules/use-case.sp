bool UseCase_IsSupressGameSound(const char[] gameSound) {
    bool isUsWinSound = strcmp(gameSound, SOUND_GAME_WIN_US) == 0;
    bool isGermanWinSound = strcmp(gameSound, SOUND_GAME_WIN_GERMAN) == 0;

    return isUsWinSound || isGermanWinSound;
}

void UseCase_QueryPlayWinMusic() {
    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            Settings_Query(client, SettingsType_PlayWinMusic);
        }
    }
}

void UseCase_PlayMusic(int winTeam) {
    if (SoundList_Size(LIST_SOUNDS_ALL) == 0) {
        return;
    }

    if (SoundList_Size(LIST_SOUNDS_LEFT) == 0) {
        SoundList_Clear(LIST_SOUNDS_PLAYED);
        UseCase_MarkAllSoundsAsLeft();
    }

    char fileName[PLATFORM_MAX_PATH];

    UseCase_GetNextSound(fileName);
    UseCase_MarkSoundAsPlayed(fileName);

    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            UseCase_PlayMusicForClient(client, winTeam, fileName);
        }
    }
}

void UseCase_PlayMusicForClient(int client, int winTeam, const char[] fileName) {
    if (!Settings_IsPlayWinMusic(client)) {
        return;
    }

    char musicType[COOKIE_MUSIC_TYPE_SIZE];

    Cookie_GetMusicType(client, musicType);

    bool playCustomMusic = strcmp(musicType, COOKIE_MUSIC_TYPE_CUSTOM) == 0;
    bool areSoundsDownloaded = Settings_AreSoundsDownloaded(client);

    if (playCustomMusic && areSoundsDownloaded) {
        Sound_PlayCustomMusic(client, fileName);

        if (Variable_ChatSongName()) {
            Message_NowPlaying(client, fileName);
        }
    } else {
        Sound_PlayDefaultMusic(client, winTeam);
    }
}

void UseCase_PlayMusicManuallyForAll(int client, const char[] fileName) {
    for (int target = 1; target <= MaxClients; target++) {
        bool areSoundsDownloaded = Settings_AreSoundsDownloaded(target);

        if (IsClientInGame(target) && areSoundsDownloaded) {
            Sound_PlayCustomMusic(target, fileName);
        }
    }

    Message_PlayedMusicForAll(client, fileName);
}

void UseCase_PlayMusicManuallyForClient(int client, int target, const char[] fileName) {
    Sound_PlayCustomMusic(target, fileName);
    Message_PlayedMusicForClient(client, target, fileName);
}

void UseCase_StopMusicForAll(int client) {
    for (int target = 1; target <= MaxClients; target++) {
        bool areSoundsDownloaded = Settings_AreSoundsDownloaded(target);

        if (IsClientInGame(target) && areSoundsDownloaded) {
            Sound_Stop(target);
        }
    }

    Message_StoppedMusicForAll(client);
}

void UseCase_StopMusicForClient(int client, int target) {
    Sound_Stop(target);
    Message_StoppedMusicForClient(client, target);
}

void UseCase_FindMusic() {
    char musicPath[PLATFORM_MAX_PATH];

    Sound_GetMusicPath(musicPath);

    DirectoryListing directory = OpenDirectory(musicPath);
    char fileName[PLATFORM_MAX_PATH];
    FileType fileType;

    SoundList_Clear(LIST_SOUNDS_ALL);
    UseCase_UpdateSoundHistory();
    LogMessage("Path for music '%s'", musicPath);

    while (directory.GetNext(fileName, sizeof(fileName), fileType)) {
        bool isDirectory = fileType == FileType_Directory;
        bool isNotMp3 = !String_EndsWith(fileName, EXTENSION_MP3);

        if (isDirectory || isNotMp3) {
            continue;
        }

        Sound_AddToDownloads(fileName);
        Sound_Precache(fileName);
        SoundList_Add(LIST_SOUNDS_ALL, fileName);
    }

    CloseHandle(directory);
    SoundList_Sort(LIST_SOUNDS_ALL);
    UseCase_MarkAllSoundsAsLeft();
    SoundList_Sort(LIST_SOUNDS_LEFT);

    int soundsAmount = SoundList_Size(LIST_SOUNDS_ALL);

    if (soundsAmount == 0) {
        LogMessage("Files not found");
    } else {
        LogMessage("Loaded %d files", soundsAmount);
    }
}

void UseCase_MarkAllSoundsAsLeft() {
    char fileName[PLATFORM_MAX_PATH];

    for (int i = 0; i < SoundList_Size(LIST_SOUNDS_ALL); i++) {
        SoundList_Get(LIST_SOUNDS_ALL, i, fileName);
        UseCase_MarkSoundAsLeft(fileName);
    }
}

void UseCase_MarkSoundAsLeft(const char[] fileName) {
    if (SoundList_Exists(LIST_SOUNDS_LEFT, fileName)) {
        return;
    }

    if (SoundList_Exists(LIST_SOUNDS_PLAYED, fileName)) {
        return;
    }

    SoundList_Add(LIST_SOUNDS_LEFT, fileName);
}

void UseCase_MarkSoundAsPlayed(const char[] fileName) {
    SoundList_RemoveByName(LIST_SOUNDS_LEFT, fileName);
    SoundList_Add(LIST_SOUNDS_PLAYED, fileName);
}

void UseCase_UpdateSoundHistory() {
    if (Variable_HistoryMode() == HISTORY_MODE_MAP) {
        SoundList_Clear(LIST_SOUNDS_LEFT);
        SoundList_Clear(LIST_SOUNDS_PLAYED);
    }
}

void UseCase_GetNextSound(char[] fileName) {
    int soundIndex = 0;

    if (Variable_PlaybackOrder() != PLAYBACK_ORDER_SEQUENCE) {
        int soundsAmount = SoundList_Size(LIST_SOUNDS_LEFT);

        soundIndex = GetRandomInt(0, soundsAmount - 1);
    }

    SoundList_Get(LIST_SOUNDS_LEFT, soundIndex, fileName);
}
