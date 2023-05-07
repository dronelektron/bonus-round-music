void Message_NowPlaying(int client, const char[] fileName) {
    CPrintToChat(client, "%t%t", PREFIX_COLORED, "Now playing", fileName);
}

void Message_PlayerIsNoLongerAvailable(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Player is no longer available");
}

void Message_PlayedMusicForAll(int client, const char[] fileName) {
    ShowActivity2(client, PREFIX, "%t", "Played music for all", fileName);
    LogMessage("\"%L\" played '%s' for all players", client, fileName);
}

void Message_PlayedMusicForClient(int client, int target, const char[] fileName) {
    ShowActivity2(client, PREFIX, "%t", "Played music for client", fileName, target);
    LogMessage("\"%L\" played '%s' for \"%L\"", client, fileName, target);
}

void Message_StoppedMusicForAll(int client) {
    ShowActivity2(client, PREFIX, "%t", "Stopped music for all");
    LogMessage("\"%L\" stopped music for all players", client);
}

void Message_StoppedMusicForClient(int client, int target) {
    ShowActivity2(client, PREFIX, "%t", "Stopped music for client", target);
    LogMessage("\"%L\" stopped music for \"%L\"", client, target);
}
