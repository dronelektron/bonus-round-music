static ArrayList g_music;

void Sound_Create() {
    int blockSize = ByteCountToCells(PLATFORM_MAX_PATH);

    g_music = new ArrayList(blockSize);
}

void Sound_PlayWinMusic(int client, int winTeam) {
    if (winTeam == TEAM_ALLIES) {
        EmitGameSoundToClient(client, SOUND_GAME_WIN_US);
    } else {
        EmitGameSoundToClient(client, SOUND_GAME_WIN_GERMAN);
    }
}

void Sound_PrecacheMusic() {
    char musicPathPartial[PLATFORM_MAX_PATH];
    char musicPathFull[PLATFORM_MAX_PATH];

    Variable_MusicPath(musicPathPartial);
    Format(musicPathFull, sizeof(musicPathFull), "sound/%s", musicPathPartial);

    DirectoryListing directory = OpenDirectory(musicPathFull);
    char filePathFull[PLATFORM_MAX_PATH];
    char filePathPartial[PLATFORM_MAX_PATH];
    char fileName[PLATFORM_MAX_PATH];
    FileType fileType;

    g_music.Clear();

    while (directory.GetNext(fileName, sizeof(fileName), fileType)) {
        bool isDirectory = fileType == FileType_Directory;
        bool isNotMp3 = !UseCase_StringEndsWith(fileName, ".mp3");

        if (isDirectory || isNotMp3) {
            continue;
        }

        Format(filePathFull, sizeof(filePathFull), "%s/%s", musicPathFull, fileName);
        Format(filePathPartial, sizeof(filePathPartial), "%s/%s", musicPathPartial, fileName);
        AddFileToDownloadsTable(filePathFull);
        PrecacheSound(filePathPartial);

        g_music.PushString(filePathPartial);
    }
}

void Sound_PlayCustomMusic(int client) {
    int index = GetRandomInt(0, g_music.Length - 1);
    char filePath[PLATFORM_MAX_PATH];

    g_music.GetString(index, filePath, sizeof(filePath));

    EmitSoundToClient(client, filePath);
}
