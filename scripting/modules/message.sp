void Message_NowPlaying(int client, const char[] fileName) {
    CPrintToChat(client, "%t%t", "Prefix", "Now playing", fileName);
}
