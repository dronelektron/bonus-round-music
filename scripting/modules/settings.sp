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
        g_isPlayWinMusic[client] = strcmp(cvarValue, "0") != 0;
    } else {
        g_areSoundsDownloaded[client] = strcmp(cvarValue, "all") == 0;
    }
}

bool Settings_IsPlayWinMusic(int client) {
    return g_isPlayWinMusic[client];
}

bool Settings_AreSoundsDownloaded(int client) {
    return g_areSoundsDownloaded[client];
}
