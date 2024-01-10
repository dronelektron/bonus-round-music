# Bonus round music

Allows you to play custom music at the end of the round or manually

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/bonus-round-music/releases) (compiled for SourceMod 1.11)
* Extract "plugins" and "translations" folders to "addons/sourcemod" folder of your server

### Console Variables

* sm_bonusroundmusic_path - Path to music without the `sound` folder [default: "brm"]
* sm_bonusroundmusic_chat_song_name - Show (yes - 1, no - 0) song name in chat [default: "1"]
* sm_bonusroundmusic_playback_order - Playback order (sequence - 0, random - 1) [default: "1"]
* sm_bonusroundmusic_history_mode - How long to store song history (map - 0, reboot - 1, file - 2) [default: "2"]

### Console Commands

* sm_brm_play_all - Play music for all players
* sm_brm_play - Play music for a specific player
* sm_brm_stop_all - Stop music for all players
* sm_brm_stop - Stop music for a specific player

### File Requirements

* File name in lowercase
* File name does not contain any characters other than `-`
* File format: mp3
* Sampling frequency: 44.1 kHz
* Bitrate: 128 kbps
* Audio track does not contain any sound effects
* Audio track does not contain any `ID3` fields

### Notes

* Nested directories are not supported
* The new version of the file must have a different name
* Use `dod_playwinmusic` to enable/disable music at the end of the round
* Use `!settings` to control the type of music (default or custom)

### History Mode

* `map` - store sounds history until map change
* `reboot` - store sounds history until server reboot
* `file` - store sounds history in file
