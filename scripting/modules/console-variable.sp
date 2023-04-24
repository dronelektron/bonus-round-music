static ConVar g_showSongName;

void Variable_Create() {
    g_showSongName = CreateConVar("sm_bonusroundmusic_show_song_name", "1", "Show song name");
}

bool Variable_ShowSongName() {
    return g_showSongName.IntValue == 1;
}
