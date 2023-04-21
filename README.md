# Bonus round music

Allows you to play custom music at the end of the round

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/bonus-round-music/releases) (compiled for SourceMod 1.11)
* Extract "plugins" and "translations" folders to "addons/sourcemod" folder of your server

### Console Variables

* sm_bonusroundmusic_path - The path to custom music [default: "brm"]

### Notes

* File name must contain lowercase letters
* Nested directories are not supported
* Recommended bitrate: 128 kbps
* Recommended music duration: `dod_bonusroundtime` + 5 seconds
* Supported formats: mp3
* The new version of the file must have a different name
* Use `dod_playwinmusic` to enable/disable music at the end of a round
* Use `!settings` to control the type of music (default or custom)
