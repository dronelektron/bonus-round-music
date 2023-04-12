bool UseCase_IsSupressGameSound(const char[] gameSound) {
    bool isUsWinSound = strcmp(gameSound, SOUND_GAME_WIN_US) == 0;
    bool isGermanWinSound = strcmp(gameSound, SOUND_GAME_WIN_GERMAN) == 0;

    return isUsWinSound || isGermanWinSound;
}

void UseCase_RefreshSettings() {
    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            Settings_Refresh(client);
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

    Sound_PlayWinMusic(client, winTeam);
}
