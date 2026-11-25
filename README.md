# SeneaL UI Game Update Patcher

An unofficial patcher that keeps **SeneaL UI 1.2.8** working after Valheim updates. It is not made by SeneaL UI's author.

## What it fixes

**Valheim 1.0.30** renamed a piece of the game's F2 connection panel that SeneaL UI 1.2.8 looks for on every frame.
Without this patcher, on 1.0.30:

- Escape does not open the pause menu, so you cannot reach Settings, Log out or Quit game;
- the F2 statistics panel does not open;
- the log fills with `MissingFieldException: Field not found: UnityEngine.Transform .ConnectPanel.m_root`.

With it, the pause menu and SeneaL UI's statistics panel work as before.

## How it works

It is a BepInEx *preloader patcher*: it runs before the game's code is loaded and puts the old name back beside the new
one, in memory only. No file of the game or of SeneaL UI is changed. On a game version that does not have the rename it
does nothing, and it says which in the log (`[Info :SeneaL UI Game Update Patcher] ...`).

## What it does not do

- It fixes SeneaL UI only. Other mods broken by the game update need their own updates.

## Checked

On Valheim 1.0.30 with SeneaL UI 1.2.8 and SeneaL API 1.2.0 only: main menu, a new character and world, the pause menu,
F2 statistics, inventory, world map, settings (the new *Brighten dark environments* and *Particle lights* settings are
there), console and build menu, with no error in the log. Not checked: a gamepad, multiplayer, a dedicated server.

## Install

With a mod manager, or by hand: put `seneaL_UI_GameUpdatePatcher.dll` into `BepInEx\patchers`. It is needed on every
client that runs SeneaL UI; a server without SeneaL UI's interface does not need it.

## Downloads

- Thunderstore: https://thunderstore.io/c/valheim/p/SatanicPanic/SeneaL_UI_Game_Update_Patcher/
- Hexium: https://valheim.hexium.gg/mods/SatanicPanic/SeneaL_UI_Game_Update_Patcher
- Nexus Mods: https://www.nexusmods.com/valheim/mods/5022

## Source and building

The whole patcher is `src/Patcher.cs`. It needs `BepInEx.dll` and `Mono.Cecil.dll` from a BepInEx 5 install:

```
dotnet build src -c Release -p:ValheimDevPath=<a folder that holds BepInEx\core>
```

`Patcher.Apply(ModuleDefinition)` is separate from the BepInEx entry point, so the patch can be run on a copy of the
game's `assembly_valheim.dll` outside the game. To add a fix for a later game update, add one method beside
`ConnectPanelRoot` and call it from `Apply`; each fix must do nothing when the game does not have the change it is for.

`icon-src/` holds the icon's source (SVG in HTML, rendered with headless Chrome).

## Licence

MIT. Not affiliated with SeneaL UI or its author.
