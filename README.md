[![Make Release](https://github.com/benthillerkus/Asteroids/actions/workflows/make-release.yml/badge.svg)](https://github.com/benthillerkus/Asteroids/actions/workflows/make-release.yml)
![GitHub top language](https://img.shields.io/github/languages/top/benthillerkus/Asteroids?logo=java)
![Lines of code](https://img.shields.io/tokei/lines/github/benthillerkus/Asteroids?color=orange)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/benthillerkus/Asteroids?color=purple)
![GitHub all releases](https://img.shields.io/github/downloads/benthillerkus/Asteroids/total)
![Badge not Found](https://img.shields.io/badge/404-badge%20not%20found-red)
# Anleitung

## Installation

Es gibt fertige Binaries für Windows bei den [Releases](https://github.com/benthillerkus/SpaceLovers/releases).

Sonst kann man natürlich auch das Repo klonen / herunterladen und in Processing öffnen.
Es müssen dafür vorher folgende Libraries heruntergeladen werden:
- [processing-sound](https://github.com/processing/processing-sound)
- [minim](https://github.com/ddf/minim)

## Spielziel
Es müssen 3 Missionen abgeschlossen werden um die Position des Sprungpunktes freizuschalten. Wenn der Sprungpunkt erreicht wird, ist das Spiel gewonnen.
Wenn das Schiff vorher zu viel Schaden nimmt ist das Spiel verloren.

## Steuerung

### Spieler 1
1. Drehung mit `a` und `d`
2. Modi wechseln mit `w` und `s`
3. Leertaste um Aktionen auszuführen

### Spieler 2
2. Drehung mit `j` und `l`
3. Modi wechseln mit `i` und `k`
4. `.` um Aktionen auszuführen

# Lizensierung
Der Code im Repository steht unter der [GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0.en.html) bereit.
Fertige Builds beinhalten die [Minim-Library](https://github.com/ddf/minim) unter der [LGPL v3.0](https://www.gnu.org/licenses/lgpl-3.0.en.html) und die [Processing-Sound-Library](https://github.com/processing/processing-sound) unter der [LGPL v2.1](https://www.gnu.org/licenses/lgpl-3.0.en.html).

Alle Fonts in [data/Art/Fonts](data/Fonts) stehen unter der [OFL](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL).

Die Audiodateien in [data/GameplaySound](data/Art/GameplaySound) und [data/MenuSound](data/GameplaySound) sowie die Grafiken in [data/Art](data/Art) stehen unter der [Creative Commons BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc/4.0/).
