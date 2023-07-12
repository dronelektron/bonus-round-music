static Handle g_musicTypeCookie;
static char g_musicType[MAXPLAYERS + 1][COOKIE_MUSIC_TYPE_SIZE];

void Cookie_Create() {
    g_musicTypeCookie = RegClientCookie("bonusroundmusic_type", "Bonus round music type", CookieAccess_Private);
}

void Cookie_Load(int client) {
    char musicType[COOKIE_MUSIC_TYPE_SIZE];

    GetClientCookie(client, g_musicTypeCookie, musicType, sizeof(musicType));

    if (musicType[0] == NULL_CHARACTER) {
        Cookie_SetMusicType(client, COOKIE_MUSIC_TYPE_CUSTOM);
    } else {
        Cookie_CopyValue(g_musicType[client], musicType);
    }
}

void Cookie_GetMusicType(int client, char[] musicType) {
    Cookie_CopyValue(musicType, g_musicType[client]);
}

void Cookie_SetMusicType(int client, const char[] musicType) {
    SetClientCookie(client, g_musicTypeCookie, musicType);
    Cookie_CopyValue(g_musicType[client], musicType);
}

static void Cookie_CopyValue(char[] destination, const char[] source) {
    strcopy(destination, COOKIE_MUSIC_TYPE_SIZE, source);
}
