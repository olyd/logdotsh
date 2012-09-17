. ./log.sh

debug_msg "Print debug messages\n"
info_msg "Print information messages\n"
warn_msg "Print warning messages\n"
error_msg "Print error messages\n"

debug_msg "Hello, %s\n" "world"
debug_msg "%15s, %15s\n" "key" "value"

exit_msg "An unexpected error occurs\n"
