static bool g_isPlayWinMusic[MAXPLAYERS + 1] = {true, ...};
static bool g_areSoundsDownloaded[MAXPLAYERS + 1] = {true, ...};

void Settings_Query(int client) {
    QueryClientConVar(client, "dod_playwinmusic", Settings_Result, SettingsType_PlayWinMusic);
    QueryClientConVar(client, "cl_downloadfilter", Settings_Result, SettingsType_DownloadFilter);
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
