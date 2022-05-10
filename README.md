# RoMouseEvents
ROBLOX Module that provides an abstraction for alternative `gui.MouseEnter` &amp; `gui.MouseLeave` events. 

# Why?

The stock `gui.MouseEnter` and `gui.MouseLeave` events may not function ideally for some usages.

1. If the gui moves while considered entered, but your mouse doesn't move;
`MouseLeave` doesn't fire. Which can lead to "phantom entered" gui

2. More reasons may come, feel free to suggest any ones that should be added.

# Getting started

## Installation

### Method 1 (Recommended):

1. 
```bash
git clone "https://github.com/CozzyBro2/RoMouseEvents"
```
2. Copy the `src` directory into your project directory with your file explorer. Or perform a merge by other means
3. Initialize the rojo server

### Method 2:

1. Go to the [src/shared](/src/shared/) directory
2. Download a copy of `MouseEvents.lua`
3. Drag it into roblox

## Configuration

Many options in the module can be configured.

Configuration is done both through the `global_config` table in the module,
and through a configuration table passed as the second argument of `module.Listen`.

This table inherits and overwrites any values from `global_config` to keep usage simple,
meaning any changes made to the `global_config` will reflect to any future calls to `module.Listen`.

### Options:

* `allowMultiple: bool`

	* Whether the event can fire on a gui while another gui is currently entered.

	* Default: `false`

* `watchPosition: bool`

	* Whether the `AbsolutePosition` of the gui is listened to for changes while the gui is entered.
		Enabling this allows `MouseLeave` to fire if the gui moves but the InputDevice does not, the stock events lack this.

	* Default: `true`

* `eventsEnabled: bool`

	* When false, disables all custom behavior and falls back to the stock roblox events.

	* A case where you may use this would be if roblox ever improves
		their stock events; which would render custom behavior obsolete.

### Other config

* You can use the `MakeSignal` wrapper function to change the signal you use.
	* You can use any signal creator, i.e `BindableEvents`, or something like `GoodSignal` for example.

	* NOTE: Any custom signal should use similar or identical syntax to bindables

# API

* `module.Listen(gui: GuiObject, info?: dictionary)`
* `module.Release(gui: GuiObject)`

