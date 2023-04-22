static char g_configPath[PLATFORM_MAX_PATH];

void Storage_BuildConfigPath() {
	BuildPath(Path_SM, g_configPath, sizeof(g_configPath), CONFIG_PATH);
}

void Storage_GetMusicPath(char[] musicPath) {
	KeyValues kv = new KeyValues("Root");

	if (FileExists(g_configPath)) {
		kv.ImportFromFile(g_configPath);
	} else {
		kv.SetString(KEY_MUSIC_PATH, "brm");
		kv.Rewind();
		kv.ExportToFile(g_configPath);
	}

	kv.GetString(KEY_MUSIC_PATH, musicPath, PLATFORM_MAX_PATH);

	delete kv;
}
