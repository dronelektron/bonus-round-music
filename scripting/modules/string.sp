bool String_EndsWith(const char[] string, const char[] suffix) {
    int actualIndex = StrContains(string, suffix);
    int expectedIndex = strlen(string) - strlen(suffix);

    return actualIndex == expectedIndex;
}

bool String_IsEmpty(const char[] string) {
    return string[0] == NULL_CHARACTER;
}

void String_RemoveFileExtension(const char[] fullName, char[] partialName) {
    int length = strlen(fullName) - strlen(EXTENSION_MP3) + 1;

    strcopy(partialName, length, fullName);
}
