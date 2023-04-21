static Handle g_musicTypeCookie;
static char g_musicType[MAXPLAYERS + 1][COOKIE_VALUE_SIZE];

void Cookie_Create() {
    g_musicTypeCookie = RegClientCookie("bonusroundmusic_type", "Bonus round music type", CookieAccess_Private);
}

void Cookie_Reset(int client) {
    g_musicType[client] = COOKIE_MUSIC_TYPE_CUSTOM;
}

void Cookie_Load(int client) {
    char cookieValue[COOKIE_VALUE_SIZE];

    GetClientCookie(client, g_musicTypeCookie, cookieValue, sizeof(cookieValue));

    if (cookieValue[0] != NULL_CHARACTER) {
        Cookie_CopyValue(g_musicType[client], cookieValue);
    }
}

void Cookie_GetMusicType(int client, char[] musicType) {
    Cookie_CopyValue(musicType, g_musicType[client]);
}

void Cookie_SetMusicType(int client, const char[] musicType) {
    Cookie_CopyValue(g_musicType[client], musicType);
    SetClientCookie(client, g_musicTypeCookie, musicType);
}

static void Cookie_CopyValue(char[] destination, const char[] source) {
    strcopy(destination, COOKIE_VALUE_SIZE, source);
}
