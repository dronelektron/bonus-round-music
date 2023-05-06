void Message_NowPlaying(int client, const char[] fileName) {
    CPrintToChat(client, "%t%t", PREFIX_COLORED, "Now playing", fileName);
}

void Message_PlayerIsNoLongerAvailable(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Player is no longer available");
}

void Message_PlayedMusicForAll(int client, const char[] fileName) {
    ShowActivity2(client, PREFIX, "%t", "Played music for all", fileName);
    LogMessage("\"%L\" played music '%s' for all players", client, fileName);
}

void Message_PlayedMusicForClient(int client, int target, const char[] fileName) {
    ShowActivity2(client, PREFIX, "%t", "Played music for client", fileName, target);
    LogMessage("\"%L\" played music '%s' for \"%L\"", client, fileName, target);
}
