void Message_NowPlaying(int client, const char[] fileName) {
    char partialName[PLATFORM_MAX_PATH];

    String_RemoveFileExtension(fileName, partialName);
    CPrintToChat(client, "%t%t", PREFIX_COLORED, "Now playing", partialName);
}

void Message_PlayerIsNoLongerAvailable(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Player is no longer available");
}

void Message_PlayedMusicForAll(int client, const char[] fileName) {
    char partialName[PLATFORM_MAX_PATH];

    String_RemoveFileExtension(fileName, partialName);
    ShowActivity2(client, PREFIX, "%t", "Played music for all", partialName);
    LogMessage("\"%L\" played '%s' for all players", client, partialName);
}

void Message_PlayedMusicForClient(int client, int target, const char[] fileName) {
    char partialName[PLATFORM_MAX_PATH];

    String_RemoveFileExtension(fileName, partialName);
    ShowActivity2(client, PREFIX, "%t", "Played music for client", partialName, target);
    LogMessage("\"%L\" played '%s' for \"%L\"", client, partialName, target);
}

void Message_StoppedMusicForAll(int client) {
    ShowActivity2(client, PREFIX, "%t", "Stopped music for all");
    LogMessage("\"%L\" stopped music for all players", client);
}

void Message_StoppedMusicForClient(int client, int target) {
    ShowActivity2(client, PREFIX, "%t", "Stopped music for client", target);
    LogMessage("\"%L\" stopped music for \"%L\"", client, target);
}
