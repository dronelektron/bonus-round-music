void Command_Create() {
    RegAdminCmd("sm_brm_play_all", Command_PlayMusicForAll, ADMFLAG_GENERIC);
    RegAdminCmd("sm_brm_play", Command_PlayMusicForClient, ADMFLAG_GENERIC);
    RegAdminCmd("sm_brm_stop_all", Command_StopMusicForAll, ADMFLAG_GENERIC);
    RegAdminCmd("sm_brm_stop", Command_StopMusicForClient, ADMFLAG_GENERIC);
}

public Action Command_PlayMusicForAll(int client, int args) {
    Menu_PlayMusicForAll(client);

    return Plugin_Handled;
}

public Action Command_PlayMusicForClient(int client, int args) {
    Menu_SelectClientForPlay(client);

    return Plugin_Handled;
}

public Action Command_StopMusicForAll(int client, int args) {
    UseCase_StopMusicForAll(client);

    return Plugin_Handled;
}

public Action Command_StopMusicForClient(int client, int args) {
    Menu_SelectClientForStop(client);

    return Plugin_Handled;
}
