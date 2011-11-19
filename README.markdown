# Scriptomatic.sugar

This Sugar is a simple proof of concept that provides a way to execute AppleScripts from FileActions and TextActions in Espresso. For FileActions, a list of all the selected file paths is passed to the AppleScript. TextActions similarly receive the selected text.

**Please note** that executing AppleScripts will currently block Espresso from running for the duration that the script runs. As a result, this is only particularly useful for small scripts that are very quick to execute.

## Installation

You can download a compiled version of Scriptomatic.sugar here:

<https://github.com/downloads/onecrayon/Scriptomatic-sugar/Scriptomatic.sugar.zip>

Alternatively, you can clone this GitHub repo, open the XCode project, and compile it yourself. If you have your Espresso application stored anywhere other than the root Applications directory, you will need to first modify the ESPRESSO_PATH build setting for the Scriptomatic target.

## Usage

On its own Scriptomatic.sugar does nothing. To use it, you will need to create your own custom Sugar containing the AppleScripts you wish access to along with XML definitions for their associated text or file actions in Espresso.

See the ExampleScripts.sugar included in this project for the bare minimum files you need to define your script sugar, and you can find documentation about the action XML here:

<http://wiki.macrabbit.com/index/ActionXML/>

Essentially, you will need an Info.plist file (to define your Sugar's identifier and version), a folder with your AppleScripts in it, and any FileAction or TextAction definitions that you need.

For AppleScripts run as FileActions you can access the URL of the project itself using the environment variable **EDITOR_PROJECT_PATH** using a snippet like this:

    on run argv
        set projectPath to system attribute "EDITOR_PROJECT_PATH"
        -- Do your actual AppleScript actions here
    end run

See the ExampleScripts.sugar for a working example. The following variables are currently available:

* EDITOR_PROJECT_PATH: the path to your project root folder
* EDITOR_SUGAR_PATH: the path to your custom sugar

## MIT License

Copyright (c) 2011 Ian Beck

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
