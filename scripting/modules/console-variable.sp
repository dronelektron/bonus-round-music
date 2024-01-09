static ConVar g_path;
static ConVar g_chatSongName;
static ConVar g_playbackOrder;
static ConVar g_historyMode;

void Variable_Create() {
    g_path = CreateConVar("sm_bonusroundmusic_path", "brm", "Path to music without the 'sound' folder");
    g_chatSongName = CreateConVar("sm_bonusroundmusic_chat_song_name", "1", "Show (yes - 1, no - 0) song name in chat");
    g_playbackOrder = CreateConVar("sm_bonusroundmusic_playback_order", "1", "Playback order (sequence - 0, random - 1)");
    g_historyMode = CreateConVar("sm_bonusroundmusic_history_mode", "1", "How long to store song history (map - 0, reboot - 1)");
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

int Variable_HistoryMode() {
    return g_historyMode.IntValue;
}
