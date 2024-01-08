bool String_EndsWith(const char[] string, const char[] suffix) {
    int actualIndex = StrContains(string, suffix);
    int expectedIndex = strlen(string) - strlen(suffix);

    return actualIndex == expectedIndex;
}

bool String_IsEmpty(const char[] string) {
    return string[0] == NULL_CHARACTER;
}

void String_RemoveFileExtension(char[] fileName) {
    int lastIndex = strlen(fileName) - strlen(EXTENSION_MP3);

    fileName[lastIndex] = NULL_CHARACTER;
}
