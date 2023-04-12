#include <sourcemod>
#include <sdktools>

#include "brm/sound"
#include "brm/use-case"

#include "modules/event.sp"
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
    Event_Create();
}

public void OnClientPostAdminCheck(int client) {
    Settings_Refresh(client);
}
