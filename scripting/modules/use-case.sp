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
    int soundsAmount = SoundList_Size();

    if (soundsAmount == 0) {
        return;
    }

    int soundIndex = GetRandomInt(0, soundsAmount - 1);

    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            UseCase_PlayMusicForClient(client, winTeam, soundIndex);
        }
    }
}

void UseCase_PlayMusicForClient(int client, int winTeam, int soundIndex) {
    if (!Settings_IsPlayWinMusic(client)) {
        return;
    }

    char musicType[COOKIE_MUSIC_TYPE_SIZE];

    Cookie_GetMusicType(client, musicType);

    bool playCustomMusic = strcmp(musicType, COOKIE_MUSIC_TYPE_CUSTOM) == 0;
    bool areSoundsDownloaded = Settings_AreSoundsDownloaded(client);

    if (playCustomMusic && areSoundsDownloaded) {
        char fileName[PLATFORM_MAX_PATH];

        SoundList_Get(soundIndex, fileName);
        Sound_PlayCustomMusic(client, fileName);

        if (Variable_ShowSongName()) {
            String_RemoveFileExtension(fileName);
            Message_NowPlaying(client, fileName);
        }
    } else {
        Sound_PlayDefaultMusic(client, winTeam);
    }
}

void UseCase_PlayMusicManuallyForAll(int client, int soundIndex) {
    char fileName[PLATFORM_MAX_PATH];

    SoundList_Get(soundIndex, fileName);

    for (int target = 1; target <= MaxClients; target++) {
        bool areSoundsDownloaded = Settings_AreSoundsDownloaded(target);

        if (IsClientInGame(target) && areSoundsDownloaded) {
            Sound_PlayCustomMusic(target, fileName);
        }
    }

    String_RemoveFileExtension(fileName);
    Message_PlayedMusicForAll(client, fileName);
}

void UseCase_PlayMusicManuallyForClient(int client, int target, int soundIndex) {
    char fileName[PLATFORM_MAX_PATH];

    SoundList_Get(soundIndex, fileName);
    String_RemoveFileExtension(fileName);
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

    SoundList_Clear();
    LogMessage("Path for music '%s'", musicPath);

    while (directory.GetNext(fileName, sizeof(fileName), fileType)) {
        bool isDirectory = fileType == FileType_Directory;
        bool isNotMp3 = !String_EndsWith(fileName, EXTENSION_MP3);

        if (isDirectory || isNotMp3) {
            continue;
        }

        Sound_AddToDownloads(fileName);
        Sound_Precache(fileName);
        SoundList_Add(fileName);
    }

    CloseHandle(directory);
    SoundList_Sort();

    int soundsAmount = SoundList_Size();

    if (soundsAmount == 0) {
        LogMessage("Files not found");
    } else {
        LogMessage("Loaded %d files", soundsAmount);
    }
}
