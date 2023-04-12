void Sound_PlayWinMusic(int client, int winTeam) {
    if (winTeam == TEAM_ALLIES) {
        EmitGameSoundToClient(client, SOUND_GAME_WIN_US);
    } else {
        EmitGameSoundToClient(client, SOUND_GAME_WIN_GERMAN);
    }
}
