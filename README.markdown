# Scriptomatic.sugar

This Sugar is a simple proof of concept that is **not currently intended for actual use**.

Basically all it does is provide a way to execute AppleScripts from FileActions that receive an argument list of all selected files. However, it does not behave very well (main issue being that it completely blocks Espresso from running for the duration the AppleScript runs), and I do not recommend you actually use it.

I am not sure yet if I will continue development on this; I threw it together just to see if it would work in response to a user feature request, and as it is not something that I have any interest in using myself I may or may not devote any further time to it.

In the possibility that someone else out there might want to take the idea and run with it, though, I've posted my initial code. If you do want to try and develop it into an actual Sugar here are some things to think about:

* The Sugar should not look for AppleScripts inside of itself. Ideally, it would instead look inside whatever bundle the FileAction is defined in (since then a user could install the Scriptomatic.sugar, and then create a custom Sugar for their particular AppleScript needs)
* If possible, AppleScripts should not block Espresso's execution. Not sure if this is actually possible, though; certainly nothing obvious came out of my initial searches
* It might be desirable to receive information beyond the paths of the selected files, pass paths as POSIX paths instead of Unix ones, or enable AppleScripts for TextActions instead of just FileActions.

## MIT License

Copyright (c) 2011 Ian Beck

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
