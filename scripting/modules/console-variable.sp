static ConVar g_musicPath;
static ConVar g_showSongName;
static ConVar g_playbackOrder;

void Variable_Create() {
    g_musicPath = CreateConVar("sm_bonusroundmusic_music_path", "brm", "Path to music without the 'sound' folder");
    g_showSongName = CreateConVar("sm_bonusroundmusic_show_song_name", "1", "Show song name");
    g_playbackOrder = CreateConVar("sm_bonusroundmusic_playback_order", "1", "Playback order (sequence - 0, random - 1)");
}

void Variable_MusicPath(char[] musicPath) {
    g_musicPath.GetString(musicPath, PLATFORM_MAX_PATH);
}

bool Variable_ShowSongName() {
    return g_showSongName.IntValue == 1;
}

int Variable_PlaybackOrder() {
    return g_playbackOrder.IntValue;
}
