# RoMouseEvents
ROBLOX Module that provides an abstraction for alternative `gui.MouseEnter` &amp; `gui.MouseLeave` events. 

# Getting started

## Installation

### Method 1 (Recommended):

1. ```bash \n git clone "https://github.com/CozzyBro2/RoMouseEvents"```
2. Copy the `src` directory into your project directory with your file explorer. Or, perform a merge by other means
3. Initialize the rojo server

### Method 2:

1. Go to the [src/shared](/src/shared/) directory
2. Download a copy of `MouseEvents.lua`
3. Drag it into roblox

# Why?

The stock `gui.MouseEnter` and `gui.MouseLeave` events provided by roblox operate in undesirable ways for many.

Below is an example image, where on `MouseEnter`; a gui object's background color is set to white, and then back to black on `MouseLeave`:

![example](./Resources/mouseleave-weird.png)
