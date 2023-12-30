static ArrayList g_sounds;

void SoundList_Create() {
    int blockSize = ByteCountToCells(PLATFORM_MAX_PATH);

    g_sounds = new ArrayList(blockSize);
}

void SoundList_Clear() {
    g_sounds.Clear();
}

int SoundList_Size() {
    return g_sounds.Length;
}

void SoundList_Add(const char[] fileName) {
    g_sounds.PushString(fileName);
}

void SoundList_Get(int index, char[] fileName) {
    g_sounds.GetString(index, fileName, PLATFORM_MAX_PATH);
}

void SoundList_Sort() {
    g_sounds.Sort(Sort_Ascending, Sort_String);
}
