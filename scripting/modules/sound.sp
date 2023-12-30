static int g_lastSoundIndex[MAXPLAYERS + 1];

void Sound_ResetLastIndex(int client) {
    g_lastSoundIndex[client] = SOUND_INDEX_NOT_FOUND;
}

void Sound_Stop(int client) {
    int soundIndex = g_lastSoundIndex[client];

    if (soundIndex == SOUND_INDEX_NOT_FOUND) {
        return;
    }

    char fileName[PLATFORM_MAX_PATH];
    char relativePath[PLATFORM_MAX_PATH];

    SoundList_Get(soundIndex, fileName);
    Sound_GetRelativePath(relativePath, fileName);
    StopSound(client, SOUND_CHANNEL, relativePath);
    Sound_ResetLastIndex(client);
}

void Sound_PlayDefaultMusic(int client, int winTeam) {
    bool isUsWin = winTeam == TEAM_ALLIES;

    Sound_Stop(client);
    EmitGameSoundToClient(client, isUsWin ? SOUND_GAME_WIN_US : SOUND_GAME_WIN_GERMAN);
    Sound_ResetLastIndex(client);
}

void Sound_PlayCustomMusic(int client, int soundIndex) {
    char fileName[PLATFORM_MAX_PATH];
    char relativePath[PLATFORM_MAX_PATH];

    SoundList_Get(soundIndex, fileName);
    Sound_GetRelativePath(relativePath, fileName);
    Sound_Stop(client);
    EmitSoundToClient(client, relativePath, _, SOUND_CHANNEL);

    g_lastSoundIndex[client] = soundIndex;
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

    Variable_MusicPath(relativePath);

    if (String_IsEmpty(relativePath)) {
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

    Variable_MusicPath(relativePath);

    if (String_IsEmpty(relativePath)) {
        Format(path, PLATFORM_MAX_PATH, "%s", fileName);
    } else {
        Format(path, PLATFORM_MAX_PATH, "%s/%s", relativePath, fileName);
    }
}
