[![Make Release](https://github.com/benthillerkus/SpaceLovers/actions/workflows/make-release.yml/badge.svg)](https://github.com/benthillerkus/SpaceLovers/actions/workflows/make-release.yml)
![GitHub top language](https://img.shields.io/github/languages/top/benthillerkus/SpaceLovers?logo=java)
![Lines of code](https://img.shields.io/tokei/lines/github/benthillerkus/SpaceLovers?color=orange)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/benthillerkus/SpaceLovers?color=purple)
![GitHub all releases](https://img.shields.io/github/downloads/benthillerkus/SpaceLovers/total)
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

Die Audiodateien in [data/GameplaySound](data/Art/GameplaySound) und [data/MenuSound](data/GameplaySound) sowie die Grafiken in [data/Art](data/Art) (kurz: die _Assets_) stehen unter der [Creative Commons BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc/4.0/).

Fertige Builds beinhalten die [Minim-Library](https://github.com/ddf/minim) unter der [LGPL v3.0](https://www.gnu.org/licenses/lgpl-3.0.en.html) und die [Processing-Sound-Library](https://github.com/processing/processing-sound) unter der [LGPL v2.1](https://www.gnu.org/licenses/lgpl-3.0.en.html). Zusätzlich dazu ist noch eine Java SE Runtime Environment dabei; deren Lizenzen sind im Unterordner `java` zu finden.

Alle Fonts in [data/Art/Fonts](data/Fonts) stehen unter der [OFL](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL).

----

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons Lizenzvertrag" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/80x15.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">SpaceLovers (Assets)</span> von <a xmlns:cc="http://creativecommons.org/ns#" href="https://www.github.com/benthillerkus/SpaceLovers" property="cc:attributionName" rel="cc:attributionURL">Bent Hillerkus, Joshua Lasse Einhoff, Natalie Turek, Kevin Kader</a> ist lizenziert unter einer <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Namensnennung - Nicht-kommerziell - Weitergabe unter gleichen Bedingungen 4.0 International Lizenz</a>.<br />Über diese Lizenz hinausgehende Erlaubnisse können Sie unter <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/benthillerkus/SpaceLovers#Lizensierung" rel="cc:morePermissions">https://github.com/benthillerkus/SpaceLovers#Lizensierung</a> erhalten.
