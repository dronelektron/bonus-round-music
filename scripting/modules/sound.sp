static char g_lastFileName[MAXPLAYERS + 1][PLATFORM_MAX_PATH];

void Sound_ResetLastFileName(int client) {
    g_lastFileName[client][0] = NULL_CHARACTER;
}

void Sound_SetLastFileName(int client, const char[] fileName) {
    strcopy(g_lastFileName[client], PLATFORM_MAX_PATH, fileName);
}

void Sound_Stop(int client) {
    if (String_IsEmpty(g_lastFileName[client])) {
        return;
    }

    char relativePath[PLATFORM_MAX_PATH];

    Sound_GetRelativePath(relativePath, g_lastFileName[client]);
    StopSound(client, SOUND_CHANNEL, relativePath);
    Sound_ResetLastFileName(client);
}

void Sound_PlayDefaultMusic(int client, int winTeam) {
    bool isUsWin = winTeam == TEAM_ALLIES;

    Sound_Stop(client);
    EmitGameSoundToClient(client, isUsWin ? SOUND_GAME_WIN_US : SOUND_GAME_WIN_GERMAN);
    Sound_ResetLastFileName(client);
}

void Sound_PlayCustomMusic(int client, const char[] fileName) {
    char relativePath[PLATFORM_MAX_PATH];

    Sound_GetRelativePath(relativePath, fileName);
    Sound_Stop(client);
    EmitSoundToClient(client, relativePath, _, SOUND_CHANNEL);
    Sound_SetLastFileName(client, fileName);
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
