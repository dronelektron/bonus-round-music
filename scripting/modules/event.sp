void Event_Create() {
    HookEvent("dod_broadcast_audio", Event_BroadcastAudio, EventHookMode_Pre);
    HookEvent("dod_round_start", Event_RoundStart);
    HookEvent("dod_round_win", Event_RoundWin);
}

public Action Event_BroadcastAudio(Event event, const char[] name, bool dontBroadcast) {
    char sound[SOUND_NAME_SIZE];

    event.GetString("sound", sound, sizeof(sound));

    return UseCase_IsSupressGameSound(sound) ? Plugin_Stop : Plugin_Continue;
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    UseCase_QueryPlayWinMusic();
}

public void Event_RoundWin(Event event, const char[] name, bool dontBroadcast) {
    int winTeam = event.GetInt("team");

    UseCase_PlayMusic(winTeam);
}
