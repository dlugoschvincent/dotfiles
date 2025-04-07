# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_wezterm_global_optspecs
	string join \n n/skip-config config-file= config= h/help V/version
end

function __fish_wezterm_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_wezterm_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_wezterm_using_subcommand
	set -l cmd (__fish_wezterm_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c wezterm -n "__fish_wezterm_needs_command" -l config-file -d 'Specify the configuration file to use, overrides the normal configuration file resolution' -r -F
complete -c wezterm -n "__fish_wezterm_needs_command" -l config -d 'Override specific configuration values' -r
complete -c wezterm -n "__fish_wezterm_needs_command" -s n -l skip-config -d 'Skip loading wezterm.lua'
complete -c wezterm -n "__fish_wezterm_needs_command" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_needs_command" -s V -l version -d 'Print version'
complete -c wezterm -n "__fish_wezterm_needs_command" -f -a "start" -d 'Start the GUI, optionally running an alternative program [aliases: -e]'
complete -c wezterm -n "__fish_wezterm_needs_command" -f -a "blocking-start" -d 'Start the GUI in blocking mode. You shouldn\'t see this, but you may see it in shell completions because of this open clap issue: <https://github.com/clap-rs/clap/issues/1335>'
complete -c wezterm -n "__fish_wezterm_needs_command" -f -a "ssh" -d 'Establish an ssh session'
complete -c wezterm -n "__fish_wezterm_needs_command" -f -a "serial" -d 'Open a serial port'
complete -c wezterm -n "__fish_wezterm_needs_command" -f -a "connect" -d 'Connect to wezterm multiplexer'
complete -c wezterm -n "__fish_wezterm_needs_command" -f -a "ls-fonts" -d 'Display information about fonts'
complete -c wezterm -n "__fish_wezterm_needs_command" -f -a "show-keys" -d 'Show key assignments'
complete -c wezterm -n "__fish_wezterm_needs_command" -f -a "cli" -d 'Interact with experimental mux server'
complete -c wezterm -n "__fish_wezterm_needs_command" -f -a "imgcat" -d 'Output an image to the terminal'
complete -c wezterm -n "__fish_wezterm_needs_command" -f -a "set-working-directory" -d 'Advise the terminal of the current working directory by emitting an OSC 7 escape sequence'
complete -c wezterm -n "__fish_wezterm_needs_command" -f -a "record" -d 'Record a terminal session as an asciicast'
complete -c wezterm -n "__fish_wezterm_needs_command" -f -a "replay" -d 'Replay an asciicast terminal session'
complete -c wezterm -n "__fish_wezterm_needs_command" -f -a "shell-completion" -d 'Generate shell completion information'
complete -c wezterm -n "__fish_wezterm_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c wezterm -n "__fish_wezterm_using_subcommand start" -l cwd -d 'Specify the current working directory for the initially spawned program' -r -f -a "(__fish_complete_directories)"
complete -c wezterm -n "__fish_wezterm_using_subcommand start" -l class -d 'Override the default windowing system class. The default is "org.wezfurlong.wezterm". Under X11 and Windows this changes the window class. Under Wayland this changes the app_id. This changes the class for all windows spawned by this instance of wezterm, including error, update and ssh authentication dialogs' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand start" -l workspace -d 'Override the default workspace with the provided name. The default is "default"' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand start" -l position -d 'Override the position for the initial window launched by this process.' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand start" -l domain -d 'Name of the multiplexer domain section from the configuration to which you\'d like to connect. If omitted, the default domain will be used' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand start" -l no-auto-connect -d 'If true, do not connect to domains marked as connect_automatically in your wezterm configuration file'
complete -c wezterm -n "__fish_wezterm_using_subcommand start" -l always-new-process -d 'If enabled, don\'t try to ask an existing wezterm GUI instance to start the command.  Instead, always start the GUI in this invocation of wezterm so that you can wait for the command to complete by waiting for this wezterm process to finish'
complete -c wezterm -n "__fish_wezterm_using_subcommand start" -l new-tab -d 'When spawning into an existing GUI instance, spawn a new tab into the active window rather than spawn a new window'
complete -c wezterm -n "__fish_wezterm_using_subcommand start" -s e -d 'Dummy argument that consumes "-e" and does nothing. This is meant as a compatibility layer for supporting the widely adopted standard of passing the command to execute to the terminal via a "-e" option. This works because we then treat the remaining cmdline as trailing options, that will automatically be parsed via the existing "prog" option. This option exists only as a fallback. It is recommended to pass the command as a normal trailing command instead if possible'
complete -c wezterm -n "__fish_wezterm_using_subcommand start" -l attach -d 'When used with --domain, if the domain already has running panes, wezterm will simply attach and will NOT spawn the specified PROG. If you omit --attach when using --domain, wezterm will attach AND then spawn PROG'
complete -c wezterm -n "__fish_wezterm_using_subcommand start" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wezterm -n "__fish_wezterm_using_subcommand blocking-start" -l cwd -d 'Specify the current working directory for the initially spawned program' -r -f -a "(__fish_complete_directories)"
complete -c wezterm -n "__fish_wezterm_using_subcommand blocking-start" -l class -d 'Override the default windowing system class. The default is "org.wezfurlong.wezterm". Under X11 and Windows this changes the window class. Under Wayland this changes the app_id. This changes the class for all windows spawned by this instance of wezterm, including error, update and ssh authentication dialogs' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand blocking-start" -l workspace -d 'Override the default workspace with the provided name. The default is "default"' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand blocking-start" -l position -d 'Override the position for the initial window launched by this process.' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand blocking-start" -l domain -d 'Name of the multiplexer domain section from the configuration to which you\'d like to connect. If omitted, the default domain will be used' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand blocking-start" -l no-auto-connect -d 'If true, do not connect to domains marked as connect_automatically in your wezterm configuration file'
complete -c wezterm -n "__fish_wezterm_using_subcommand blocking-start" -l always-new-process -d 'If enabled, don\'t try to ask an existing wezterm GUI instance to start the command.  Instead, always start the GUI in this invocation of wezterm so that you can wait for the command to complete by waiting for this wezterm process to finish'
complete -c wezterm -n "__fish_wezterm_using_subcommand blocking-start" -l new-tab -d 'When spawning into an existing GUI instance, spawn a new tab into the active window rather than spawn a new window'
complete -c wezterm -n "__fish_wezterm_using_subcommand blocking-start" -s e -d 'Dummy argument that consumes "-e" and does nothing. This is meant as a compatibility layer for supporting the widely adopted standard of passing the command to execute to the terminal via a "-e" option. This works because we then treat the remaining cmdline as trailing options, that will automatically be parsed via the existing "prog" option. This option exists only as a fallback. It is recommended to pass the command as a normal trailing command instead if possible'
complete -c wezterm -n "__fish_wezterm_using_subcommand blocking-start" -l attach -d 'When used with --domain, if the domain already has running panes, wezterm will simply attach and will NOT spawn the specified PROG. If you omit --attach when using --domain, wezterm will attach AND then spawn PROG'
complete -c wezterm -n "__fish_wezterm_using_subcommand blocking-start" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wezterm -n "__fish_wezterm_using_subcommand ssh" -s o -l ssh-option -d 'Override specific SSH configuration options. `wezterm ssh` is able to parse some (but not all!) options from your `~/.ssh/config` and `/etc/ssh/ssh_config` files. This command line switch allows you to override or otherwise specify ssh_config style options' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand ssh" -l class -d 'Override the default windowing system class. The default is "org.wezfurlong.wezterm". Under X11 and Windows this changes the window class. Under Wayland this changes the app_id. This changes the class for all windows spawned by this instance of wezterm, including error, update and ssh authentication dialogs' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand ssh" -l position -d 'Override the position for the initial window launched by this process.' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand ssh" -s v -d 'Enable verbose ssh protocol tracing. The trace information is printed to the stderr stream of the process'
complete -c wezterm -n "__fish_wezterm_using_subcommand ssh" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wezterm -n "__fish_wezterm_using_subcommand serial" -l baud -d 'Set the baud rate.  The default is 9600 baud' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand serial" -l class -d 'Override the default windowing system class. The default is "org.wezfurlong.wezterm". Under X11 and Windows this changes the window class. Under Wayland this changes the app_id. This changes the class for all windows spawned by this instance of wezterm, including error, update and ssh authentication dialogs' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand serial" -l position -d 'Override the position for the initial window launched by this process.' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand serial" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wezterm -n "__fish_wezterm_using_subcommand connect" -l class -d 'Override the default windowing system class. The default is "org.wezfurlong.wezterm". Under X11 and Windows this changes the window class. Under Wayland this changes the app_id. This changes the class for all windows spawned by this instance of wezterm, including error, update and ssh authentication dialogs' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand connect" -l workspace -d 'Override the default workspace with the provided name. The default is "default"' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand connect" -l position -d 'Override the position for the initial window launched by this process.' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand connect" -l new-tab -d 'When spawning into an existing GUI instance, spawn a new tab into the active window rather than spawn a new window'
complete -c wezterm -n "__fish_wezterm_using_subcommand connect" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wezterm -n "__fish_wezterm_using_subcommand ls-fonts" -l text -d 'Explain which fonts are used to render the supplied text string' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand ls-fonts" -l codepoints -d 'Explain which fonts are used to render the specified unicode code point sequence. Code points are comma separated hex values' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand ls-fonts" -l list-system -d 'Whether to list all fonts available to the system'
complete -c wezterm -n "__fish_wezterm_using_subcommand ls-fonts" -l rasterize-ascii -d 'Show rasterized glyphs for the text in --text or --codepoints using ascii blocks'
complete -c wezterm -n "__fish_wezterm_using_subcommand ls-fonts" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand show-keys" -l key-table -d 'In lua mode, show only the named key table' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand show-keys" -l lua -d 'Show the keys as lua config statements'
complete -c wezterm -n "__fish_wezterm_using_subcommand show-keys" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -l class -d 'When connecting to a gui instance, if you started the gui with `--class SOMETHING`, you should also pass that same value here in order for the client to find the correct gui instance' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -l no-auto-start -d 'Don\'t automatically start the server'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -l prefer-mux -d 'Prefer connecting to a background mux server. The default is to prefer connecting to a running wezterm gui instance'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "list" -d 'list windows, tabs and panes'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "list-clients" -d 'list clients'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "proxy" -d 'start rpc proxy pipe'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "tlscreds" -d 'obtain tls credentials'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "move-pane-to-new-tab" -d 'Move a pane into a new tab'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "split-pane" -d 'split the current pane. Outputs the pane-id for the newly created pane on success'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "spawn" -d 'Spawn a command into a new window or tab Outputs the pane-id for the newly created pane on success'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "send-text" -d 'Send text to a pane as though it were pasted. If bracketed paste mode is enabled in the pane, then the text will be sent as a bracketed paste'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "get-text" -d 'Retrieves the textual content of a pane and output it to stdout'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "activate-pane-direction" -d 'Activate an adjacent pane in the specified direction'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "get-pane-direction" -d 'Determine the adjacent pane in the specified direction'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "kill-pane" -d 'Kill a pane'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "activate-pane" -d 'Activate (focus) a pane'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "adjust-pane-size" -d 'Adjust the size of a pane directionally'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "activate-tab" -d 'Activate a tab'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "set-tab-title" -d 'Change the title of a tab'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "set-window-title" -d 'Change the title of a window'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "rename-workspace" -d 'Rename a workspace'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "zoom-pane" -d 'Zoom, unzoom, or toggle zoom state'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and not __fish_seen_subcommand_from list list-clients proxy tlscreds move-pane-to-new-tab split-pane spawn send-text get-text activate-pane-direction get-pane-direction kill-pane activate-pane adjust-pane-size activate-tab set-tab-title set-window-title rename-workspace zoom-pane help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from list" -l format -d 'Controls the output format. "table" and "json" are possible formats' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from list-clients" -l format -d 'Controls the output format. "table" and "json" are possible formats' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from list-clients" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from proxy" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from tlscreds" -l pem -d 'Output a PEM file encoded copy of the credentials'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from tlscreds" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from move-pane-to-new-tab" -l pane-id -d 'Specify the pane that should be moved. The default is to use the current pane based on the environment variable WEZTERM_PANE' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from move-pane-to-new-tab" -l window-id -d 'Specify the window into which the new tab will be created. If omitted, the window associated with the current pane is used' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from move-pane-to-new-tab" -l workspace -d 'If creating a new window, override the default workspace name with the provided name.  The default name is "default"' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from move-pane-to-new-tab" -l new-window -d 'Create tab in a new window, rather than the window currently containing the pane'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from move-pane-to-new-tab" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from split-pane" -l pane-id -d 'Specify the pane that should be split. The default is to use the current pane based on the environment variable WEZTERM_PANE' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from split-pane" -l cells -d 'The number of cells that the new split should have. If omitted, 50% of the available space is used' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from split-pane" -l percent -d 'Specify the number of cells that the new split should have, expressed as a percentage of the available space' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from split-pane" -l cwd -d 'Specify the current working directory for the initially spawned program' -r -f -a "(__fish_complete_directories)"
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from split-pane" -l move-pane-id -d 'Instead of spawning a new command, move the specified pane into the newly created split' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from split-pane" -l horizontal -d 'Equivalent to `--right`. If neither this nor any other direction is specified, the default is equivalent to `--bottom`'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from split-pane" -l left -d 'Split horizontally, with the new pane on the left'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from split-pane" -l right -d 'Split horizontally, with the new pane on the right'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from split-pane" -l top -d 'Split vertically, with the new pane on the top'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from split-pane" -l bottom -d 'Split vertically, with the new pane on the bottom'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from split-pane" -l top-level -d 'Rather than splitting the active pane, split the entire window'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from split-pane" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from spawn" -l pane-id -d 'Specify the current pane. The default is to use the current pane based on the environment variable WEZTERM_PANE. The pane is used to determine the current domain and window' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from spawn" -l domain-name -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from spawn" -l window-id -d 'Specify the window into which to spawn a tab. If omitted, the window associated with the current pane is used. Cannot be used with `--workspace` or `--new-window`' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from spawn" -l cwd -d 'Specify the current working directory for the initially spawned program' -r -f -a "(__fish_complete_directories)"
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from spawn" -l workspace -d 'When creating a new window, override the default workspace name with the provided name.  The default name is "default". Requires `--new-window`' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from spawn" -l new-window -d 'Spawn into a new window, rather than a new tab'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from spawn" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from send-text" -l pane-id -d 'Specify the target pane. The default is to use the current pane based on the environment variable WEZTERM_PANE' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from send-text" -l no-paste -d 'Send the text directly, rather than as a bracketed paste'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from send-text" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from get-text" -l pane-id -d 'Specify the target pane. The default is to use the current pane based on the environment variable WEZTERM_PANE' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from get-text" -l start-line -d 'The starting line number. 0 is the first line of terminal screen. Negative numbers proceed backwards into the scrollback. The default value is unspecified is 0, the first line of the terminal screen' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from get-text" -l end-line -d 'The ending line number. 0 is the first line of terminal screen. Negative numbers proceed backwards into the scrollback. The default value if unspecified is the bottom of the the terminal screen' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from get-text" -l escapes -d 'Include escape sequences that color and style the text. If omitted, unattributed text will be returned'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from get-text" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from activate-pane-direction" -l pane-id -d 'Specify the current pane. The default is to use the current pane based on the environment variable WEZTERM_PANE' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from activate-pane-direction" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from get-pane-direction" -l pane-id -d 'Specify the current pane. The default is to use the current pane based on the environment variable WEZTERM_PANE' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from get-pane-direction" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from kill-pane" -l pane-id -d 'Specify the target pane. The default is to use the current pane based on the environment variable WEZTERM_PANE' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from kill-pane" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from activate-pane" -l pane-id -d 'Specify the target pane. The default is to use the current pane based on the environment variable WEZTERM_PANE' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from activate-pane" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from adjust-pane-size" -l pane-id -d 'Specify the target pane. The default is to use the current pane based on the environment variable WEZTERM_PANE' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from adjust-pane-size" -l amount -d 'Specify the number of cells to resize by, defaults to 1' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from adjust-pane-size" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from activate-tab" -l tab-id -d 'Specify the target tab by its id' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from activate-tab" -l tab-index -d 'Specify the target tab by its index within the window that holds the current pane. Indices are 0-based, with 0 being the left-most tab. Negative numbers can be used to reference the right-most tab, so -1 is the right-most tab, -2 is the penultimate tab and so on' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from activate-tab" -l tab-relative -d 'Specify the target tab by its relative offset. -1 selects the tab to the left. -2 two tabs to the left. 1 is one tab to the right and so on' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from activate-tab" -l pane-id -d 'Specify the current pane. The default is to use the current pane based on the environment variable WEZTERM_PANE' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from activate-tab" -l no-wrap -d 'When used with tab-relative, prevents wrapping around and will instead clamp to the left-most when moving left or right-most when moving right'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from activate-tab" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from set-tab-title" -l tab-id -d 'Specify the target tab by its id' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from set-tab-title" -l pane-id -d 'Specify the current pane. The default is to use the current pane based on the environment variable WEZTERM_PANE' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from set-tab-title" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from set-window-title" -l window-id -d 'Specify the target window by its id' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from set-window-title" -l pane-id -d 'Specify the current pane. The default is to use the current pane based on the environment variable WEZTERM_PANE' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from set-window-title" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from rename-workspace" -l workspace -d 'Specify the workspace to rename' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from rename-workspace" -l pane-id -d 'Specify the current pane. The default is to use the current pane based on the environment variable WEZTERM_PANE' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from rename-workspace" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from zoom-pane" -l pane-id -d 'Specify the target pane. The default is to use the current pane based on the environment variable WEZTERM_PANE' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from zoom-pane" -l zoom -d 'Zooms the pane if it wasn\'t already zoomed'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from zoom-pane" -l unzoom -d 'Unzooms the pane if it was zoomed'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from zoom-pane" -l toggle -d 'Toggles the zoom state of the pane'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from zoom-pane" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "list" -d 'list windows, tabs and panes'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "list-clients" -d 'list clients'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "proxy" -d 'start rpc proxy pipe'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "tlscreds" -d 'obtain tls credentials'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "move-pane-to-new-tab" -d 'Move a pane into a new tab'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "split-pane" -d 'split the current pane. Outputs the pane-id for the newly created pane on success'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "spawn" -d 'Spawn a command into a new window or tab Outputs the pane-id for the newly created pane on success'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "send-text" -d 'Send text to a pane as though it were pasted. If bracketed paste mode is enabled in the pane, then the text will be sent as a bracketed paste'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "get-text" -d 'Retrieves the textual content of a pane and output it to stdout'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "activate-pane-direction" -d 'Activate an adjacent pane in the specified direction'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "get-pane-direction" -d 'Determine the adjacent pane in the specified direction'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "kill-pane" -d 'Kill a pane'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "activate-pane" -d 'Activate (focus) a pane'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "adjust-pane-size" -d 'Adjust the size of a pane directionally'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "activate-tab" -d 'Activate a tab'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "set-tab-title" -d 'Change the title of a tab'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "set-window-title" -d 'Change the title of a window'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "rename-workspace" -d 'Rename a workspace'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "zoom-pane" -d 'Zoom, unzoom, or toggle zoom state'
complete -c wezterm -n "__fish_wezterm_using_subcommand cli; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c wezterm -n "__fish_wezterm_using_subcommand imgcat" -l width -d 'Specify the display width; defaults to "auto" which automatically selects an appropriate size.  You may also use an integer value `N` to specify the number of cells, or `Npx` to specify the number of pixels, or `N%` to size relative to the terminal width' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand imgcat" -l height -d 'Specify the display height; defaults to "auto" which automatically selects an appropriate size.  You may also use an integer value `N` to specify the number of cells, or `Npx` to specify the number of pixels, or `N%` to size relative to the terminal height' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand imgcat" -l position -d 'Set the cursor position prior to displaying the image. The default is to use the current cursor position. Coordinates are expressed in cells with 0,0 being the top left cell position' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand imgcat" -l tmux-passthru -d 'How to manage passing the escape through to tmux' -r -f -a "disable\t''
enable\t''
detect\t''"
complete -c wezterm -n "__fish_wezterm_using_subcommand imgcat" -l max-pixels -d 'Set the maximum number of pixels per image frame. Images will be scaled down so that they do not exceed this size, unless `--no-resample` is also used. The default value matches the limit set by wezterm. Note that resampling the image here will reduce any animated images to a single frame' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand imgcat" -l resample-format -d 'Specify the image format to use to encode resampled/resized images.  The default is to match the input format, but you can choose an alternative format' -r -f -a "png\t''
jpeg\t''
input\t''"
complete -c wezterm -n "__fish_wezterm_using_subcommand imgcat" -l resample-filter -d 'Specify the filtering technique used when resizing/resampling images.  The default is a reasonable middle ground of speed and quality' -r -f -a "nearest\t''
triangle\t''
catmull-rom\t''
gaussian\t''
lanczos3\t''"
complete -c wezterm -n "__fish_wezterm_using_subcommand imgcat" -l resize -d 'Pre-process the image to resize it to the specified dimensions, expressed as eg: 800x600 (width x height). The resize is independent of other parameters that control the image placement and dimensions in the terminal; this is provided as a convenience preprocessing step' -r
complete -c wezterm -n "__fish_wezterm_using_subcommand imgcat" -l no-preserve-aspect-ratio -d 'Do not respect the aspect ratio.  The default is to respect the aspect ratio'
complete -c wezterm -n "__fish_wezterm_using_subcommand imgcat" -l no-move-cursor -d 'Do not move the cursor after displaying the image. Note that when used like this from the shell, there is a very high chance that shell prompt will overwrite the image; you may wish to also use `--hold` in that case'
complete -c wezterm -n "__fish_wezterm_using_subcommand imgcat" -l hold -d 'Wait for enter to be pressed after displaying the image'
complete -c wezterm -n "__fish_wezterm_using_subcommand imgcat" -l no-resample -d 'Do not resample images whose frames are larger than the max-pixels value. Note that this will typically result in the image refusing to display in wezterm'
complete -c wezterm -n "__fish_wezterm_using_subcommand imgcat" -l show-resample-timing -d 'When resampling or resizing, display some diagnostics around the timing/performance of that operation'
complete -c wezterm -n "__fish_wezterm_using_subcommand imgcat" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wezterm -n "__fish_wezterm_using_subcommand set-working-directory" -l tmux-passthru -d 'How to manage passing the escape through to tmux' -r -f -a "disable\t''
enable\t''
detect\t''"
complete -c wezterm -n "__fish_wezterm_using_subcommand set-working-directory" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand record" -l cwd -d 'Start in the specified directory, instead of the default_cwd defined by your wezterm configuration' -r -F
complete -c wezterm -n "__fish_wezterm_using_subcommand record" -s o -d 'Save asciicast to the specified file, instead of using a random file name in the temp directory' -r -F
complete -c wezterm -n "__fish_wezterm_using_subcommand record" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand replay" -l explain -d 'Explain what is being sent/received'
complete -c wezterm -n "__fish_wezterm_using_subcommand replay" -l explain-only -d 'Don\'t replay, just show the explanation'
complete -c wezterm -n "__fish_wezterm_using_subcommand replay" -l cat -d 'Just emit raw escape sequences all at once, with no timing information'
complete -c wezterm -n "__fish_wezterm_using_subcommand replay" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand shell-completion" -l shell -d 'Which shell to generate for' -r -f -a "bash\t''
elvish\t''
fish\t''
power-shell\t''
zsh\t''
fig\t''"
complete -c wezterm -n "__fish_wezterm_using_subcommand shell-completion" -s h -l help -d 'Print help'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and not __fish_seen_subcommand_from start blocking-start ssh serial connect ls-fonts show-keys cli imgcat set-working-directory record replay shell-completion help" -f -a "start" -d 'Start the GUI, optionally running an alternative program [aliases: -e]'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and not __fish_seen_subcommand_from start blocking-start ssh serial connect ls-fonts show-keys cli imgcat set-working-directory record replay shell-completion help" -f -a "blocking-start" -d 'Start the GUI in blocking mode. You shouldn\'t see this, but you may see it in shell completions because of this open clap issue: <https://github.com/clap-rs/clap/issues/1335>'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and not __fish_seen_subcommand_from start blocking-start ssh serial connect ls-fonts show-keys cli imgcat set-working-directory record replay shell-completion help" -f -a "ssh" -d 'Establish an ssh session'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and not __fish_seen_subcommand_from start blocking-start ssh serial connect ls-fonts show-keys cli imgcat set-working-directory record replay shell-completion help" -f -a "serial" -d 'Open a serial port'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and not __fish_seen_subcommand_from start blocking-start ssh serial connect ls-fonts show-keys cli imgcat set-working-directory record replay shell-completion help" -f -a "connect" -d 'Connect to wezterm multiplexer'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and not __fish_seen_subcommand_from start blocking-start ssh serial connect ls-fonts show-keys cli imgcat set-working-directory record replay shell-completion help" -f -a "ls-fonts" -d 'Display information about fonts'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and not __fish_seen_subcommand_from start blocking-start ssh serial connect ls-fonts show-keys cli imgcat set-working-directory record replay shell-completion help" -f -a "show-keys" -d 'Show key assignments'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and not __fish_seen_subcommand_from start blocking-start ssh serial connect ls-fonts show-keys cli imgcat set-working-directory record replay shell-completion help" -f -a "cli" -d 'Interact with experimental mux server'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and not __fish_seen_subcommand_from start blocking-start ssh serial connect ls-fonts show-keys cli imgcat set-working-directory record replay shell-completion help" -f -a "imgcat" -d 'Output an image to the terminal'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and not __fish_seen_subcommand_from start blocking-start ssh serial connect ls-fonts show-keys cli imgcat set-working-directory record replay shell-completion help" -f -a "set-working-directory" -d 'Advise the terminal of the current working directory by emitting an OSC 7 escape sequence'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and not __fish_seen_subcommand_from start blocking-start ssh serial connect ls-fonts show-keys cli imgcat set-working-directory record replay shell-completion help" -f -a "record" -d 'Record a terminal session as an asciicast'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and not __fish_seen_subcommand_from start blocking-start ssh serial connect ls-fonts show-keys cli imgcat set-working-directory record replay shell-completion help" -f -a "replay" -d 'Replay an asciicast terminal session'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and not __fish_seen_subcommand_from start blocking-start ssh serial connect ls-fonts show-keys cli imgcat set-working-directory record replay shell-completion help" -f -a "shell-completion" -d 'Generate shell completion information'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and not __fish_seen_subcommand_from start blocking-start ssh serial connect ls-fonts show-keys cli imgcat set-working-directory record replay shell-completion help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "list" -d 'list windows, tabs and panes'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "list-clients" -d 'list clients'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "proxy" -d 'start rpc proxy pipe'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "tlscreds" -d 'obtain tls credentials'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "move-pane-to-new-tab" -d 'Move a pane into a new tab'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "split-pane" -d 'split the current pane. Outputs the pane-id for the newly created pane on success'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "spawn" -d 'Spawn a command into a new window or tab Outputs the pane-id for the newly created pane on success'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "send-text" -d 'Send text to a pane as though it were pasted. If bracketed paste mode is enabled in the pane, then the text will be sent as a bracketed paste'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "get-text" -d 'Retrieves the textual content of a pane and output it to stdout'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "activate-pane-direction" -d 'Activate an adjacent pane in the specified direction'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "get-pane-direction" -d 'Determine the adjacent pane in the specified direction'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "kill-pane" -d 'Kill a pane'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "activate-pane" -d 'Activate (focus) a pane'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "adjust-pane-size" -d 'Adjust the size of a pane directionally'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "activate-tab" -d 'Activate a tab'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "set-tab-title" -d 'Change the title of a tab'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "set-window-title" -d 'Change the title of a window'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "rename-workspace" -d 'Rename a workspace'
complete -c wezterm -n "__fish_wezterm_using_subcommand help; and __fish_seen_subcommand_from cli" -f -a "zoom-pane" -d 'Zoom, unzoom, or toggle zoom state'
