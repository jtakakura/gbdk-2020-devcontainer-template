# GBDK-2020 Devcontainer Template Repository

This is a GitHub repository template for [GBDK-2020](https://github.com/gbdk-2020/gbdk-2020).

It includes:

- build automation via [Make](https://www.gnu.org/software/make)
- [Visual Studio Code](https://code.visualstudio.com) configuration with [C/C++](https://code.visualstudio.com/docs/languages/cpp) and [Remote Container](https://code.visualstudio.com/docs/remote/containers) support.
- container include below tools and libraries.
    - [GBDK-2020](https://github.com/gbdk-2020/gbdk-2020)
    - [mod2gbt](https://github.com/AntonioND/gbt-player)
    - [pngb](https://github.com/Zal0/pngb)
    - [Gameboy Map Builder](http://www.devrs.com/gb/hmgd/gbmb.html)
    - [Gameboy Tile Designer](http://www.devrs.com/gb/hmgd/gbtd.html)
    - [BGB](https://bgb.bircd.org/)
    - [Emulicious](https://emulicious.net/)
- noVNC/VNC support.

## Getting started

1. Copy this repository by pressing the "Use this template" button in Github.
1. Clone your repository and rename .project.example to .project and set PROJECT_NAME in it.
1. Open the cloned directory in the latest [Visual Studio Code](https://code.visualstudio.com).
1. `F1` -> `Remote-Containers: Reopen in Container`.
1. Open localhost:6080 in your browser or connect a [VNC viewer](https://www.realvnc.com/en/connect/download/viewer/) to port 5901 after a container is created and started and type vscode for vnc-auth.

## Build

### Terminal

- `make` / `make release` - execute the release build pipeline for GB.
- `make color release` - execute the release build pipeline for GBC.
- `make debug` - execute the debug build pipeline for GB.
- `make color debug` - execute the debug build pipeline for GBC.
- `make clean` - execute to remove the output

### Visual Studio Code

`F1` → `Tasks: Run Build Task (Ctrl+Shift+B or ⇧⌘B)` to execute the build pipeline.

## Debug

### Visual Studio Code

`F5` to launch the debug build in Emulicious.

## Useful links
- [GBDK-2020 Docs](https://gbdk-2020.github.io/gbdk-2020/docs/api/index.html)
- [Game Boy Development community](https://gbdev.io/)
- [ZGB / GBDK Discord](https://discord.gg/XCbjCvqnUY)
