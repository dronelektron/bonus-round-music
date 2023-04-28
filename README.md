# Bonus round music

Allows you to play custom music at the end of the round

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/bonus-round-music/releases) (compiled for SourceMod 1.11)
* Extract "plugins" and "translations" folders to "addons/sourcemod" folder of your server

### Console Variables

* sm_bonusroundmusic_show_song_name - Show song name [default: "1"]

### File Requirements

* File name in lowercase
* File name does not contain any characters other than `-`
* File format: mp3
* Sampling frequency: 44.1 kHz
* Bitrate: 128 kbps
* Duration: `dod_bonusroundtime` + 5 seconds
* Audio track does not contain any effects
* Volume of the file should be at the level of standard music

### Notes

* Nested directories are not supported
* The new version of the file must have a different name
* Plugin config: `addons/sourcemod/configs/bonus-round-music.txt`
* Use `dod_playwinmusic` to enable/disable music at the end of the round
* Use `!settings` to control the type of music (default or custom)
