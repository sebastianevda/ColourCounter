# ColourCounter
Count pixel number if different from background within an area on screen as defined by mouse clicks

Requires AutoIT to run.

Written for windows 7 - in anything after windows 7 it is so slow its practically unusable (although with enough time, it will work).

To use:
Edit script to define default background color (Line 130, $color = 0xD1D1D1) - or can be defined in GUI

Run script to open GUI

Set background color if not hard coded in script (checking the manual color box, and input color).

Set shades of variation (from 0 to 255) using slider.

Open a blank excel document (without renaming it)

Prest start - follow instructions on screen tooltip in top left of screen (clicking above top left of image of interest and bottom right of image of interest)

Wait while script marks pixels on screen that differ from background (preset) by at least preset shades of variance.

Once finished, script will automatically enter data into excel, and is ready to recieve clicks for next image in the series.

Press escape at any time to kill, or PAUSE to pause
