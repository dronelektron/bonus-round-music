# Bonus round music

Allows you to play custom music at the end of the round

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/bonus-round-music/releases) (compiled for SourceMod 1.11)
* Extract "plugins" and "translations" folders to "addons/sourcemod" folder of your server

### Console Variables

* sm_bonusroundmusic_path - Path to music without the `sound` folder [default: "brm"]
* sm_bonusroundmusic_show_song_name - Show song name [default: "1"]

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
* Audio track does not contain any `ID3` fields (metadata)

### Notes

* Nested directories are not supported
* The new version of the file must have a different name
* Use `dod_playwinmusic` to enable/disable music at the end of the round
* Use `!settings` to control the type of music (default or custom)
