static ArrayList g_sounds[LIST_SOUNDS_PLAYED + 1];

void SoundList_Create() {
    int blockSize = ByteCountToCells(PLATFORM_MAX_PATH);

    for (int i = LIST_SOUNDS_ALL; i <= LIST_SOUNDS_PLAYED; i++) {
        g_sounds[i] = new ArrayList(blockSize);
    }
}

void SoundList_Clear(int list) {
    g_sounds[list].Clear();
}

int SoundList_Size(int list) {
    return g_sounds[list].Length;
}

bool SoundList_Exists(int list, const char[] fileName) {
    int index = SoundList_Find(list, fileName);

    return index != INDEX_NOT_FOUND;
}

void SoundList_Add(int list, const char[] fileName) {
    g_sounds[list].PushString(fileName);
}

void SoundList_Get(int list, int index, char[] fileName) {
    g_sounds[list].GetString(index, fileName, PLATFORM_MAX_PATH);
}

void SoundList_RemoveByName(int list, const char[] fileName) {
    int index = SoundList_Find(list, fileName);

    if (index != INDEX_NOT_FOUND) {
        g_sounds[list].Erase(index);
    }
}

void SoundList_Sort(int list) {
    g_sounds[list].Sort(Sort_Ascending, Sort_String);
}

static int SoundList_Find(int list, const char[] fileName) {
    return g_sounds[list].FindString(fileName);
}
