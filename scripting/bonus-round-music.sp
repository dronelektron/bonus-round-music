#include <sourcemod>
#include <sdktools>
#include <clientprefs>

#include "bonus-round-music/console-variable"
#include "bonus-round-music/cookie"
#include "bonus-round-music/menu"
#include "bonus-round-music/message"
#include "bonus-round-music/settings"
#include "bonus-round-music/sound-list"
#include "bonus-round-music/sound"
#include "bonus-round-music/storage"
#include "bonus-round-music/use-case"

#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/cookie.sp"
#include "modules/event.sp"
#include "modules/menu.sp"
#include "modules/message.sp"
#include "modules/settings.sp"
#include "modules/sound-list.sp"
#include "modules/sound.sp"
#include "modules/storage.sp"
#include "modules/string.sp"
#include "modules/use-case.sp"

#define AUTO_CREATE_YES true

public Plugin myinfo = {
    name = "Bonus round music",
    author = "Dron-elektron",
    description = "Allows you to play custom music at the end of the round or manually",
    version = "1.5.1",
    url = "https://github.com/dronelektron/bonus-round-music"
};

public void OnPluginStart() {
    Command_Create();
    Variable_Create();
    Cookie_Create();
    Event_Create();
    Menu_AddToPreferences();
    SoundList_Create();
    Storage_BuildHistoryPath();
    CookieLateLoad();
    LoadTranslations("bonus-round-music.phrases");
    AutoExecConfig(AUTO_CREATE_YES, "bonus-round-music");
}

public void OnConfigsExecuted() {
    UseCase_FindMusic();
}

public void OnMapEnd() {
    UseCase_SaveSoundHistory();
}

public void OnClientConnected(int client) {
    Sound_ResetLastFileName(client);
}

public void OnClientPostAdminCheck(int client) {
    Settings_Query(client, SettingsType_PlayWinMusic);
    Settings_Query(client, SettingsType_DownloadFilter);
}

public void OnClientCookiesCached(int client) {
    Cookie_Load(client);
}

static void CookieLateLoad() {
    for (int client = 1; client <= MaxClients; client++) {
        if (AreClientCookiesCached(client)) {
            OnClientCookiesCached(client);
        }
    }
}
