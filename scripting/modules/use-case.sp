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
    int soundIndex = Random_GetRandomIndex();
    bool showSongName = Variable_ShowSongName();

    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            UseCase_PlayMusicForClient(client, winTeam, soundIndex, showSongName);
        }
    }
}

void UseCase_PlayMusicForClient(int client, int winTeam, int soundIndex, bool showSongName) {
    if (!Settings_IsPlayWinMusic(client)) {
        return;
    }

    char musicType[COOKIE_MUSIC_TYPE_SIZE];

    Cookie_GetMusicType(client, musicType);

    bool playCustomMusic = strcmp(musicType, COOKIE_MUSIC_TYPE_CUSTOM) == 0;
    bool areSoundsDownloaded = Settings_AreSoundsDownloaded(client);

    if (playCustomMusic && areSoundsDownloaded) {
        Sound_PlayCustomMusic(client, soundIndex);

        if (showSongName) {
            char fileName[PLATFORM_MAX_PATH];

            SoundList_Get(soundIndex, fileName);
            UseCase_RemoveFileExtension(fileName);
            Message_NowPlaying(client, fileName);
        }
    } else {
        Sound_PlayDefaultMusic(client, winTeam);
    }
}

void UseCase_PlayMusicManuallyForAll(int client, int soundIndex) {
    for (int target = 1; target <= MaxClients; target++) {
        bool areSoundsDownloaded = Settings_AreSoundsDownloaded(target);

        if (IsClientInGame(target) && areSoundsDownloaded) {
            Sound_PlayCustomMusic(target, soundIndex);
        }
    }

    char fileName[PLATFORM_MAX_PATH];

    SoundList_Get(soundIndex, fileName);
    UseCase_RemoveFileExtension(fileName);
    Message_PlayedMusicForAll(client, fileName);
}

void UseCase_PlayMusicManuallyForClient(int client, int target, int soundIndex) {
    char fileName[PLATFORM_MAX_PATH];

    SoundList_Get(soundIndex, fileName);
    UseCase_RemoveFileExtension(fileName);
    Sound_PlayCustomMusic(target, soundIndex);
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
    ArrayList previousList = SoundList_Clone();

    SoundList_Clear();
    LogMessage("Path for music '%s'", musicPath);

    while (directory.GetNext(fileName, sizeof(fileName), fileType)) {
        bool isDirectory = fileType == FileType_Directory;
        bool isNotMp3 = !UseCase_StringEndsWith(fileName, EXTENSION_MP3);

        if (isDirectory || isNotMp3) {
            continue;
        }

        Sound_AddToDownloads(fileName);
        Sound_Precache(fileName);
        SoundList_Add(fileName);
        LogMessage("Added '%s'", fileName);
    }

    SoundList_Sort();

    int soundsAmount = SoundList_Size();
    ArrayList currentList = SoundList_Clone();

    if (soundsAmount == 0) {
        LogMessage("Files not found");
    } else {
        LogMessage("Total files: %d", soundsAmount);

        if (UseCase_AreSoundListsEqual(previousList, currentList)) {
            LogMessage("Sound list is not changed");
        } else {
            Random_Create(soundsAmount);
            LogMessage("Sound list is changed");
        }
    }

    delete previousList;
    delete currentList;
}

bool UseCase_StringEndsWith(const char[] string, const char[] subString) {
    int index = StrContains(string, subString);

    return index == strlen(string) - strlen(subString);
}

bool UseCase_IsStringEmpty(const char[] string) {
    return strlen(string) == 0;
}

void UseCase_RemoveFileExtension(char[] fileName) {
    int lastIndex = strlen(fileName) - strlen(EXTENSION_MP3);

    fileName[lastIndex] = '\0';
}

bool UseCase_AreSoundListsEqual(ArrayList previousList, ArrayList currentList) {
    if (previousList.Length != currentList.Length) {
        return false;
    }

    char previousFileName[PLATFORM_MAX_PATH];
    char currentFileName[PLATFORM_MAX_PATH];

    for (int i = 0; i < previousList.Length; i++) {
        previousList.GetString(i, previousFileName, PLATFORM_MAX_PATH);
        currentList.GetString(i, currentFileName, PLATFORM_MAX_PATH);

        if (strcmp(previousFileName, currentFileName) != 0) {
            return false;
        }
    }

    return true;
}
