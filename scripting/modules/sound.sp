void Sound_PlayDefaultMusic(int client, int winTeam) {
    bool isUsWin = winTeam == TEAM_ALLIES;

    EmitGameSoundToClient(client, isUsWin ? SOUND_GAME_WIN_US : SOUND_GAME_WIN_GERMAN);
}

void Sound_PlayCustomMusic(int client, int soundIndex) {
    char fileName[PLATFORM_MAX_PATH];
    char relativePath[PLATFORM_MAX_PATH];

    SoundList_Get(soundIndex, fileName);
    Sound_GetRelativePath(relativePath, fileName);
    EmitSoundToClient(client, relativePath);
}

void Sound_AddToDownloads(const char[] fileName) {
    char fullPath[PLATFORM_MAX_PATH];

    Sound_GetFullPath(fullPath, fileName);
    AddFileToDownloadsTable(fullPath);
}

void Sound_Precache(const char[] fileName) {
    char relativePath[PLATFORM_MAX_PATH];

    Sound_GetRelativePath(relativePath, fileName);
    PrecacheSound(relativePath, PRELOAD_YES);
}

void Sound_GetMusicPath(char[] path) {
    char relativePath[PLATFORM_MAX_PATH];

    Storage_GetMusicPath(relativePath);

    if (UseCase_IsStringEmpty(relativePath)) {
        Format(path, PLATFORM_MAX_PATH, "sound");
    } else {
        Format(path, PLATFORM_MAX_PATH, "sound/%s", relativePath);
    }
}

void Sound_GetFullPath(char[] path, const char[] fileName) {
    char relativePath[PLATFORM_MAX_PATH];

    Sound_GetRelativePath(relativePath, fileName);
    Format(path, PLATFORM_MAX_PATH, "sound/%s", relativePath);
}

void Sound_GetRelativePath(char[] path, const char[] fileName) {
    char relativePath[PLATFORM_MAX_PATH];

    Storage_GetMusicPath(relativePath);

    if (UseCase_IsStringEmpty(relativePath)) {
        Format(path, PLATFORM_MAX_PATH, "%s", fileName);
    } else {
        Format(path, PLATFORM_MAX_PATH, "%s/%s", relativePath, fileName);
    }
}