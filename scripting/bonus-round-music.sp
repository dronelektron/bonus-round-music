#include <sourcemod>
#include <sdktools>
#include <clientprefs>

#include "brm/cookie"
#include "brm/menu"
#include "brm/settings"
#include "brm/sound"
#include "brm/use-case"

#include "modules/console-variable.sp"
#include "modules/cookie.sp"
#include "modules/event.sp"
#include "modules/menu.sp"
#include "modules/random.sp"
#include "modules/settings.sp"
#include "modules/sound-list.sp"
#include "modules/sound.sp"
#include "modules/use-case.sp"

#define AUTO_CREATE_YES true

public Plugin myinfo = {
    name = "Bonus round music",
    author = "Dron-elektron",
    description = "Allows you to play random music at the end of the round",
    version = "0.1.0",
    url = "https://github.com/dronelektron/bonus-round-music"
};

public void OnPluginStart() {
    Variable_Create();
    Cookie_Create();
    Event_Create();
    Menu_AddToPreferences();
    SoundList_Create();
    CookieLateLoad();
    LoadTranslations("bonus-round-music.phrases");
    AutoExecConfig(AUTO_CREATE_YES, "bonus-round-music");
}

public void OnConfigsExecuted() {
    UseCase_FindMusic();
}

public void OnClientConnected(int client) {
    Cookie_Reset(client);
}

public void OnClientPostAdminCheck(int client) {
    Settings_Query(client);
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
