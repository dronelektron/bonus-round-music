void Command_Create() {
    RegAdminCmd("sm_brm_play_all", Command_PlayMusicForAll, ADMFLAG_GENERIC);
    RegAdminCmd("sm_brm_play", Command_PlayMusicForClient, ADMFLAG_GENERIC);
}

public Action Command_PlayMusicForAll(int client, int args) {
    Menu_PlayMusicForAll(client);

    return Plugin_Handled;
}

public Action Command_PlayMusicForClient(int client, int args) {
    Menu_Players(client);

    return Plugin_Handled;
}
