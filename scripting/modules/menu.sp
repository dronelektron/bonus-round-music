static int g_targetId[MAXPLAYERS + 1];

void Menu_AddToPreferences() {
    SetCookieMenuItem(MenuHandler_BonusRoundMusic, 0, BONUS_ROUND_MUSIC);
}

public void MenuHandler_BonusRoundMusic(int client, CookieMenuAction action, any info, char[] buffer, int maxLength) {
    if (action == CookieMenuAction_SelectOption) {
        Menu_Settings(client);
    } else {
        Format(buffer, maxLength, "%T", BONUS_ROUND_MUSIC, client);
    }
}

public void Menu_Settings(int client) {
    Menu menu = new Menu(MenuHandler_Settings);

    menu.SetTitle("%T", BONUS_ROUND_MUSIC, client);

    Menu_AddMusicTypeItem(menu, COOKIE_MUSIC_TYPE_DEFAULT, ITEM_MUSIC_TYPE_DEFAULT, client);
    Menu_AddMusicTypeItem(menu, COOKIE_MUSIC_TYPE_CUSTOM, ITEM_MUSIC_TYPE_CUSTOM, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_Settings(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        Cookie_SetMusicType(param1, info);
        Menu_Settings(param1);
    } else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        ShowCookieMenu(param1);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_AddMusicTypeItem(Menu menu, const char[] musicType, const char[] phrase, int client) {
    char item[ITEM_SIZE];
    int style = Menu_GetItemStyleForMusicType(client, musicType);

    Format(item, sizeof(item), "%T", phrase, client);

    menu.AddItem(musicType, item, style);
}

int Menu_GetItemStyleForMusicType(int client, const char[] musicType) {
    char cookieValue[COOKIE_MUSIC_TYPE_SIZE];

    Cookie_GetMusicType(client, cookieValue);

    return strcmp(cookieValue, musicType) == 0 ? ITEMDRAW_DISABLED : ITEMDRAW_DEFAULT;
}

void Menu_SelectClientForPlay(int client) {
    Menu menu = new Menu(MenuHandler_SelectClientForPlay);

    menu.SetTitle("%T", SELECT_PLAYER, client);

    Menu_AddPlayers(menu);

    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_SelectClientForPlay(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        int targetId = StringToInt(info);
        int target = GetClientOfUserId(targetId);

        if (Menu_IsValidTargetForPlay(param1, target)) {
            g_targetId[param1] = targetId;

            Menu_PlayMusicForClient(param1);
        }
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_SelectClientForStop(int client) {
    Menu menu = new Menu(MenuHandler_SelectClientForStop);

    menu.SetTitle("%T", SELECT_PLAYER, client);

    Menu_AddPlayers(menu);

    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_SelectClientForStop(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        int targetId = StringToInt(info);
        int target = GetClientOfUserId(targetId);

        if (target == INVALID_CLIENT) {
            Menu_SelectClientForStop(param1);
            Message_PlayerIsNoLongerAvailable(param1);
        } else {
            UseCase_StopMusicForClient(param1, target);
        }
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_PlayMusicForAll(int client, int fromItem = 0) {
    Menu menu = new Menu(MenuHandler_PlayMusicForAll);

    menu.SetTitle("%T", SELECT_MUSIC, client);

    Menu_AddMusic(menu);

    menu.DisplayAt(client, fromItem, MENU_TIME_FOREVER);
}

public int MenuHandler_PlayMusicForAll(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        UseCase_PlayMusicManuallyForAll(param1, param2);
        Menu_PlayMusicForAll(param1, menu.Selection);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_PlayMusicForClient(int client, int fromItem = 0) {
    Menu menu = new Menu(MenuHandler_PlayMusicForClient);

    menu.SetTitle("%T", SELECT_MUSIC, client);

    Menu_AddMusic(menu);

    menu.ExitBackButton = true;
    menu.DisplayAt(client, fromItem, MENU_TIME_FOREVER);
}

public int MenuHandler_PlayMusicForClient(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        int targetId = g_targetId[param1];
        int target = GetClientOfUserId(targetId);

        if (Menu_IsValidTargetForPlay(param1, target)) {
            char fileName[PLATFORM_MAX_PATH];

            SoundList_Get(param2, fileName);
            UseCase_PlayMusicManuallyForClient(param1, target, fileName);
            Menu_PlayMusicForClient(param1, menu.Selection);
        }
    } else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        Menu_SelectClientForPlay(param1);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_AddPlayers(Menu menu) {
    char info[INFO_SIZE];
    char item[MAX_NAME_LENGTH];

    for (int client = 1; client <= MaxClients; client++) {
        bool areSoundsDownloaded = Settings_AreSoundsDownloaded(client);

        if (IsClientInGame(client) && areSoundsDownloaded) {
            int userId = GetClientUserId(client);

            IntToString(userId, info, sizeof(info));
            Format(item, sizeof(item), "%N", client);

            menu.AddItem(info, item);
        }
    }
}

void Menu_AddMusic(Menu menu) {
    char fullName[PLATFORM_MAX_PATH];
    char partialName[PLATFORM_MAX_PATH];

    for (int i = 0; i < SoundList_Size(); i++) {
        SoundList_Get(i, fullName);
        String_RemoveFileExtension(fullName, partialName);

        menu.AddItem("", partialName);
    }
}

bool Menu_IsValidTargetForPlay(int client, int target) {
    bool valid = target != INVALID_CLIENT;

    if (!valid) {
        Menu_SelectClientForPlay(client);
        Message_PlayerIsNoLongerAvailable(client);
    }

    return valid;
}
