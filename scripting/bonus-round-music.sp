#include <sourcemod>
#include <sdktools>
#include <clientprefs>

#include "brm/cookie"
#include "brm/menu"
#include "brm/sound"
#include "brm/use-case"

#include "modules/cookie.sp"
#include "modules/event.sp"
#include "modules/menu.sp"
#include "modules/settings.sp"
#include "modules/sound.sp"
#include "modules/use-case.sp"

public Plugin myinfo = {
    name = "Bonus round music",
    author = "Dron-elektron",
    description = "Allows you to play random music at the end of the round",
    version = "0.1.0",
    url = "https://github.com/dronelektron/bonus-round-music"
};

public void OnPluginStart() {
    Cookie_Create();
    Event_Create();
    Sound_Create();
    Menu_AddToPreferences();
    CookieLateLoad();
    LoadTranslations("bonus-round-music.phrases");
}

public void OnMapStart() {
    Sound_PrecacheMusic();
}

public void OnClientConnected(int client) {
    Cookie_Reset(client);
}

public void OnClientPostAdminCheck(int client) {
    Settings_Refresh(client);
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
