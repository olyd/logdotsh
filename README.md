logdotsh
========

A simple log library written in shell

Basic Usage
===========

This library provides basic log functions like **debug_msg**, **info_msg**, **warn_msg** and **error_msg**.

 debug_msg: prints some debug messeges when debug your scripts.
* info_msg: prints some information messages to indicate some key code in the scripts.
* warn_msg: prints some warning messages to tell invalid input or unexpected result.
* error_msg: prints some error messages when the result is wrong.

Use these function is very simple, first you need to source this library:

    source ./log.sh

then you only need to pass the log messages as the argument:

    debug_msg "Print debug messages\n"
    info_msg "Print information messages\n"
    warn_msg "Print warning messages\n"
    error_msg "Print error messages\n"

Note: don't forget the newline(\n) in the end. Because it uses printf to print log messages.

The prints result is like bellow:
    
    [DEBUG] Print debug messages
    [INFO] Print information messages
    [WARNING] Print warning messages
    [ERROR] Print error messages

The prompt, like '[DEBUG]', '[INFO]', indicates the log message type. If you runnig
the above codes in the shell, the promt will be printed with different colors.

But if you want to exit the running script when an error occurs? you must writing follow codes:

    error_msg "An unexpected error occurs\n"
    exit 1

Isn't it very troublesome? So this library also gives a convenient function named **exit_msg** to meet 
this need. With **exit_msg**, the code is like bellow:

    exit_msg "An unexpected error occurs\n"

After printing the error messages to the stdout, the script will exit immediately.

Advanced Usage
==============

Format string
-------------

Because the functions use printf to print log messages, so they can take advantage of the printf function,
that is to format string. 

    debug_msg "Hello, %s\n" "world"
    debug_msg "%15s, %15s\n" "key" "value"

The output is:

    [DEBUG] Hello, world
    [DEBUG]             key,           value

You can read the printf manual for more help in the [string format syntax][1].

Colorful print
--------------

In this library, there are several colorful print functions, it will print the message in specified color.

* gray
* red
* yellow
* blue
* green
* purple
* cyan

You can pick each one as you like to print some colorful messages to attract attention.

Disable color
-------------

Someone may dislike the colorful log, and in some cases, like redirecting the log output to a file, the color
escape string will also appended to the file, it may be very annoyed.

You can use **disable_color** to disable colorful log:

    disable_color

Set log level
-------------

If you doesn't want to see debug messages when running, how can you do? Each log type has a defined log level in the
library. From low to high, it is LOG_ERROR, LOG_WARN, LOG_INFO and LOG_DEBUG respectively.

You can use **set_loglevel** to set the maximum log level, and it will only print log messages whose level is lower 
than the log level set.

So back to the problem mentioned in the beginning, we can use **set_loglevel** to prohibit printing debug messages:

    set_loglevel $LOG_INFO

Set log format
--------------

This library provides only several placeholders for formating log, that is
'&lt;levelname&gt;', '&lt;asctime&gt;' and '&lt;message&gt;'. You can use **set_logfmt** to
change the default log format:

    set_logfmt '[<asctime> - <levelname>] <message>'

The default log format is '[<levelname>] [<asctime>] <message>'.

Set date format
---------------

You can use **set_datefmt** to change the default date format in the log
printed:

    set_datefmt '%Y/%m/%d %H:%M:%S'

See 'man date' for more help about the format syntax. The default date format
is '%Y-%m-%d %H:%M:%S'.

Note: If you don't specify '<asctime>' in the log format, then this will take
no effect.

Set log color
--------------

You can use **set_logcolor** to change the default color settings:

    set_logcolor red yellow green blue

From low log level to high, it will set error log to red, warning log to yellow,
info log to green and debug log to blue.

The valid color values can be any name of the colorful print functions listed
in above or empty string. The empty string indicates to print log without
color, below is the same as **disable_color**:

    set_logcolor '' '' '' ''

[1]: http://wiki.bash-hackers.org/commands/builtin/printf "The printf command"
