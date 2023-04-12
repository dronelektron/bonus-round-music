static ConVar g_musicPath;

void Variable_Create() {
    g_musicPath = CreateConVar("sm_bonusroundmusic_path", "bonus-round-music", "The path to custom music");
}

void Variable_MusicPath(char[] musicPath) {
    g_musicPath.GetString(musicPath, PLATFORM_MAX_PATH);
}
