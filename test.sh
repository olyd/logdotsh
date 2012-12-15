# It's recommended to use absolute path when sourcing a script
. ./log.sh

echo "1. use default log settings"
echo

debug_msg "hello,world\n"
info_msg 'hello,world\n'
warn_msg 'hello,world\n'
error_msg 'hello,world\n'

echo
echo "2. set loglevel to $LOG_INFO"
echo

set_loglevel $LOG_INFO
debug_msg "hello,world\n"
info_msg 'hello,world\n'
warn_msg 'hello,world\n'
error_msg 'hello,world\n'

echo
echo "3. set log fmt to [<asctime> - <levelname>] <message>"
echo

set_logfmt "[<asctime> - <levelname>] <message>"
info_msg 'hello,world\n'
warn_msg 'hello,world\n'

echo
echo "4. set date fmt to %Y/%m/%d %H:%M:%S"
echo

set_datefmt "%Y/%m/%d %H:%M:%S"
info_msg 'hello,world\n'
warn_msg 'hello,world\n'

echo
echo "5. set log color to green blue '' yellow"
echo

set_loglevel $LOG_DEBUG
set_logcolor green blue '' yellow
debug_msg "hello,world\n"
info_msg 'hello,world\n'
warn_msg 'hello,world\n'
error_msg 'hello,world\n'

echo
echo "6. disable color"
echo

disable_color
debug_msg "hello,world\n"
info_msg 'hello,world\n'
warn_msg 'hello,world\n'
error_msg 'hello,world\n'

echo
echo '7. use colorful print'
echo

red "hello,world\n"
green "hello,world\n"
yellow "hello,world\n"
cyan "hello,world\n"
gray "hello,world\n"
purple "hello,world\n"
blue "hello,world\n"
white "hello,world\n"

echo
echo '8. exit script'
echo
exit_msg "exit script\n"
