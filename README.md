# RoMouseEvents
ROBLOX Module that provides an abstraction for alternative `gui.MouseEnter` &amp; `gui.MouseLeave` events. 

# Why?

The stock `gui.MouseEnter` and `gui.MouseLeave` events provided by roblox operate in undesirable ways for many.

Below is an example image, where on `MouseEnter`; a gui object's background color is set to white, and then back to black on `MouseLeave`:

![example](./Resources/mouseleave-weird.png)

Notice that two of the buttons are highlighted white at once. This is not intended behavior, and happens very frequently; especially on mobile.

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

	Whether the event can fire on another gui while a different gui is still entered.

	* Recommended: false
	* Default: false

### Other config

As documented in the module, you can use the `MakeEvent` wrapper function to change the signal you use.

From the module:

"Wrapper that you can modify to use a different signal creator. (such as 'GoodSignal', for example)
NOTE: Custom signal must be mostly syntactically identical to bindable events"

# How?

