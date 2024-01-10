static char g_historyPath[PLATFORM_MAX_PATH];

void Storage_BuildHistoryPath() {
    BuildPath(Path_SM, g_historyPath, sizeof(g_historyPath), HISTORY_PATH);
}

void Storage_SaveSoundHistory() {
    int soundsAmount = SoundList_Size(LIST_SOUNDS_PLAYED);

    if (soundsAmount == 0) {
        return;
    }

    char soundName[PLATFORM_MAX_PATH];
    File file = OpenFile(g_historyPath, "w");

    for (int i = 0; i < soundsAmount; i++) {
        SoundList_Get(LIST_SOUNDS_PLAYED, i, soundName);

        file.WriteLine(soundName);
    }

    CloseHandle(file);
}

void Storage_LoadSoundHistory() {
    File file = OpenFile(g_historyPath, "r");

    if (file == null) {
        return;
    }

    char soundName[PLATFORM_MAX_PATH];

    while (file.ReadLine(soundName, sizeof(soundName))) {
        TrimString(soundName);

        if (String_IsEmpty(soundName)) {
            continue;
        }

        SoundList_Add(LIST_SOUNDS_PLAYED, soundName);
    }

    CloseHandle(file);
}
