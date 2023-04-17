bool UseCase_IsSupressGameSound(const char[] gameSound) {
    bool isUsWinSound = strcmp(gameSound, SOUND_GAME_WIN_US) == 0;
    bool isGermanWinSound = strcmp(gameSound, SOUND_GAME_WIN_GERMAN) == 0;

    return isUsWinSound || isGermanWinSound;
}

void UseCase_RefreshSettings() {
    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            Settings_Query(client);
        }
    }
}

void UseCase_PlayMusic(int winTeam) {
    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            UseCase_PlayMusicForClient(client, winTeam);
        }
    }
}

void UseCase_PlayMusicForClient(int client, int winTeam) {
    if (!Settings_IsPlayWinMusic(client)) {
        return;
    }

    char musicType[COOKIE_VALUE_SIZE];

    Cookie_GetMusicType(client, musicType);

    bool playCustomMusic = strcmp(musicType, COOKIE_MUSIC_TYPE_CUSTOM) == 0;
    bool areSoundsDownloaded = Settings_AreSoundsDownloaded(client);

    if (playCustomMusic && areSoundsDownloaded) {
        int soundIndex = Random_GetRandomIndex();

        Sound_PlayCustomMusic(client, soundIndex);
    } else {
        Sound_PlayDefaultMusic(client, winTeam);
    }
}

void UseCase_FindMusic() {
    char musicPath[PLATFORM_MAX_PATH];

    Sound_GetMusicPath(musicPath);

    DirectoryListing directory = OpenDirectory(musicPath);
    char fileName[PLATFORM_MAX_PATH];
    FileType fileType;

    SoundList_Clear();

    while (directory.GetNext(fileName, sizeof(fileName), fileType)) {
        bool isDirectory = fileType == FileType_Directory;
        bool isNotMp3 = !UseCase_StringEndsWith(fileName, ".mp3");

        if (isDirectory || isNotMp3) {
            continue;
        }

        Sound_AddToDownloads(fileName);
        Sound_Precache(fileName);
        SoundList_Add(fileName);
        LogMessage("Added '%s'", fileName);
    }

    int soundsAmount = SoundList_Size();

    if (soundsAmount == 0) {
        LogMessage("Files not found");
    } else {
        Random_Create(soundsAmount);
        LogMessage("Total files: %d", soundsAmount);
    }
}

bool UseCase_StringEndsWith(const char[] string, const char[] subString) {
    int index = StrContains(string, subString);

    return index == strlen(string) - strlen(subString);
}
