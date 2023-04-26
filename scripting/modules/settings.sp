static bool g_isPlayWinMusic[MAXPLAYERS + 1] = {true, ...};
static bool g_areSoundsDownloaded[MAXPLAYERS + 1] = {true, ...};

static char g_settings[][] = {
    "dod_playwinmusic",
    "cl_downloadfilter"
};

void Settings_Query(int client, SettingsType type) {
    QueryClientConVar(client, g_settings[type], Settings_Result, type);
}

void Settings_Result(QueryCookie cookie, int client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue, SettingsType type) {
    if (result != ConVarQuery_Okay) {
        return;
    }

    if (type == SettingsType_PlayWinMusic) {
        bool isPlayWinMusic = strcmp(cvarValue, "0") != 0;

        g_isPlayWinMusic[client] = isPlayWinMusic;
    } else {
        bool IsSoundDownloaded = strcmp(cvarValue, "all") == 0;

        g_areSoundsDownloaded[client] = IsSoundDownloaded;
    }
}

bool Settings_IsPlayWinMusic(int client) {
    return g_isPlayWinMusic[client];
}

bool Settings_AreSoundsDownloaded(int client) {
    return g_areSoundsDownloaded[client];
}
