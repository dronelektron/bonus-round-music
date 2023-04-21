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
    char cookieValue[COOKIE_VALUE_SIZE];

    Cookie_GetMusicType(client, cookieValue);

    return strcmp(cookieValue, musicType) == 0 ? ITEMDRAW_DISABLED : ITEMDRAW_DEFAULT;
}
