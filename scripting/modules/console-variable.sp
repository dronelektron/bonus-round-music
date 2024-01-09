static ConVar g_path;
static ConVar g_chatSongName;
static ConVar g_playbackOrder;

void Variable_Create() {
    g_path = CreateConVar("sm_bonusroundmusic_path", "brm", "Path to music without the 'sound' folder");
    g_chatSongName = CreateConVar("sm_bonusroundmusic_chat_song_name", "1", "Show (yes - 1, no - 0) song name in chat");
    g_playbackOrder = CreateConVar("sm_bonusroundmusic_playback_order", "1", "Playback order (sequence - 0, random - 1)");
}

void Variable_Path(char[] musicPath) {
    g_path.GetString(musicPath, PLATFORM_MAX_PATH);
}

bool Variable_ChatSongName() {
    return g_chatSongName.IntValue == 1;
}

int Variable_PlaybackOrder() {
    return g_playbackOrder.IntValue;
}
