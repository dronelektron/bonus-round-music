static bool g_isPlayWinMusic[MAXPLAYERS + 1] = {true, ...};

void Settings_Refresh(int client) {
    QueryClientConVar(client, "dod_playwinmusic", Settings_Result);
}

void Settings_Result(QueryCookie cookie, int client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue) {
    if (result != ConVarQuery_Okay) {
        return;
    }

    bool isPlayWinMusic = strcmp(cvarValue, "0") != 0;

    g_isPlayWinMusic[client] = isPlayWinMusic;
}

bool Settings_IsPlayWinMusic(int client) {
    return g_isPlayWinMusic[client];
}
