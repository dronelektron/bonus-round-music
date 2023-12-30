bool String_EndsWith(const char[] string, const char[] suffix) {
    int index = StrContains(string, suffix);

    return index == strlen(string) - strlen(suffix);
}

bool String_IsEmpty(const char[] string) {
    return string[0] == NULL_CHARACTER;
}

void String_RemoveFileExtension(char[] fileName) {
    int lastIndex = strlen(fileName) - strlen(EXTENSION_MP3);

    fileName[lastIndex] = NULL_CHARACTER;
}
