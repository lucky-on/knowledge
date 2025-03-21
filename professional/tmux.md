
TMUX(1)                   BSD General Commands Manual                  TMUX(1)

NNAAMMEE
     ttmmuuxx -- terminal multiplexer

SSYYNNOOPPSSIISS
     ttmmuuxx [--22CClluuvvVV] [--cc _s_h_e_l_l_-_c_o_m_m_a_n_d] [--ff _f_i_l_e] [--LL _s_o_c_k_e_t_-_n_a_m_e]
          [--SS _s_o_c_k_e_t_-_p_a_t_h] [_c_o_m_m_a_n_d [_f_l_a_g_s]]

DDEESSCCRRIIPPTTIIOONN
     ttmmuuxx is a terminal multiplexer: it enables a number of terminals to be
     created, accessed, and controlled from a single screen.  ttmmuuxx may be
     detached from a screen and continue running in the background, then later
     reattached.

     When ttmmuuxx is started it creates a new _s_e_s_s_i_o_n with a single _w_i_n_d_o_w and
     displays it on screen.  A status line at the bottom of the screen shows
     information on the current session and is used to enter interactive com-
     mands.

     A session is a single collection of _p_s_e_u_d_o _t_e_r_m_i_n_a_l_s under the management
     of ttmmuuxx.  Each session has one or more windows linked to it.  A window
     occupies the entire screen and may be split into rectangular panes, each
     of which is a separate pseudo terminal (the pty(4) manual page documents
     the technical details of pseudo terminals).  Any number of ttmmuuxx instances
     may connect to the same session, and any number of windows may be present
     in the same session.  Once all sessions are killed, ttmmuuxx exits.

     Each session is persistent and will survive accidental disconnection
     (such as ssh(1) connection timeout) or intentional detaching (with the
     `C-b d' key strokes).  ttmmuuxx may be reattached using:

           $ tmux attach

     In ttmmuuxx, a session is displayed on screen by a _c_l_i_e_n_t and all sessions
     are managed by a single _s_e_r_v_e_r.  The server and each client are separate
     processes which communicate through a socket in _/_t_m_p.

     The options are as follows:

     --22            Force ttmmuuxx to assume the terminal supports 256 colours.

     --CC            Start in control mode (see the _C_O_N_T_R_O_L _M_O_D_E section).
                   Given twice (--CCCC) disables echo.

     --cc _s_h_e_l_l_-_c_o_m_m_a_n_d
                   Execute _s_h_e_l_l_-_c_o_m_m_a_n_d using the default shell.  If neces-
                   sary, the ttmmuuxx server will be started to retrieve the
                   ddeeffaauulltt--sshheellll option.  This option is for compatibility
                   with sh(1) when ttmmuuxx is used as a login shell.

     --ff _f_i_l_e       Specify an alternative configuration file.  By default,
                   ttmmuuxx loads the system configuration file from
                   _/_u_s_r_/_l_o_c_a_l_/_e_t_c_/_t_m_u_x_._c_o_n_f, if present, then looks for a user
                   configuration file at _~_/_._t_m_u_x_._c_o_n_f.

                   The configuration file is a set of ttmmuuxx commands which are
                   executed in sequence when the server is first started.
                   ttmmuuxx loads configuration files once when the server process
                   has started.  The ssoouurrccee--ffiillee command may be used to load a
                   file later.

                   ttmmuuxx shows any error messages from commands in configura-
                   tion files in the first session created, and continues to
                   process the rest of the configuration file.

     --LL _s_o_c_k_e_t_-_n_a_m_e
                   ttmmuuxx stores the server socket in a directory under
                   TMUX_TMPDIR or _/_t_m_p if it is unset.  The default socket is
                   named _d_e_f_a_u_l_t.  This option allows a different socket name
                   to be specified, allowing several independent ttmmuuxx servers
                   to be run.  Unlike --SS a full path is not necessary: the
                   sockets are all created in the same directory.

                   If the socket is accidentally removed, the SIGUSR1 signal
                   may be sent to the ttmmuuxx server process to recreate it (note
                   that this will fail if any parent directories are missing).

     --ll            Behave as a login shell.  This flag currently has no effect
                   and is for compatibility with other shells when using tmux
                   as a login shell.

     --SS _s_o_c_k_e_t_-_p_a_t_h
                   Specify a full alternative path to the server socket.  If
                   --SS is specified, the default socket directory is not used
                   and any --LL flag is ignored.

     --uu            When starting, ttmmuuxx looks for the LC_ALL, LC_CTYPE and LANG
                   environment variables: if the first found contains `UTF-8',
                   then the terminal is assumed to support UTF-8.  This is not
                   always correct: the --uu flag explicitly informs ttmmuuxx that
                   UTF-8 is supported.

                   Note that ttmmuuxx itself always accepts UTF-8; this controls
                   whether it will send UTF-8 characters to the terminal it is
                   running (if not, they are replaced by `_').

     --vv            Request verbose logging.  Log messages will be saved into
                   _t_m_u_x_-_c_l_i_e_n_t_-_P_I_D_._l_o_g and _t_m_u_x_-_s_e_r_v_e_r_-_P_I_D_._l_o_g files in the
                   current directory, where _P_I_D is the PID of the server or
                   client process.  If --vv is specified twice, an additional
                   _t_m_u_x_-_o_u_t_-_P_I_D_._l_o_g file is generated with a copy of every-
                   thing ttmmuuxx writes to the terminal.

                   The SIGUSR2 signal may be sent to the ttmmuuxx server process
                   to toggle logging between on (as if --vv was given) and off.

     --VV            Report the ttmmuuxx version.

     _c_o_m_m_a_n_d [_f_l_a_g_s]
                   This specifies one of a set of commands used to control
                   ttmmuuxx, as described in the following sections.  If no com-
                   mands are specified, the nneeww--sseessssiioonn command is assumed.

DDEEFFAAUULLTT KKEEYY BBIINNDDIINNGGSS
     ttmmuuxx may be controlled from an attached client by using a key combination
     of a prefix key, `C-b' (Ctrl-b) by default, followed by a command key.

     The default command key bindings are:

           C-b         Send the prefix key (C-b) through to the application.
           C-o         Rotate the panes in the current window forwards.
           C-z         Suspend the ttmmuuxx client.
           !           Break the current pane out of the window.
           "           Split the current pane into two, top and bottom.
           #           List all paste buffers.
           $           Rename the current session.
           %           Split the current pane into two, left and right.
           &           Kill the current window.
           '           Prompt for a window index to select.
           (           Switch the attached client to the previous session.
           )           Switch the attached client to the next session.
           ,           Rename the current window.
           -           Delete the most recently copied buffer of text.
           .           Prompt for an index to move the current window.
           0 to 9      Select windows 0 to 9.
           :           Enter the ttmmuuxx command prompt.
           ;           Move to the previously active pane.
           =           Choose which buffer to paste interactively from a list.
           ?           List all key bindings.
           D           Choose a client to detach.
           L           Switch the attached client back to the last session.
           [           Enter copy mode to copy text or view the history.
           ]           Paste the most recently copied buffer of text.
           c           Create a new window.
           d           Detach the current client.
           f           Prompt to search for text in open windows.
           i           Display some information about the current window.
           l           Move to the previously selected window.
           n           Change to the next window.
           o           Select the next pane in the current window.
           p           Change to the previous window.
           q           Briefly display pane indexes.
           r           Force redraw of the attached client.
           m           Mark the current pane (see sseelleecctt--ppaannee --mm).
           M           Clear the marked pane.
           s           Select a new session for the attached client interac-
                       tively.
           t           Show the time.
           w           Choose the current window interactively.
           x           Kill the current pane.
           z           Toggle zoom state of the current pane.
           {           Swap the current pane with the previous pane.
           }           Swap the current pane with the next pane.
           ~           Show previous messages from ttmmuuxx, if any.
           Page Up     Enter copy mode and scroll one page up.
           Up, Down
           Left, Right
                       Change to the pane above, below, to the left, or to the
                       right of the current pane.
           M-1 to M-5  Arrange panes in one of the five preset layouts: even-
                       horizontal, even-vertical, main-horizontal, main-verti-
                       cal, or tiled.
           Space       Arrange the current window in the next preset layout.
           M-n         Move to the next window with a bell or activity marker.
           M-o         Rotate the panes in the current window backwards.
           M-p         Move to the previous window with a bell or activity
                       marker.
           C-Up, C-Down
           C-Left, C-Right
                       Resize the current pane in steps of one cell.
           M-Up, M-Down
           M-Left, M-Right
                       Resize the current pane in steps of five cells.

     Key bindings may be changed with the bbiinndd--kkeeyy and uunnbbiinndd--kkeeyy commands.

CCOOMMMMAANNDDSS
     This section contains a list of the commands supported by ttmmuuxx.  Most
     commands accept the optional --tt (and sometimes --ss) argument with one of
     _t_a_r_g_e_t_-_c_l_i_e_n_t, _t_a_r_g_e_t_-_s_e_s_s_i_o_n _t_a_r_g_e_t_-_w_i_n_d_o_w, or _t_a_r_g_e_t_-_p_a_n_e.  These spec-
     ify the client, session, window or pane which a command should affect.

     _t_a_r_g_e_t_-_c_l_i_e_n_t should be the name of the client, typically the pty(4) file
     to which the client is connected, for example either of _/_d_e_v_/_t_t_y_p_1 or
     _t_t_y_p_1 for the client attached to _/_d_e_v_/_t_t_y_p_1.  If no client is specified,
     ttmmuuxx attempts to work out the client currently in use; if that fails, an
     error is reported.  Clients may be listed with the lliisstt--cclliieennttss command.

     _t_a_r_g_e_t_-_s_e_s_s_i_o_n is tried as, in order:

           1.   A session ID prefixed with a $.

           2.   An exact name of a session (as listed by the lliisstt--sseessssiioonnss
                command).

           3.   The start of a session name, for example `mysess' would match
                a session named `mysession'.

           4.   An fnmatch(3) pattern which is matched against the session
                name.

     If the session name is prefixed with an `=', only an exact match is
     accepted (so `=mysess' will only match exactly `mysess', not
     `mysession').

     If a single session is found, it is used as the target session; multiple
     matches produce an error.  If a session is omitted, the current session
     is used if available; if no current session is available, the most
     recently used is chosen.

     _t_a_r_g_e_t_-_w_i_n_d_o_w (or _s_r_c_-_w_i_n_d_o_w or _d_s_t_-_w_i_n_d_o_w) specifies a window in the
     form _s_e_s_s_i_o_n:_w_i_n_d_o_w.  _s_e_s_s_i_o_n follows the same rules as for
     _t_a_r_g_e_t_-_s_e_s_s_i_o_n, and _w_i_n_d_o_w is looked for in order as:

           1.   A special token, listed below.

           2.   A window index, for example `mysession:1' is window 1 in ses-
                sion `mysession'.

           3.   A window ID, such as @1.

           4.   An exact window name, such as `mysession:mywindow'.

           5.   The start of a window name, such as `mysession:mywin'.

           6.   As an fnmatch(3) pattern matched against the window name.

     Like sessions, a `=' prefix will do an exact match only.  An empty window
     name specifies the next unused index if appropriate (for example the
     nneeww--wwiinnddooww and lliinnkk--wwiinnddooww commands) otherwise the current window in
     _s_e_s_s_i_o_n is chosen.

     The following special tokens are available to indicate particular win-
     dows.  Each has a single-character alternative form.

     TTookkeenn              MMeeaanniinngg
     {start}       ^    The lowest-numbered window
     {end}         $    The highest-numbered window
     {last}        !    The last (previously current) window
     {next}        +    The next window by number
     {previous}    -    The previous window by number

     _t_a_r_g_e_t_-_p_a_n_e (or _s_r_c_-_p_a_n_e or _d_s_t_-_p_a_n_e) may be a pane ID or takes a similar
     form to _t_a_r_g_e_t_-_w_i_n_d_o_w but with the optional addition of a period followed
     by a pane index or pane ID, for example: `mysession:mywindow.1'.  If the
     pane index is omitted, the currently active pane in the specified window
     is used.  The following special tokens are available for the pane index:

     TTookkeenn                  MMeeaanniinngg
     {last}            !    The last (previously active) pane
     {next}            +    The next pane by number
     {previous}        -    The previous pane by number
     {top}                  The top pane
     {bottom}               The bottom pane
     {left}                 The leftmost pane
     {right}                The rightmost pane
     {top-left}             The top-left pane
     {top-right}            The top-right pane
     {bottom-left}          The bottom-left pane
     {bottom-right}         The bottom-right pane
     {up-of}                The pane above the active pane
     {down-of}              The pane below the active pane
     {left-of}              The pane to the left of the active pane
     {right-of}             The pane to the right of the active pane

     The tokens `+' and `-' may be followed by an offset, for example:

           select-window -t:+2

     In addition, _t_a_r_g_e_t_-_s_e_s_s_i_o_n, _t_a_r_g_e_t_-_w_i_n_d_o_w or _t_a_r_g_e_t_-_p_a_n_e may consist
     entirely of the token `{mouse}' (alternative form `=') to specify the
     most recent mouse event (see the _M_O_U_S_E _S_U_P_P_O_R_T section) or `{marked}'
     (alternative form `~') to specify the marked pane (see sseelleecctt--ppaannee --mm).

     Sessions, window and panes are each numbered with a unique ID; session
     IDs are prefixed with a `$', windows with a `@', and panes with a `%'.
     These are unique and are unchanged for the life of the session, window or
     pane in the ttmmuuxx server.  The pane ID is passed to the child process of
     the pane in the TMUX_PANE environment variable.  IDs may be displayed
     using the `session_id', `window_id', or `pane_id' formats (see the
     _F_O_R_M_A_T_S section) and the ddiissppllaayy--mmeessssaaggee, lliisstt--sseessssiioonnss, lliisstt--wwiinnddoowwss or
     lliisstt--ppaanneess commands.

     _s_h_e_l_l_-_c_o_m_m_a_n_d arguments are sh(1) commands.  This may be a single argu-
     ment passed to the shell, for example:

           new-window 'vi /etc/passwd'

     Will run:

           /bin/sh -c 'vi /etc/passwd'

     Additionally, the nneeww--wwiinnddooww, nneeww--sseessssiioonn, sspplliitt--wwiinnddooww, rreessppaawwnn--wwiinnddooww
     and rreessppaawwnn--ppaannee commands allow _s_h_e_l_l_-_c_o_m_m_a_n_d to be given as multiple
     arguments and executed directly (without `sh -c').  This can avoid issues
     with shell quoting.  For example:

           $ tmux new-window vi /etc/passwd

     Will run vi(1) directly without invoking the shell.

     _c_o_m_m_a_n_d [_a_r_g_u_m_e_n_t_s] refers to a ttmmuuxx command, passed with the command and
     arguments separately, for example:

           bind-key F1 set-option status off

     Or if using sh(1):

           $ tmux bind-key F1 set-option status off

     Multiple commands may be specified together as part of a _c_o_m_m_a_n_d
     _s_e_q_u_e_n_c_e.  Each command should be separated by spaces and a semicolon;
     commands are executed sequentially from left to right and lines ending
     with a backslash continue on to the next line, except when escaped by
     another backslash.  A literal semicolon may be included by escaping it
     with a backslash (for example, when specifying a command sequence to
     bbiinndd--kkeeyy).

     Example ttmmuuxx commands include:

           refresh-client -t/dev/ttyp2

           rename-session -tfirst newname

           set-window-option -t:0 monitor-activity on

           new-window ; split-window -d

           bind-key R source-file ~/.tmux.conf \; \
                   display-message "source-file done"

     Or from sh(1):

           $ tmux kill-window -t :1

           $ tmux new-window \; split-window -d

           $ tmux new-session -d 'vi /etc/passwd' \; split-window -d \; attach

CCLLIIEENNTTSS AANNDD SSEESSSSIIOONNSS
     The ttmmuuxx server manages clients, sessions, windows and panes.  Clients
     are attached to sessions to interact with them, either when they are cre-
     ated with the nneeww--sseessssiioonn command, or later with the aattttaacchh--sseessssiioonn com-
     mand.  Each session has one or more windows _l_i_n_k_e_d into it.  Windows may
     be linked to multiple sessions and are made up of one or more panes, each
     of which contains a pseudo terminal.  Commands for creating, linking and
     otherwise manipulating windows are covered in the _W_I_N_D_O_W_S _A_N_D _P_A_N_E_S sec-
     tion.

     The following commands are available to manage clients and sessions:

     aattttaacchh--sseessssiioonn [--ddEErr] [--cc _w_o_r_k_i_n_g_-_d_i_r_e_c_t_o_r_y] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                   (alias: aattttaacchh)
             If run from outside ttmmuuxx, create a new client in the current ter-
             minal and attach it to _t_a_r_g_e_t_-_s_e_s_s_i_o_n.  If used from inside,
             switch the current client.  If --dd is specified, any other clients
             attached to the session are detached.  --rr signifies the client is
             read-only (only keys bound to the ddeettaacchh--cclliieenntt or sswwiittcchh--cclliieenntt
             commands have any effect)

             If no server is started, aattttaacchh--sseessssiioonn will attempt to start it;
             this will fail unless sessions are created in the configuration
             file.

             The _t_a_r_g_e_t_-_s_e_s_s_i_o_n rules for aattttaacchh--sseessssiioonn are slightly
             adjusted: if ttmmuuxx needs to select the most recently used session,
             it will prefer the most recently used _u_n_a_t_t_a_c_h_e_d session.

             --cc will set the session working directory (used for new windows)
             to _w_o_r_k_i_n_g_-_d_i_r_e_c_t_o_r_y.

             If --EE is used, the uuppddaattee--eennvviirroonnmmeenntt option will not be applied.

     ddeettaacchh--cclliieenntt [--aaPP] [--EE _s_h_e_l_l_-_c_o_m_m_a_n_d] [--ss _t_a_r_g_e_t_-_s_e_s_s_i_o_n] [--tt
             _t_a_r_g_e_t_-_c_l_i_e_n_t]
                   (alias: ddeettaacchh)
             Detach the current client if bound to a key, the client specified
             with --tt, or all clients currently attached to the session speci-
             fied by --ss.  The --aa option kills all but the client given with
             --tt.  If --PP is given, send SIGHUP to the parent process of the
             client, typically causing it to exit.  With --EE, run _s_h_e_l_l_-_c_o_m_m_a_n_d
             to replace the client.

     hhaass--sseessssiioonn [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                   (alias: hhaass)
             Report an error and exit with 1 if the specified session does not
             exist.  If it does exist, exit with 0.

     kkiillll--sseerrvveerr
             Kill the ttmmuuxx server and clients and destroy all sessions.

     kkiillll--sseessssiioonn [--aaCC] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
             Destroy the given session, closing any windows linked to it and
             no other sessions, and detaching all clients attached to it.  If
             --aa is given, all sessions but the specified one is killed.  The
             --CC flag clears alerts (bell, activity, or silence) in all windows
             linked to the session.

     lliisstt--cclliieennttss [--FF _f_o_r_m_a_t] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                   (alias: llsscc)
             List all clients attached to the server.  For the meaning of the
             --FF flag, see the _F_O_R_M_A_T_S section.  If _t_a_r_g_e_t_-_s_e_s_s_i_o_n is speci-
             fied, list only clients connected to that session.

     lliisstt--ccoommmmaannddss [--FF _f_o_r_m_a_t]
                   (alias: llssccmm)
             List the syntax of all commands supported by ttmmuuxx.

     lliisstt--sseessssiioonnss [--FF _f_o_r_m_a_t]
                   (alias: llss)
             List all sessions managed by the server.  For the meaning of the
             --FF flag, see the _F_O_R_M_A_T_S section.

     lloocckk--cclliieenntt [--tt _t_a_r_g_e_t_-_c_l_i_e_n_t]
                   (alias: lloocckkcc)
             Lock _t_a_r_g_e_t_-_c_l_i_e_n_t, see the lloocckk--sseerrvveerr command.

     lloocckk--sseessssiioonn [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                   (alias: lloocckkss)
             Lock all clients attached to _t_a_r_g_e_t_-_s_e_s_s_i_o_n.

     nneeww--sseessssiioonn [--AAddDDEEPP] [--cc _s_t_a_r_t_-_d_i_r_e_c_t_o_r_y] [--FF _f_o_r_m_a_t] [--nn _w_i_n_d_o_w_-_n_a_m_e]
             [--ss _s_e_s_s_i_o_n_-_n_a_m_e] [--tt _g_r_o_u_p_-_n_a_m_e] [--xx _w_i_d_t_h] [--yy _h_e_i_g_h_t]
             [_s_h_e_l_l_-_c_o_m_m_a_n_d]
                   (alias: nneeww)
             Create a new session with name _s_e_s_s_i_o_n_-_n_a_m_e.

             The new session is attached to the current terminal unless --dd is
             given.  _w_i_n_d_o_w_-_n_a_m_e and _s_h_e_l_l_-_c_o_m_m_a_n_d are the name of and shell
             command to execute in the initial window.  With --dd, the initial
             size comes from the global _d_e_f_a_u_l_t_-_s_i_z_e option; --xx and --yy can be
             used to specify a different size.  `-' uses the size of the cur-
             rent client if any.  If --xx or --yy is given, the _d_e_f_a_u_l_t_-_s_i_z_e
             option is set for the session.

             If run from a terminal, any termios(4) special characters are
             saved and used for new windows in the new session.

             The --AA flag makes nneeww--sseessssiioonn behave like aattttaacchh--sseessssiioonn if
             _s_e_s_s_i_o_n_-_n_a_m_e already exists; in this case, --DD behaves like --dd to
             aattttaacchh--sseessssiioonn.

             If --tt is given, it specifies a sseessssiioonn ggrroouupp.  Sessions in the
             same group share the same set of windows - new windows are linked
             to all sessions in the group and any windows closed removed from
             all sessions.  The current and previous window and any session
             options remain independent and any session in a group may be
             killed without affecting the others.  The _g_r_o_u_p_-_n_a_m_e argument may
             be:

             1.      the name of an existing group, in which case the new ses-
                     sion is added to that group;

             2.      the name of an existing session - the new session is
                     added to the same group as that session, creating a new
                     group if necessary;

             3.      the name for a new group containing only the new session.

             --nn and _s_h_e_l_l_-_c_o_m_m_a_n_d are invalid if --tt is used.

             The --PP option prints information about the new session after it
             has been created.  By default, it uses the format
             `#{session_name}:' but a different format may be specified with
             --FF.

             If --EE is used, the uuppddaattee--eennvviirroonnmmeenntt option will not be applied.

     rreeffrreesshh--cclliieenntt [--ccDDllLLRRSSUU] [--CC _w_i_d_t_h_,_h_e_i_g_h_t] [--tt _t_a_r_g_e_t_-_c_l_i_e_n_t]
             [_a_d_j_u_s_t_m_e_n_t]
                   (alias: rreeffrreesshh)
             Refresh the current client if bound to a key, or a single client
             if one is given with --tt.  If --SS is specified, only update the
             client's status line.

             The --UU, --DD, --LL --RR, and --cc flags allow the visible portion of a
             window which is larger than the client to be changed.  --UU moves
             the visible part up by _a_d_j_u_s_t_m_e_n_t rows and --DD down, --LL left by
             _a_d_j_u_s_t_m_e_n_t columns and --RR right.  --cc returns to tracking the cur-
             sor automatically.  If _a_d_j_u_s_t_m_e_n_t is omitted, 1 is used.  Note
             that the visible position is a property of the client not of the
             window, changing the current window in the attached session will
             reset it.

             --CC sets the width and height of a control client.  --ll requests
             the clipboard from the client using the xterm(1) escape sequence
             and stores it in a new paste buffer.

             --LL, --RR, --UU and --DD move the visible portion of the window left,
             right, up or down by _a_d_j_u_s_t_m_e_n_t, if the window is larger than the
             client.  --cc resets so that the position follows the cursor.  See
             the wwiinnddooww--ssiizzee option.

     rreennaammee--sseessssiioonn [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n] _n_e_w_-_n_a_m_e
                   (alias: rreennaammee)
             Rename the session to _n_e_w_-_n_a_m_e.

     sshhooww--mmeessssaaggeess [--JJTT] [--tt _t_a_r_g_e_t_-_c_l_i_e_n_t]
                   (alias: sshhoowwmmssggss)
             Show client messages or server information.  Any messages dis-
             played on the status line are saved in a per-client message log,
             up to a maximum of the limit set by the _m_e_s_s_a_g_e_-_l_i_m_i_t server
             option.  With --tt, display the log for _t_a_r_g_e_t_-_c_l_i_e_n_t.  --JJ and --TT
             show debugging information about jobs and terminals.

     ssoouurrccee--ffiillee [--qq] _p_a_t_h
                   (alias: ssoouurrccee)
             Execute commands from _p_a_t_h (which may be a glob(7) pattern).  If
             --qq is given, no error will be returned if _p_a_t_h does not exist.

             Within a configuration file, commands may be made conditional by
             surrounding them with _%_i_f and _%_e_n_d_i_f lines.  Additional _%_e_l_i_f and
             _%_e_l_s_e lines may also be used.  The argument to _%_i_f and _%_e_l_i_f is
             expanded as a format and if it evaluates to false (zero or
             empty), subsequent lines are ignored until the next _%_e_l_i_f, _%_e_l_s_e
             or _%_e_n_d_i_f.  For example:

                   %if #{==:#{host},myhost}
                   set -g status-style bg=red
                   %elif #{==:#{host},myotherhost}
                   set -g status-style bg=green
                   %else
                   set -g status-style bg=blue
                   %endif

             Will change the status line to red if running on `myhost', green
             if running on `myotherhost', or blue if running on another host.

     ssttaarrtt--sseerrvveerr
                   (alias: ssttaarrtt)
             Start the ttmmuuxx server, if not already running, without creating
             any sessions.

     ssuussppeenndd--cclliieenntt [--tt _t_a_r_g_e_t_-_c_l_i_e_n_t]
                   (alias: ssuussppeennddcc)
             Suspend a client by sending SIGTSTP (tty stop).

     sswwiittcchh--cclliieenntt [--EEllnnpprr] [--cc _t_a_r_g_e_t_-_c_l_i_e_n_t] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n] [--TT
             _k_e_y_-_t_a_b_l_e]
                   (alias: sswwiittcchhcc)
             Switch the current session for client _t_a_r_g_e_t_-_c_l_i_e_n_t to
             _t_a_r_g_e_t_-_s_e_s_s_i_o_n.  If --ll, --nn or --pp is used, the client is moved to
             the last, next or previous session respectively.  --rr toggles
             whether a client is read-only (see the aattttaacchh--sseessssiioonn command).

             If --EE is used, uuppddaattee--eennvviirroonnmmeenntt option will not be applied.

             --TT sets the client's key table; the next key from the client will
             be interpreted from _k_e_y_-_t_a_b_l_e.  This may be used to configure
             multiple prefix keys, or to bind commands to sequences of keys.
             For example, to make typing `abc' run the lliisstt--kkeeyyss command:

                   bind-key -Ttable2 c list-keys
                   bind-key -Ttable1 b switch-client -Ttable2
                   bind-key -Troot   a switch-client -Ttable1

WWIINNDDOOWWSS AANNDD PPAANNEESS
     A ttmmuuxx window may be in one of two modes.  The default permits direct
     access to the terminal attached to the window.  The other is copy mode,
     which permits a section of a window or its history to be copied to a
     _p_a_s_t_e _b_u_f_f_e_r for later insertion into another window.  This mode is
     entered with the ccooppyy--mmooddee command, bound to `[' by default.  It is also
     entered when a command that produces output, such as lliisstt--kkeeyyss, is exe-
     cuted from a key binding.

     Commands are sent to copy mode using the --XX flag to the sseenndd--kkeeyyss com-
     mand.  When a key is pressed, copy mode automatically uses one of two key
     tables, depending on the mmooddee--kkeeyyss option: ccooppyy--mmooddee for emacs, or
     ccooppyy--mmooddee--vvii for vi.  Key tables may be viewed with the lliisstt--kkeeyyss com-
     mand.

     The following commands are supported in copy mode:

           CCoommmmaanndd                              vvii              eemmaaccss
           append-selection
           append-selection-and-cancel          A
           back-to-indentation                  ^               M-m
           begin-selection                      Space           C-Space
           bottom-line                          L
           cancel                               q               Escape
           clear-selection                      Escape          C-g
           copy-end-of-line                     D               C-k
           copy-line
           copy-pipe <command>
           copy-pipe-and-cancel <command>
           copy-selection
           copy-selection-and-cancel            Enter           M-w
           cursor-down                          j               Down
           cursor-left                          h               Left
           cursor-right                         l               Right
           cursor-up                            k               Up
           end-of-line                          $               C-e
           goto-line <line>                     :               g
           halfpage-down                        C-d             M-Down
           halfpage-down-and-cancel
           halfpage-up                          C-u             M-Up
           history-bottom                       G               M->
           history-top                          g               M-<
           jump-again                           ;               ;
           jump-backward <to>                   F               F
           jump-forward <to>                    f               f
           jump-reverse                         ,               ,
           jump-to-backward <to>                T
           jump-to-forward <to>                 t
           middle-line                          M               M-r
           next-paragraph                       }               M-}
           next-space                           W
           next-space-end                       E
           next-word                            w
           next-word-end                        e               M-f
           other-end                            o
           page-down                            C-f             PageDown
           page-down-and-cancel
           page-up                              C-b             PageUp
           previous-paragraph                   {               M-{
           previous-space                       B
           previous-word                        b               M-b
           rectangle-toggle                     v               R
           scroll-down                          C-e             C-Down
           scroll-down-and-cancel
           scroll-up                            C-y             C-Up
           search-again                         n               n
           search-backward <for>                ?
           search-forward <for>                 /
           search-backward-incremental <for>                    C-r
           search-forward-incremental <for>                     C-s
           search-reverse                       N               N
           select-line                          V
           start-of-line                        0               C-a
           stop-selection
           top-line                             H               M-R

     The `-and-cancel' variants of some commands exit copy mode after they
     have completed (for copy commands) or when the cursor reaches the bottom
     (for scrolling commands).

     The next and previous word keys use space and the `-', `_' and `@' char-
     acters as word delimiters by default, but this can be adjusted by setting
     the _w_o_r_d_-_s_e_p_a_r_a_t_o_r_s session option.  Next word moves to the start of the
     next word, next word end to the end of the next word and previous word to
     the start of the previous word.  The three next and previous space keys
     work similarly but use a space alone as the word separator.

     The jump commands enable quick movement within a line.  For instance,
     typing `f' followed by `/' will move the cursor to the next `/' character
     on the current line.  A `;' will then jump to the next occurrence.

     Commands in copy mode may be prefaced by an optional repeat count.  With
     vi key bindings, a prefix is entered using the number keys; with emacs,
     the Alt (meta) key and a number begins prefix entry.

     The synopsis for the ccooppyy--mmooddee command is:

     ccooppyy--mmooddee [--MMeeuu] [--tt _t_a_r_g_e_t_-_p_a_n_e]
             Enter copy mode.  The --uu option scrolls one page up.  --MM begins a
             mouse drag (only valid if bound to a mouse key binding, see _M_O_U_S_E
             _S_U_P_P_O_R_T).  --ee specifies that scrolling to the bottom of the his-
             tory (to the visible screen) should exit copy mode.  While in
             copy mode, pressing a key other than those used for scrolling
             will disable this behaviour.  This is intended to allow fast
             scrolling through a pane's history, for example with:

                   bind PageUp copy-mode -eu

     Each window displayed by ttmmuuxx may be split into one or more _p_a_n_e_s; each
     pane takes up a certain area of the display and is a separate terminal.
     A window may be split into panes using the sspplliitt--wwiinnddooww command.  Windows
     may be split horizontally (with the --hh flag) or vertically.  Panes may be
     resized with the rreessiizzee--ppaannee command (bound to `C-Up', `C-Down' `C-Left'
     and `C-Right' by default), the current pane may be changed with the
     sseelleecctt--ppaannee command and the rroottaattee--wwiinnddooww and sswwaapp--ppaannee commands may be
     used to swap panes without changing their position.  Panes are numbered
     beginning from zero in the order they are created.

     A number of preset _l_a_y_o_u_t_s are available.  These may be selected with the
     sseelleecctt--llaayyoouutt command or cycled with nneexxtt--llaayyoouutt (bound to `Space' by
     default); once a layout is chosen, panes within it may be moved and
     resized as normal.

     The following layouts are supported:

     eevveenn--hhoorriizzoonnttaall
             Panes are spread out evenly from left to right across the window.

     eevveenn--vveerrttiiccaall
             Panes are spread evenly from top to bottom.

     mmaaiinn--hhoorriizzoonnttaall
             A large (main) pane is shown at the top of the window and the
             remaining panes are spread from left to right in the leftover
             space at the bottom.  Use the _m_a_i_n_-_p_a_n_e_-_h_e_i_g_h_t window option to
             specify the height of the top pane.

     mmaaiinn--vveerrttiiccaall
             Similar to mmaaiinn--hhoorriizzoonnttaall but the large pane is placed on the
             left and the others spread from top to bottom along the right.
             See the _m_a_i_n_-_p_a_n_e_-_w_i_d_t_h window option.

     ttiilleedd   Panes are spread out as evenly as possible over the window in
             both rows and columns.

     In addition, sseelleecctt--llaayyoouutt may be used to apply a previously used layout
     - the lliisstt--wwiinnddoowwss command displays the layout of each window in a form
     suitable for use with sseelleecctt--llaayyoouutt.  For example:

           $ tmux list-windows
           0: ksh [159x48]
               layout: bb62,159x48,0,0{79x48,0,0,79x48,80,0}
           $ tmux select-layout bb62,159x48,0,0{79x48,0,0,79x48,80,0}

     ttmmuuxx automatically adjusts the size of the layout for the current window
     size.  Note that a layout cannot be applied to a window with more panes
     than that from which the layout was originally defined.

     Commands related to windows and panes are as follows:

     bbrreeaakk--ppaannee [--ddPP] [--FF _f_o_r_m_a_t] [--nn _w_i_n_d_o_w_-_n_a_m_e] [--ss _s_r_c_-_p_a_n_e] [--tt
             _d_s_t_-_w_i_n_d_o_w]
                   (alias: bbrreeaakkpp)
             Break _s_r_c_-_p_a_n_e off from its containing window to make it the only
             pane in _d_s_t_-_w_i_n_d_o_w.  If --dd is given, the new window does not
             become the current window.  The --PP option prints information
             about the new window after it has been created.  By default, it
             uses the format `#{session_name}:#{window_index}' but a different
             format may be specified with --FF.

     ccaappttuurree--ppaannee [--aaeeppPPqqCCJJ] [--bb _b_u_f_f_e_r_-_n_a_m_e] [--EE _e_n_d_-_l_i_n_e] [--SS _s_t_a_r_t_-_l_i_n_e]
             [--tt _t_a_r_g_e_t_-_p_a_n_e]
                   (alias: ccaappttuurreepp)
             Capture the contents of a pane.  If --pp is given, the output goes
             to stdout, otherwise to the buffer specified with --bb or a new
             buffer if omitted.  If --aa is given, the alternate screen is used,
             and the history is not accessible.  If no alternate screen
             exists, an error will be returned unless --qq is given.  If --ee is
             given, the output includes escape sequences for text and back-
             ground attributes.  --CC also escapes non-printable characters as
             octal \xxx.  --JJ joins wrapped lines and preserves trailing spaces
             at each line's end.  --PP captures only any output that the pane
             has received that is the beginning of an as-yet incomplete escape
             sequence.

             --SS and --EE specify the starting and ending line numbers, zero is
             the first line of the visible pane and negative numbers are lines
             in the history.  `-' to --SS is the start of the history and to --EE
             the end of the visible pane.  The default is to capture only the
             visible contents of the pane.

     cchhoooossee--cclliieenntt [--NNZZ] [--FF _f_o_r_m_a_t] [--ff _f_i_l_t_e_r] [--OO _s_o_r_t_-_o_r_d_e_r] [--tt
             _t_a_r_g_e_t_-_p_a_n_e] [_t_e_m_p_l_a_t_e]
             Put a pane into client mode, allowing a client to be selected
             interactively from a list.  --ZZ zooms the pane.  The following
             keys may be used in client mode:

                   KKeeyy    FFuunnccttiioonn
                   Enter  Choose selected client
                   Up     Select previous client
                   Down   Select next client
                   C-s    Search by name
                   n      Repeat last search
                   t      Toggle if client is tagged
                   T      Tag no clients
                   C-t    Tag all clients
                   d      Detach selected client
                   D      Detach tagged clients
                   x      Detach and HUP selected client
                   X      Detach and HUP tagged clients
                   z      Suspend selected client
                   Z      Suspend tagged clients
                   f      Enter a format to filter items
                   O      Change sort order
                   v      Toggle preview
                   q      Exit mode

             After a client is chosen, `%%' is replaced by the client name in
             _t_e_m_p_l_a_t_e and the result executed as a command.  If _t_e_m_p_l_a_t_e is
             not given, "detach-client -t '%%'" is used.

             --OO specifies the initial sort order: one of `name', `size',
             `creation', or `activity'.  --ff specifies an initial filter: the
             filter is a format - if it evaluates to zero, the item in the
             list is not shown, otherwise it is shown.  If a filter would lead
             to an empty list, it is ignored.  --FF specifies the format for
             each item in the list.  --NN starts without the preview.  This com-
             mand works only if at least one client is attached.

     cchhoooossee--ttrreeee [--GGNNsswwZZ] [--FF _f_o_r_m_a_t] [--ff _f_i_l_t_e_r] [--OO _s_o_r_t_-_o_r_d_e_r] [--tt
             _t_a_r_g_e_t_-_p_a_n_e] [_t_e_m_p_l_a_t_e]
             Put a pane into tree mode, where a session, window or pane may be
             chosen interactively from a list.  --ss starts with sessions col-
             lapsed and --ww with windows collapsed.  --ZZ zooms the pane.  The
             following keys may be used in tree mode:

                   KKeeyy    FFuunnccttiioonn
                   Enter  Choose selected item
                   Up     Select previous item
                   Down   Select next item
                   x      Kill selected item
                   X      Kill tagged items
                   <      Scroll list of previews left
                   >      Scroll list of previews right
                   C-s    Search by name
                   n      Repeat last search
                   t      Toggle if item is tagged
                   T      Tag no items
                   C-t    Tag all items
                   :      Run a command for each tagged item
                   f      Enter a format to filter items
                   O      Change sort order
                   v      Toggle preview
                   q      Exit mode

             After a session, window or pane is chosen, `%%' is replaced by
             the target in _t_e_m_p_l_a_t_e and the result executed as a command.  If
             _t_e_m_p_l_a_t_e is not given, "switch-client -t '%%'" is used.

             --OO specifies the initial sort order: one of `index', `name', or
             `time'.  --ff specifies an initial filter: the filter is a format -
             if it evaluates to zero, the item in the list is not shown, oth-
             erwise it is shown.  If a filter would lead to an empty list, it
             is ignored.  --FF specifies the format for each item in the tree.
             --NN starts without the preview.  --GG includes all sessions in any
             session groups in the tree rather than only the first.  This com-
             mand works only if at least one client is attached.

     ddiissppllaayy--ppaanneess [--bb] [--dd _d_u_r_a_t_i_o_n] [--tt _t_a_r_g_e_t_-_c_l_i_e_n_t] [_t_e_m_p_l_a_t_e]
                   (alias: ddiissppllaayypp)
             Display a visible indicator of each pane shown by _t_a_r_g_e_t_-_c_l_i_e_n_t.
             See the ddiissppllaayy--ppaanneess--ccoolloouurr and ddiissppllaayy--ppaanneess--aaccttiivvee--ccoolloouurr ses-
             sion options.  The indicator is closed when a key is pressed or
             _d_u_r_a_t_i_o_n milliseconds have passed.  If --dd is not given,
             ddiissppllaayy--ppaanneess--ttiimmee is used.  A duration of zero means the indica-
             tor stays until a key is pressed.  While the indicator is on
             screen, a pane may be chosen with the `0' to `9' keys, which will
             cause _t_e_m_p_l_a_t_e to be executed as a command with `%%' substituted
             by the pane ID.  The default _t_e_m_p_l_a_t_e is "select-pane -t '%%'".
             With --bb, other commands are not blocked from running until the
             indicator is closed.

     ffiinndd--wwiinnddooww [--CCNNTTZZ] [--tt _t_a_r_g_e_t_-_p_a_n_e] _m_a_t_c_h_-_s_t_r_i_n_g
                   (alias: ffiinnddww)
             Search for the fnmatch(3) pattern _m_a_t_c_h_-_s_t_r_i_n_g in window names,
             titles, and visible content (but not history).  The flags control
             matching behavior: --CC matches only visible window contents, --NN
             matches only the window name and --TT matches only the window
             title.  The default is --CCNNTT.  --ZZ zooms the pane.

             This command works only if at least one client is attached.

     jjooiinn--ppaannee [--bbddhhvv] [--ll _s_i_z_e | --pp _p_e_r_c_e_n_t_a_g_e] [--ss _s_r_c_-_p_a_n_e] [--tt _d_s_t_-_p_a_n_e]
                   (alias: jjooiinnpp)
             Like sspplliitt--wwiinnddooww, but instead of splitting _d_s_t_-_p_a_n_e and creating
             a new pane, split it and move _s_r_c_-_p_a_n_e into the space.  This can
             be used to reverse bbrreeaakk--ppaannee.  The --bb option causes _s_r_c_-_p_a_n_e to
             be joined to left of or above _d_s_t_-_p_a_n_e.

             If --ss is omitted and a marked pane is present (see sseelleecctt--ppaannee
             --mm), the marked pane is used rather than the current pane.

     kkiillll--ppaannee [--aa] [--tt _t_a_r_g_e_t_-_p_a_n_e]
                   (alias: kkiillllpp)
             Destroy the given pane.  If no panes remain in the containing
             window, it is also destroyed.  The --aa option kills all but the
             pane given with --tt.

     kkiillll--wwiinnddooww [--aa] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
                   (alias: kkiillllww)
             Kill the current window or the window at _t_a_r_g_e_t_-_w_i_n_d_o_w, removing
             it from any sessions to which it is linked.  The --aa option kills
             all but the window given with --tt.

     llaasstt--ppaannee [--ddee] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
                   (alias: llaassttpp)
             Select the last (previously selected) pane.  --ee enables or --dd
             disables input to the pane.

     llaasstt--wwiinnddooww [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                   (alias: llaasstt)
             Select the last (previously selected) window.  If no
             _t_a_r_g_e_t_-_s_e_s_s_i_o_n is specified, select the last window of the cur-
             rent session.

     lliinnkk--wwiinnddooww [--aaddkk] [--ss _s_r_c_-_w_i_n_d_o_w] [--tt _d_s_t_-_w_i_n_d_o_w]
                   (alias: lliinnkkww)
             Link the window at _s_r_c_-_w_i_n_d_o_w to the specified _d_s_t_-_w_i_n_d_o_w.  If
             _d_s_t_-_w_i_n_d_o_w is specified and no such window exists, the _s_r_c_-_w_i_n_d_o_w
             is linked there.  With --aa, the window is moved to the next index
             up (following windows are moved if necessary).  If --kk is given
             and _d_s_t_-_w_i_n_d_o_w exists, it is killed, otherwise an error is gener-
             ated.  If --dd is given, the newly linked window is not selected.

     lliisstt--ppaanneess [--aass] [--FF _f_o_r_m_a_t] [--tt _t_a_r_g_e_t]
                   (alias: llsspp)
             If --aa is given, _t_a_r_g_e_t is ignored and all panes on the server are
             listed.  If --ss is given, _t_a_r_g_e_t is a session (or the current ses-
             sion).  If neither is given, _t_a_r_g_e_t is a window (or the current
             window).  For the meaning of the --FF flag, see the _F_O_R_M_A_T_S sec-
             tion.

     lliisstt--wwiinnddoowwss [--aa] [--FF _f_o_r_m_a_t] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                   (alias: llssww)
             If --aa is given, list all windows on the server.  Otherwise, list
             windows in the current session or in _t_a_r_g_e_t_-_s_e_s_s_i_o_n.  For the
             meaning of the --FF flag, see the _F_O_R_M_A_T_S section.

     mmoovvee--ppaannee [--bbddhhvv] [--ll _s_i_z_e | --pp _p_e_r_c_e_n_t_a_g_e] [--ss _s_r_c_-_p_a_n_e] [--tt _d_s_t_-_p_a_n_e]
                   (alias: mmoovveepp)
             Like jjooiinn--ppaannee, but _s_r_c_-_p_a_n_e and _d_s_t_-_p_a_n_e may belong to the same
             window.

     mmoovvee--wwiinnddooww [--aarrddkk] [--ss _s_r_c_-_w_i_n_d_o_w] [--tt _d_s_t_-_w_i_n_d_o_w]
                   (alias: mmoovveeww)
             This is similar to lliinnkk--wwiinnddooww, except the window at _s_r_c_-_w_i_n_d_o_w
             is moved to _d_s_t_-_w_i_n_d_o_w.  With --rr, all windows in the session are
             renumbered in sequential order, respecting the bbaassee--iinnddeexx option.

     nneeww--wwiinnddooww [--aaddkkPP] [--cc _s_t_a_r_t_-_d_i_r_e_c_t_o_r_y] [--FF _f_o_r_m_a_t] [--nn _w_i_n_d_o_w_-_n_a_m_e] [--tt
             _t_a_r_g_e_t_-_w_i_n_d_o_w] [_s_h_e_l_l_-_c_o_m_m_a_n_d]
                   (alias: nneewwww)
             Create a new window.  With --aa, the new window is inserted at the
             next index up from the specified _t_a_r_g_e_t_-_w_i_n_d_o_w, moving windows up
             if necessary, otherwise _t_a_r_g_e_t_-_w_i_n_d_o_w is the new window location.

             If --dd is given, the session does not make the new window the cur-
             rent window.  _t_a_r_g_e_t_-_w_i_n_d_o_w represents the window to be created;
             if the target already exists an error is shown, unless the --kk
             flag is used, in which case it is destroyed.  _s_h_e_l_l_-_c_o_m_m_a_n_d is
             the command to execute.  If _s_h_e_l_l_-_c_o_m_m_a_n_d is not specified, the
             value of the ddeeffaauulltt--ccoommmmaanndd option is used.  --cc specifies the
             working directory in which the new window is created.

             When the shell command completes, the window closes.  See the
             rreemmaaiinn--oonn--eexxiitt option to change this behaviour.

             The TERM environment variable must be set to `screen' or `tmux'
             for all programs running _i_n_s_i_d_e ttmmuuxx.  New windows will automati-
             cally have `TERM=screen' added to their environment, but care
             must be taken not to reset this in shell start-up files.

             The --PP option prints information about the new window after it
             has been created.  By default, it uses the format
             `#{session_name}:#{window_index}' but a different format may be
             specified with --FF.

     nneexxtt--llaayyoouutt [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
                   (alias: nneexxttll)
             Move a window to the next layout and rearrange the panes to fit.

     nneexxtt--wwiinnddooww [--aa] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                   (alias: nneexxtt)
             Move to the next window in the session.  If --aa is used, move to
             the next window with an alert.

     ppiippee--ppaannee [--IIOOoo] [--tt _t_a_r_g_e_t_-_p_a_n_e] [_s_h_e_l_l_-_c_o_m_m_a_n_d]
                   (alias: ppiippeepp)
             Pipe output sent by the program in _t_a_r_g_e_t_-_p_a_n_e to a shell command
             or vice versa.  A pane may only be connected to one command at a
             time, any existing pipe is closed before _s_h_e_l_l_-_c_o_m_m_a_n_d is exe-
             cuted.  The _s_h_e_l_l_-_c_o_m_m_a_n_d string may contain the special charac-
             ter sequences supported by the ssttaattuuss--lleefftt option.  If no
             _s_h_e_l_l_-_c_o_m_m_a_n_d is given, the current pipe (if any) is closed.

             --II and --OO specify which of the _s_h_e_l_l_-_c_o_m_m_a_n_d output streams are
             connected to the pane: with --II stdout is connected (so anything
             _s_h_e_l_l_-_c_o_m_m_a_n_d prints is written to the pane as if it were typed);
             with --OO stdin is connected (so any output in the pane is piped to
             _s_h_e_l_l_-_c_o_m_m_a_n_d).  Both may be used together and if neither are
             specified, --OO is used.

             The --oo option only opens a new pipe if no previous pipe exists,
             allowing a pipe to be toggled with a single key, for example:

                   bind-key C-p pipe-pane -o 'cat >>~/output.#I-#P'

     pprreevviioouuss--llaayyoouutt [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
                   (alias: pprreevvll)
             Move to the previous layout in the session.

     pprreevviioouuss--wwiinnddooww [--aa] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                   (alias: pprreevv)
             Move to the previous window in the session.  With --aa, move to the
             previous window with an alert.

     rreennaammee--wwiinnddooww [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w] _n_e_w_-_n_a_m_e
                   (alias: rreennaammeeww)
             Rename the current window, or the window at _t_a_r_g_e_t_-_w_i_n_d_o_w if
             specified, to _n_e_w_-_n_a_m_e.

     rreessiizzee--ppaannee [--DDLLMMRRUUZZ] [--tt _t_a_r_g_e_t_-_p_a_n_e] [--xx _w_i_d_t_h] [--yy _h_e_i_g_h_t]
             [_a_d_j_u_s_t_m_e_n_t]
                   (alias: rreessiizzeepp)
             Resize a pane, up, down, left or right by _a_d_j_u_s_t_m_e_n_t with --UU, --DD,
             --LL or --RR, or to an absolute size with --xx or --yy.  The _a_d_j_u_s_t_m_e_n_t
             is given in lines or cells (the default is 1).

             With --ZZ, the active pane is toggled between zoomed (occupying the
             whole of the window) and unzoomed (its normal position in the
             layout).

             --MM begins mouse resizing (only valid if bound to a mouse key
             binding, see _M_O_U_S_E _S_U_P_P_O_R_T).

     rreessiizzee--wwiinnddooww [--aaAADDLLRRUU] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w] [--xx _w_i_d_t_h] [--yy _h_e_i_g_h_t]
             [_a_d_j_u_s_t_m_e_n_t]
                   (alias: rreessiizzeeww)
             Resize a window, up, down, left or right by _a_d_j_u_s_t_m_e_n_t with --UU,
             --DD, --LL or --RR, or to an absolute size with --xx or --yy.  The
             _a_d_j_u_s_t_m_e_n_t is given in lines or cells (the default is 1).  --AA
             sets the size of the largest session containing the window; --aa
             the size of the smallest.  This command will automatically set
             wwiinnddooww--ssiizzee to manual in the window options.

     rreessppaawwnn--ppaannee [--cc _s_t_a_r_t_-_d_i_r_e_c_t_o_r_y] [--kk] [--tt _t_a_r_g_e_t_-_p_a_n_e] [_s_h_e_l_l_-_c_o_m_m_a_n_d]
                   (alias: rreessppaawwnnpp)
             Reactivate a pane in which the command has exited (see the
             rreemmaaiinn--oonn--eexxiitt window option).  If _s_h_e_l_l_-_c_o_m_m_a_n_d is not given,
             the command used when the pane was created is executed.  The pane
             must be already inactive, unless --kk is given, in which case any
             existing command is killed.  --cc specifies a new working directory
             for the pane.

     rreessppaawwnn--wwiinnddooww [--cc _s_t_a_r_t_-_d_i_r_e_c_t_o_r_y] [--kk] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
             [_s_h_e_l_l_-_c_o_m_m_a_n_d]
                   (alias: rreessppaawwnnww)
             Reactivate a window in which the command has exited (see the
             rreemmaaiinn--oonn--eexxiitt window option).  If _s_h_e_l_l_-_c_o_m_m_a_n_d is not given,
             the command used when the window was created is executed.  The
             window must be already inactive, unless --kk is given, in which
             case any existing command is killed.  --cc specifies a new working
             directory for the window.

     rroottaattee--wwiinnddooww [--DDUU] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
                   (alias: rroottaatteeww)
             Rotate the positions of the panes within a window, either upward
             (numerically lower) with --UU or downward (numerically higher).

     sseelleecctt--llaayyoouutt [--EEnnoopp] [--tt _t_a_r_g_e_t_-_p_a_n_e] [_l_a_y_o_u_t_-_n_a_m_e]
                   (alias: sseelleeccttll)
             Choose a specific layout for a window.  If _l_a_y_o_u_t_-_n_a_m_e is not
             given, the last preset layout used (if any) is reapplied.  --nn and
             --pp are equivalent to the nneexxtt--llaayyoouutt and pprreevviioouuss--llaayyoouutt com-
             mands.  --oo applies the last set layout if possible (undoes the
             most recent layout change).  --EE spreads the current pane and any
             panes next to it out evenly.

     sseelleecctt--ppaannee [--DDddeeggLLllMMmmRRUU] [--PP _s_t_y_l_e] [--TT _t_i_t_l_e] [--tt _t_a_r_g_e_t_-_p_a_n_e]
                   (alias: sseelleeccttpp)
             Make pane _t_a_r_g_e_t_-_p_a_n_e the active pane in window _t_a_r_g_e_t_-_w_i_n_d_o_w, or
             set its style (with --PP).  If one of --DD, --LL, --RR, or --UU is used,
             respectively the pane below, to the left, to the right, or above
             the target pane is used.  --ll is the same as using the llaasstt--ppaannee
             command.  --ee enables or --dd disables input to the pane.

             --mm and --MM are used to set and clear the _m_a_r_k_e_d _p_a_n_e.  There is
             one marked pane at a time, setting a new marked pane clears the
             last.  The marked pane is the default target for --ss to jjooiinn--ppaannee,
             sswwaapp--ppaannee and sswwaapp--wwiinnddooww.

             Each pane has a style: by default the wwiinnddooww--ssttyyllee and
             wwiinnddooww--aaccttiivvee--ssttyyllee options are used, sseelleecctt--ppaannee --PP sets the
             style for a single pane.  For example, to set the pane 1 back-
             ground to red:

                   select-pane -t:.1 -P 'bg=red'

             --gg shows the current pane style.

             --TT sets the pane title.

     sseelleecctt--wwiinnddooww [--llnnppTT] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
                   (alias: sseelleeccttww)
             Select the window at _t_a_r_g_e_t_-_w_i_n_d_o_w.  --ll, --nn and --pp are equivalent
             to the llaasstt--wwiinnddooww, nneexxtt--wwiinnddooww and pprreevviioouuss--wwiinnddooww commands.  If
             --TT is given and the selected window is already the current win-
             dow, the command behaves like llaasstt--wwiinnddooww.

     sspplliitt--wwiinnddooww [--bbddffhhvvPP] [--cc _s_t_a_r_t_-_d_i_r_e_c_t_o_r_y] [--ll _s_i_z_e | --pp _p_e_r_c_e_n_t_a_g_e] [--tt
             _t_a_r_g_e_t_-_p_a_n_e] [_s_h_e_l_l_-_c_o_m_m_a_n_d] [--FF _f_o_r_m_a_t]
                   (alias: sspplliittww)
             Create a new pane by splitting _t_a_r_g_e_t_-_p_a_n_e: --hh does a horizontal
             split and --vv a vertical split; if neither is specified, --vv is
             assumed.  The --ll and --pp options specify the size of the new pane
             in lines (for vertical split) or in cells (for horizontal split),
             or as a percentage, respectively.  The --bb option causes the new
             pane to be created to the left of or above _t_a_r_g_e_t_-_p_a_n_e.  The --ff
             option creates a new pane spanning the full window height (with
             --hh) or full window width (with --vv), instead of splitting the
             active pane.  All other options have the same meaning as for the
             nneeww--wwiinnddooww command.

     sswwaapp--ppaannee [--ddDDUU] [--ss _s_r_c_-_p_a_n_e] [--tt _d_s_t_-_p_a_n_e]
                   (alias: sswwaapppp)
             Swap two panes.  If --UU is used and no source pane is specified
             with --ss, _d_s_t_-_p_a_n_e is swapped with the previous pane (before it
             numerically); --DD swaps with the next pane (after it numerically).
             --dd instructs ttmmuuxx not to change the active pane.

             If --ss is omitted and a marked pane is present (see sseelleecctt--ppaannee
             --mm), the marked pane is used rather than the current pane.

     sswwaapp--wwiinnddooww [--dd] [--ss _s_r_c_-_w_i_n_d_o_w] [--tt _d_s_t_-_w_i_n_d_o_w]
                   (alias: sswwaappww)
             This is similar to lliinnkk--wwiinnddooww, except the source and destination
             windows are swapped.  It is an error if no window exists at
             _s_r_c_-_w_i_n_d_o_w.

             Like sswwaapp--ppaannee, if --ss is omitted and a marked pane is present
             (see sseelleecctt--ppaannee --mm), the window containing the marked pane is
             used rather than the current window.

     uunnlliinnkk--wwiinnddooww [--kk] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
                   (alias: uunnlliinnkkww)
             Unlink _t_a_r_g_e_t_-_w_i_n_d_o_w.  Unless --kk is given, a window may be
             unlinked only if it is linked to multiple sessions - windows may
             not be linked to no sessions; if --kk is specified and the window
             is linked to only one session, it is unlinked and destroyed.

KKEEYY BBIINNDDIINNGGSS
     ttmmuuxx allows a command to be bound to most keys, with or without a prefix
     key.  When specifying keys, most represent themselves (for example `A' to
     `Z').  Ctrl keys may be prefixed with `C-' or `^', and Alt (meta) with
     `M-'.  In addition, the following special key names are accepted: _U_p,
     _D_o_w_n, _L_e_f_t, _R_i_g_h_t, _B_S_p_a_c_e, _B_T_a_b, _D_C (Delete), _E_n_d, _E_n_t_e_r, _E_s_c_a_p_e, _F_1 to
     _F_1_2, _H_o_m_e, _I_C (Insert), _N_P_a_g_e_/_P_a_g_e_D_o_w_n_/_P_g_D_n, _P_P_a_g_e_/_P_a_g_e_U_p_/_P_g_U_p, _S_p_a_c_e,
     and _T_a_b.  Note that to bind the `"' or `'' keys, quotation marks are nec-
     essary, for example:

           bind-key '"' split-window
           bind-key "'" new-window

     Commands related to key bindings are as follows:

     bbiinndd--kkeeyy [--nnrr] [--TT _k_e_y_-_t_a_b_l_e] _k_e_y _c_o_m_m_a_n_d [_a_r_g_u_m_e_n_t_s]
                   (alias: bbiinndd)
             Bind key _k_e_y to _c_o_m_m_a_n_d.  Keys are bound in a key table.  By
             default (without -T), the key is bound in the _p_r_e_f_i_x key table.
             This table is used for keys pressed after the prefix key (for
             example, by default `c' is bound to nneeww--wwiinnddooww in the _p_r_e_f_i_x ta-
             ble, so `C-b c' creates a new window).  The _r_o_o_t table is used
             for keys pressed without the prefix key: binding `c' to
             nneeww--wwiinnddooww in the _r_o_o_t table (not recommended) means a plain `c'
             will create a new window.  --nn is an alias for --TT _r_o_o_t.  Keys may
             also be bound in custom key tables and the sswwiittcchh--cclliieenntt --TT com-
             mand used to switch to them from a key binding.  The --rr flag
             indicates this key may repeat, see the rreeppeeaatt--ttiimmee option.

             To view the default bindings and possible commands, see the
             lliisstt--kkeeyyss command.

     lliisstt--kkeeyyss [--TT _k_e_y_-_t_a_b_l_e]
                   (alias: llsskk)
             List all key bindings.  Without --TT all key tables are printed.
             With --TT only _k_e_y_-_t_a_b_l_e.

     sseenndd--kkeeyyss [--llMMRRXX] [--NN _r_e_p_e_a_t_-_c_o_u_n_t] [--tt _t_a_r_g_e_t_-_p_a_n_e] _k_e_y _._._.
                   (alias: sseenndd)
             Send a key or keys to a window.  Each argument _k_e_y is the name of
             the key (such as `C-a' or `NPage') to send; if the string is not
             recognised as a key, it is sent as a series of characters.  The
             --ll flag disables key name lookup and sends the keys literally.
             All arguments are sent sequentially from first to last.  The --RR
             flag causes the terminal state to be reset.

             --MM passes through a mouse event (only valid if bound to a mouse
             key binding, see _M_O_U_S_E _S_U_P_P_O_R_T).

             --XX is used to send a command into copy mode - see the _W_I_N_D_O_W_S _A_N_D
             _P_A_N_E_S section.  --NN specifies a repeat count.

     sseenndd--pprreeffiixx [--22] [--tt _t_a_r_g_e_t_-_p_a_n_e]
             Send the prefix key, or with --22 the secondary prefix key, to a
             window as if it was pressed.

     uunnbbiinndd--kkeeyy [--aann] [--TT _k_e_y_-_t_a_b_l_e] _k_e_y
                   (alias: uunnbbiinndd)
             Unbind the command bound to _k_e_y.  --nn and --TT are the same as for
             bbiinndd--kkeeyy.  If --aa is present, all key bindings are removed.

OOPPTTIIOONNSS
     The appearance and behaviour of ttmmuuxx may be modified by changing the
     value of various options.  There are three types of option: _s_e_r_v_e_r
     _o_p_t_i_o_n_s, _s_e_s_s_i_o_n _o_p_t_i_o_n_s and _w_i_n_d_o_w _o_p_t_i_o_n_s.

     The ttmmuuxx server has a set of global options which do not apply to any
     particular window or session.  These are altered with the sseett--ooppttiioonn --ss
     command, or displayed with the sshhooww--ooppttiioonnss --ss command.

     In addition, each individual session may have a set of session options,
     and there is a separate set of global session options.  Sessions which do
     not have a particular option configured inherit the value from the global
     session options.  Session options are set or unset with the sseett--ooppttiioonn
     command and may be listed with the sshhooww--ooppttiioonnss command.  The available
     server and session options are listed under the sseett--ooppttiioonn command.

     Similarly, a set of window options is attached to each window, and there
     is a set of global window options from which any unset options are inher-
     ited.  Window options are altered with the sseett--wwiinnddooww--ooppttiioonn command and
     can be listed with the sshhooww--wwiinnddooww--ooppttiioonnss command.  All window options
     are documented with the sseett--wwiinnddooww--ooppttiioonn command.

     ttmmuuxx also supports user options which are prefixed with a `@'.  User
     options may have any name, so long as they are prefixed with `@', and be
     set to any string.  For example:

           $ tmux setw -q @foo "abc123"
           $ tmux showw -v @foo
           abc123

     Commands which set options are as follows:

     sseett--ooppttiioonn [--aaFFggooqqssuuww] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n | _t_a_r_g_e_t_-_w_i_n_d_o_w] _o_p_t_i_o_n _v_a_l_u_e
                   (alias: sseett)
             Set a window option with --ww (equivalent to the sseett--wwiinnddooww--ooppttiioonn
             command), a server option with --ss, otherwise a session option.
             If --gg is given, the global session or window option is set.  --FF
             expands formats in the option value.  The --uu flag unsets an
             option, so a session inherits the option from the global options
             (or with --gg, restores a global option to the default).

             The --oo flag prevents setting an option that is already set and
             the --qq flag suppresses errors about unknown or ambiguous options.

             With --aa, and if the option expects a string or a style, _v_a_l_u_e is
             appended to the existing setting.  For example:

                   set -g status-left "foo"
                   set -ag status-left "bar"

             Will result in `foobar'.  And:

                   set -g status-style "bg=red"
                   set -ag status-style "fg=blue"

             Will result in a red background _a_n_d blue foreground.  Without --aa,
             the result would be the default background and a blue foreground.

             Available window options are listed under sseett--wwiinnddooww--ooppttiioonn.

             _v_a_l_u_e depends on the option and may be a number, a string, or a
             flag (on, off, or omitted to toggle).

             Available server options are:

             bbuuffffeerr--lliimmiitt _n_u_m_b_e_r
                     Set the number of buffers; as new buffers are added to
                     the top of the stack, old ones are removed from the bot-
                     tom if necessary to maintain this maximum length.

             ccoommmmaanndd--aalliiaass[[]] _n_a_m_e_=_v_a_l_u_e
                     This is an array of custom aliases for commands.  If an
                     unknown command matches _n_a_m_e, it is replaced with _v_a_l_u_e.
                     For example, after:

                           set -s command-alias[100] zoom='resize-pane -Z'

                     Using:

                           zoom -t:.1

                     Is equivalent to:

                           resize-pane -Z -t:.1

                     Note that aliases are expanded when a command is parsed
                     rather than when it is executed, so binding an alias with
                     bbiinndd--kkeeyy will bind the expanded form.

             ddeeffaauulltt--tteerrmmiinnaall _t_e_r_m_i_n_a_l
                     Set the default terminal for new windows created in this
                     session - the default value of the TERM environment vari-
                     able.  For ttmmuuxx to work correctly, this _m_u_s_t be set to
                     `screen', `tmux' or a derivative of them.

             eessccaappee--ttiimmee _t_i_m_e
                     Set the time in milliseconds for which ttmmuuxx waits after
                     an escape is input to determine if it is part of a func-
                     tion or meta key sequences.  The default is 500 millisec-
                     onds.

             eexxiitt--eemmppttyy [oonn | ooffff]
                     If enabled (the default), the server will exit when there
                     are no active sessions.

             eexxiitt--uunnaattttaacchheedd [oonn | ooffff]
                     If enabled, the server will exit when there are no
                     attached clients.

             ffooccuuss--eevveennttss [oonn | ooffff]
                     When enabled, focus events are requested from the termi-
                     nal if supported and passed through to applications run-
                     ning in ttmmuuxx.  Attached clients should be detached and
                     attached again after changing this option.

             hhiissttoorryy--ffiillee _p_a_t_h
                     If not empty, a file to which ttmmuuxx will write command
                     prompt history on exit and load it from on start.

             mmeessssaaggee--lliimmiitt _n_u_m_b_e_r
                     Set the number of error or information messages to save
                     in the message log for each client.  The default is 100.

             sseett--cclliippbbooaarrdd [oonn | eexxtteerrnnaall | ooffff]
                     Attempt to set the terminal clipboard content using the
                     xterm(1) escape sequence, if there is an _M_s entry in the
                     terminfo(5) description (see the _T_E_R_M_I_N_F_O _E_X_T_E_N_S_I_O_N_S sec-
                     tion).

                     If set to oonn, ttmmuuxx will both accept the escape sequence
                     to create a buffer and attempt to set the terminal clip-
                     board.  If set to eexxtteerrnnaall, ttmmuuxx will attempt to set the
                     terminal clipboard but ignore attempts by applications to
                     set ttmmuuxx buffers.  If ooffff, ttmmuuxx will neither accept the
                     clipboard escape sequence nor attempt to set the clip-
                     board.

                     Note that this feature needs to be enabled in xterm(1) by
                     setting the resource:

                           disallowedWindowOps: 20,21,SetXprop

                     Or changing this property from the xterm(1) interactive
                     menu when required.

             tteerrmmiinnaall--oovveerrrriiddeess[[]] _s_t_r_i_n_g
                     Allow terminal descriptions read using terminfo(5) to be
                     overridden.  Each entry is a colon-separated string made
                     up of a terminal type pattern (matched using fnmatch(3))
                     and a set of _n_a_m_e_=_v_a_l_u_e entries.

                     For example, to set the `clear' terminfo(5) entry to
                     `\e[H\e[2J' for all terminal types matching `rxvt*':

                           rxvt*:clear=\e[H\e[2J

                     The terminal entry value is passed through strunvis(3)
                     before interpretation.

             Available session options are:

             aaccttiivviittyy--aaccttiioonn [aannyy | nnoonnee | ccuurrrreenntt | ootthheerr]
                     Set action on window activity when mmoonniittoorr--aaccttiivviittyy is
                     on.  aannyy means activity in any window linked to a session
                     causes a bell or message (depending on vviissuuaall--aaccttiivviittyy)
                     in the current window of that session, nnoonnee means all
                     activity is ignored (equivalent to mmoonniittoorr--aaccttiivviittyy being
                     off), ccuurrrreenntt means only activity in windows other than
                     the current window are ignored and ootthheerr means activity
                     in the current window is ignored but not those in other
                     windows.

             aassssuummee--ppaassttee--ttiimmee _m_i_l_l_i_s_e_c_o_n_d_s
                     If keys are entered faster than one in _m_i_l_l_i_s_e_c_o_n_d_s, they
                     are assumed to have been pasted rather than typed and
                     ttmmuuxx key bindings are not processed.  The default is one
                     millisecond and zero disables.

             bbaassee--iinnddeexx _i_n_d_e_x
                     Set the base index from which an unused index should be
                     searched when a new window is created.  The default is
                     zero.

             bbeellll--aaccttiioonn [aannyy | nnoonnee | ccuurrrreenntt | ootthheerr]
                     Set action on a bell in a window when mmoonniittoorr--bbeellll is on.
                     The values are the same as those for aaccttiivviittyy--aaccttiioonn.

             ddeeffaauulltt--ccoommmmaanndd _s_h_e_l_l_-_c_o_m_m_a_n_d
                     Set the command used for new windows (if not specified
                     when the window is created) to _s_h_e_l_l_-_c_o_m_m_a_n_d, which may
                     be any sh(1) command.  The default is an empty string,
                     which instructs ttmmuuxx to create a login shell using the
                     value of the ddeeffaauulltt--sshheellll option.

             ddeeffaauulltt--ssiizzee _X_x_Y
                     Set the default size of new windows when the _w_i_n_d_o_w_-_s_i_z_e
                     option is set to manual or when a session is created with
                     nneeww--sseessssiioonn --dd.  The value is the width and height sepa-
                     rated by an `x' character.  The default is 80x24.

             ddeeffaauulltt--sshheellll _p_a_t_h
                     Specify the default shell.  This is used as the login
                     shell for new windows when the ddeeffaauulltt--ccoommmmaanndd option is
                     set to empty, and must be the full path of the exe-
                     cutable.  When started ttmmuuxx tries to set a default value
                     from the first suitable of the SHELL environment vari-
                     able, the shell returned by getpwuid(3), or _/_b_i_n_/_s_h.
                     This option should be configured when ttmmuuxx is used as a
                     login shell.

             ddeeffaauulltt--ssiizzee _X_x_Y
                     Set the default size of windows when the size is not set
                     or the wwiinnddooww--ssiizzee option is manual.

             ddeessttrrooyy--uunnaattttaacchheedd [oonn | ooffff]
                     If enabled and the session is no longer attached to any
                     clients, it is destroyed.

             ddeettaacchh--oonn--ddeessttrrooyy [oonn | ooffff]
                     If on (the default), the client is detached when the ses-
                     sion it is attached to is destroyed.  If off, the client
                     is switched to the most recently active of the remaining
                     sessions.

             ddiissppllaayy--ppaanneess--aaccttiivvee--ccoolloouurr _c_o_l_o_u_r
                     Set the colour used by the ddiissppllaayy--ppaanneess command to show
                     the indicator for the active pane.

             ddiissppllaayy--ppaanneess--ccoolloouurr _c_o_l_o_u_r
                     Set the colour used by the ddiissppllaayy--ppaanneess command to show
                     the indicators for inactive panes.

             ddiissppllaayy--ppaanneess--ttiimmee _t_i_m_e
                     Set the time in milliseconds for which the indicators
                     shown by the ddiissppllaayy--ppaanneess command appear.

             ddiissppllaayy--ttiimmee _t_i_m_e
                     Set the amount of time for which status line messages and
                     other on-screen indicators are displayed.  If set to 0,
                     messages and indicators are displayed until a key is
                     pressed.  _t_i_m_e is in milliseconds.

             hhiissttoorryy--lliimmiitt _l_i_n_e_s
                     Set the maximum number of lines held in window history.
                     This setting applies only to new windows - existing win-
                     dow histories are not resized and retain the limit at the
                     point they were created.

             kkeeyy--ttaabbllee _k_e_y_-_t_a_b_l_e
                     Set the default key table to _k_e_y_-_t_a_b_l_e instead of _r_o_o_t.

             lloocckk--aafftteerr--ttiimmee _n_u_m_b_e_r
                     Lock the session (like the lloocckk--sseessssiioonn command) after
                     _n_u_m_b_e_r seconds of inactivity.  The default is not to lock
                     (set to 0).

             lloocckk--ccoommmmaanndd _s_h_e_l_l_-_c_o_m_m_a_n_d
                     Command to run when locking each client.  The default is
                     to run lock(1) with --nnpp.

             mmeessssaaggee--ccoommmmaanndd--ssttyyllee _s_t_y_l_e
                     Set status line message command style.  For how to spec-
                     ify _s_t_y_l_e, see the _S_T_Y_L_E_S section.

             mmeessssaaggee--ssttyyllee _s_t_y_l_e
                     Set status line message style.  For how to specify _s_t_y_l_e,
                     see the _S_T_Y_L_E_S section.

             mmoouussee [oonn | ooffff]
                     If on, ttmmuuxx captures the mouse and allows mouse events to
                     be bound as key bindings.  See the _M_O_U_S_E _S_U_P_P_O_R_T section
                     for details.

             pprreeffiixx _k_e_y
                     Set the key accepted as a prefix key.  In addition to the
                     standard keys described under _K_E_Y _B_I_N_D_I_N_G_S, pprreeffiixx can be
                     set to the special key `None' to set no prefix.

             pprreeffiixx22 _k_e_y
                     Set a secondary key accepted as a prefix key.  Like
                     pprreeffiixx, pprreeffiixx22 can be set to `None'.

             rreennuummbbeerr--wwiinnddoowwss [oonn | ooffff]
                     If on, when a window is closed in a session, automati-
                     cally renumber the other windows in numerical order.
                     This respects the bbaassee--iinnddeexx option if it has been set.
                     If off, do not renumber the windows.

             rreeppeeaatt--ttiimmee _t_i_m_e
                     Allow multiple commands to be entered without pressing
                     the prefix-key again in the specified _t_i_m_e milliseconds
                     (the default is 500).  Whether a key repeats may be set
                     when it is bound using the --rr flag to bbiinndd--kkeeyy.  Repeat
                     is enabled for the default keys bound to the rreessiizzee--ppaannee
                     command.

             sseett--ttiittlleess [oonn | ooffff]
                     Attempt to set the client terminal title using the _t_s_l
                     and _f_s_l terminfo(5) entries if they exist.  ttmmuuxx automat-
                     ically sets these to the \e]0;...\007 sequence if the
                     terminal appears to be xterm(1).  This option is off by
                     default.

             sseett--ttiittlleess--ssttrriinngg _s_t_r_i_n_g
                     String used to set the window title if sseett--ttiittlleess is on.
                     Formats are expanded, see the _F_O_R_M_A_T_S section.

             ssiilleennccee--aaccttiioonn [aannyy | nnoonnee | ccuurrrreenntt | ootthheerr]
                     Set action on window silence when mmoonniittoorr--ssiilleennccee is on.
                     The values are the same as those for aaccttiivviittyy--aaccttiioonn.

             ssttaattuuss [ooffff | oonn | 22 | 33 | 44 | 55]
                     Show or hide the status line or specify its size.  Using
                     oonn gives a status line one row in height; 22, 33, 44 or 55
                     more rows.

             ssttaattuuss--ffoorrmmaatt[[]] _f_o_r_m_a_t
                     Specify the format to be used for each line of the status
                     line.  The default builds the top status line from the
                     various individual status options below.

             ssttaattuuss--iinntteerrvvaall _i_n_t_e_r_v_a_l
                     Update the status line every _i_n_t_e_r_v_a_l seconds.  By
                     default, updates will occur every 15 seconds.  A setting
                     of zero disables redrawing at interval.

             ssttaattuuss--jjuussttiiffyy [lleefftt | cceennttrree | rriigghhtt]
                     Set the position of the window list component of the sta-
                     tus line: left, centre or right justified.

             ssttaattuuss--kkeeyyss [vvii | eemmaaccss]
                     Use vi or emacs-style key bindings in the status line,
                     for example at the command prompt.  The default is emacs,
                     unless the VISUAL or EDITOR environment variables are set
                     and contain the string `vi'.

             ssttaattuuss--lleefftt _s_t_r_i_n_g
                     Display _s_t_r_i_n_g (by default the session name) to the left
                     of the status line.  _s_t_r_i_n_g will be passed through
                     strftime(3).  Also see the _F_O_R_M_A_T_S and _S_T_Y_L_E_S sections.

                     For details on how the names and titles can be set see
                     the _N_A_M_E_S _A_N_D _T_I_T_L_E_S section.

                     Examples are:

                           #(sysctl vm.loadavg)
                           #[fg=yellow,bold]#(apm -l)%%#[default] [#S]

                     The default is `[#S] '.

             ssttaattuuss--lleefftt--lleennggtthh _l_e_n_g_t_h
                     Set the maximum _l_e_n_g_t_h of the left component of the sta-
                     tus line.  The default is 10.

             ssttaattuuss--lleefftt--ssttyyllee _s_t_y_l_e
                     Set the style of the left part of the status line.  For
                     how to specify _s_t_y_l_e, see the _S_T_Y_L_E_S section.

             ssttaattuuss--ppoossiittiioonn [ttoopp | bboottttoomm]
                     Set the position of the status line.

             ssttaattuuss--rriigghhtt _s_t_r_i_n_g
                     Display _s_t_r_i_n_g to the right of the status line.  By
                     default, the current pane title in double quotes, the
                     date and the time are shown.  As with ssttaattuuss--lleefftt, _s_t_r_i_n_g
                     will be passed to strftime(3) and character pairs are
                     replaced.

             ssttaattuuss--rriigghhtt--lleennggtthh _l_e_n_g_t_h
                     Set the maximum _l_e_n_g_t_h of the right component of the sta-
                     tus line.  The default is 40.

             ssttaattuuss--rriigghhtt--ssttyyllee _s_t_y_l_e
                     Set the style of the right part of the status line.  For
                     how to specify _s_t_y_l_e, see the _S_T_Y_L_E_S section.

             ssttaattuuss--ssttyyllee _s_t_y_l_e
                     Set status line style.  For how to specify _s_t_y_l_e, see the
                     _S_T_Y_L_E_S section.

             uuppddaattee--eennvviirroonnmmeenntt[[]] _v_a_r_i_a_b_l_e
                     Set list of environment variables to be copied into the
                     session environment when a new session is created or an
                     existing session is attached.  Any variables that do not
                     exist in the source environment are set to be removed
                     from the session environment (as if --rr was given to the
                     sseett--eennvviirroonnmmeenntt command).

             uusseerr--kkeeyyss[[]] _k_e_y
                     Set list of user-defined key escape sequences.  Each item
                     is associated with a key named `User0', `User1', and so
                     on.

                     For example:

                           set -s user-keys[0] "\e[5;30012~"
                           bind User0 resize-pane -L 3

             vviissuuaall--aaccttiivviittyy [oonn | ooffff | bbootthh]
                     If on, display a message instead of sending a bell when
                     activity occurs in a window for which the
                     mmoonniittoorr--aaccttiivviittyy window option is enabled.  If set to
                     both, a bell and a message are produced.

             vviissuuaall--bbeellll [oonn | ooffff | bbootthh]
                     If on, a message is shown on a bell in a window for which
                     the mmoonniittoorr--bbeellll window option is enabled instead of it
                     being passed through to the terminal (which normally
                     makes a sound).  If set to both, a bell and a message are
                     produced.  Also see the bbeellll--aaccttiioonn option.

             vviissuuaall--ssiilleennccee [oonn | ooffff | bbootthh]
                     If mmoonniittoorr--ssiilleennccee is enabled, prints a message after the
                     interval has expired on a given window instead of sending
                     a bell.  If set to both, a bell and a message are pro-
                     duced.

             wwoorrdd--sseeppaarraattoorrss _s_t_r_i_n_g
                     Sets the session's conception of what characters are con-
                     sidered word separators, for the purposes of the next and
                     previous word commands in copy mode.  The default is
                     ` -_@'.

     sseett--wwiinnddooww--ooppttiioonn [--aaFFggooqquu] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w] _o_p_t_i_o_n _v_a_l_u_e
                   (alias: sseettww)
             Set a window option.  The --aa, --FF, --gg, --oo, --qq and --uu flags work
             similarly to the sseett--ooppttiioonn command.

             Supported window options are:

             aaggggrreessssiivvee--rreessiizzee [oonn | ooffff]
                     Aggressively resize the chosen window.  This means that
                     ttmmuuxx will resize the window to the size of the smallest
                     or largest session (see the wwiinnddooww--ssiizzee option) for which
                     it is the current window, rather than the session to
                     which it is attached.  The window may resize when the
                     current window is changed on another session; this option
                     is good for full-screen programs which support SIGWINCH
                     and poor for interactive programs such as shells.

             aallllooww--rreennaammee [oonn | ooffff]
                     Allow programs to change the window name using a terminal
                     escape sequence (\ek...\e\\).  The default is off.

             aalltteerrnnaattee--ssccrreeeenn [oonn | ooffff]
                     This option configures whether programs running inside
                     ttmmuuxx may use the terminal alternate screen feature, which
                     allows the _s_m_c_u_p and _r_m_c_u_p terminfo(5) capabilities.  The
                     alternate screen feature preserves the contents of the
                     window when an interactive application starts and
                     restores it on exit, so that any output visible before
                     the application starts reappears unchanged after it
                     exits.  The default is on.

             aauuttoommaattiicc--rreennaammee [oonn | ooffff]
                     Control automatic window renaming.  When this setting is
                     enabled, ttmmuuxx will rename the window automatically using
                     the format specified by aauuttoommaattiicc--rreennaammee--ffoorrmmaatt.  This
                     flag is automatically disabled for an individual window
                     when a name is specified at creation with nneeww--wwiinnddooww or
                     nneeww--sseessssiioonn, or later with rreennaammee--wwiinnddooww, or with a ter-
                     minal escape sequence.  It may be switched off globally
                     with:

                           set-window-option -g automatic-rename off

             aauuttoommaattiicc--rreennaammee--ffoorrmmaatt _f_o_r_m_a_t
                     The format (see _F_O_R_M_A_T_S) used when the aauuttoommaattiicc--rreennaammee
                     option is enabled.

             cclloocckk--mmooddee--ccoolloouurr _c_o_l_o_u_r
                     Set clock colour.

             cclloocckk--mmooddee--ssttyyllee [1122 | 2244]
                     Set clock hour format.

             mmaaiinn--ppaannee--hheeiigghhtt _h_e_i_g_h_t
             mmaaiinn--ppaannee--wwiiddtthh _w_i_d_t_h
                     Set the width or height of the main (left or top) pane in
                     the mmaaiinn--hhoorriizzoonnttaall or mmaaiinn--vveerrttiiccaall layouts.

             mmooddee--kkeeyyss [vvii | eemmaaccss]
                     Use vi or emacs-style key bindings in copy mode.  The
                     default is emacs, unless VISUAL or EDITOR contains `vi'.

             mmooddee--ssttyyllee _s_t_y_l_e
                     Set window modes style.  For how to specify _s_t_y_l_e, see
                     the _S_T_Y_L_E_S section.

             mmoonniittoorr--aaccttiivviittyy [oonn | ooffff]
                     Monitor for activity in the window.  Windows with activ-
                     ity are highlighted in the status line.

             mmoonniittoorr--bbeellll [oonn | ooffff]
                     Monitor for a bell in the window.  Windows with a bell
                     are highlighted in the status line.

             mmoonniittoorr--ssiilleennccee [iinntteerrvvaall]
                     Monitor for silence (no activity) in the window within
                     iinntteerrvvaall seconds.  Windows that have been silent for the
                     interval are highlighted in the status line.  An interval
                     of zero disables the monitoring.

             ootthheerr--ppaannee--hheeiigghhtt _h_e_i_g_h_t
                     Set the height of the other panes (not the main pane) in
                     the mmaaiinn--hhoorriizzoonnttaall layout.  If this option is set to 0
                     (the default), it will have no effect.  If both the
                     mmaaiinn--ppaannee--hheeiigghhtt and ootthheerr--ppaannee--hheeiigghhtt options are set,
                     the main pane will grow taller to make the other panes
                     the specified height, but will never shrink to do so.

             ootthheerr--ppaannee--wwiiddtthh _w_i_d_t_h
                     Like ootthheerr--ppaannee--hheeiigghhtt, but set the width of other panes
                     in the mmaaiinn--vveerrttiiccaall layout.

             ppaannee--aaccttiivvee--bboorrddeerr--ssttyyllee _s_t_y_l_e
                     Set the pane border style for the currently active pane.
                     For how to specify _s_t_y_l_e, see the _S_T_Y_L_E_S section.
                     Attributes are ignored.

             ppaannee--bbaassee--iinnddeexx _i_n_d_e_x
                     Like bbaassee--iinnddeexx, but set the starting index for pane num-
                     bers.

             ppaannee--bboorrddeerr--ffoorrmmaatt _f_o_r_m_a_t
                     Set the text shown in pane border status lines.

             ppaannee--bboorrddeerr--ssttaattuuss [ooffff | ttoopp | bboottttoomm]
                     Turn pane border status lines off or set their position.

             ppaannee--bboorrddeerr--ssttyyllee _s_t_y_l_e
                     Set the pane border style for panes aside from the active
                     pane.  For how to specify _s_t_y_l_e, see the _S_T_Y_L_E_S section.
                     Attributes are ignored.

             rreemmaaiinn--oonn--eexxiitt [oonn | ooffff]
                     A window with this flag set is not destroyed when the
                     program running in it exits.  The window may be reacti-
                     vated with the rreessppaawwnn--wwiinnddooww command.

             ssyynncchhrroonniizzee--ppaanneess [oonn | ooffff]
                     Duplicate input to any pane to all other panes in the
                     same window (only for panes that are not in any special
                     mode).

             wwiinnddooww--aaccttiivvee--ssttyyllee _s_t_y_l_e
                     Set the style for the window's active pane.  For how to
                     specify _s_t_y_l_e, see the _S_T_Y_L_E_S section.

             wwiinnddooww--ssttaattuuss--aaccttiivviittyy--ssttyyllee _s_t_y_l_e
                     Set status line style for windows with an activity alert.
                     For how to specify _s_t_y_l_e, see the _S_T_Y_L_E_S section.

             wwiinnddooww--ssttaattuuss--bbeellll--ssttyyllee _s_t_y_l_e
                     Set status line style for windows with a bell alert.  For
                     how to specify _s_t_y_l_e, see the _S_T_Y_L_E_S section.

             wwiinnddooww--ssttaattuuss--ccuurrrreenntt--ffoorrmmaatt _s_t_r_i_n_g
                     Like _w_i_n_d_o_w_-_s_t_a_t_u_s_-_f_o_r_m_a_t, but is the format used when
                     the window is the current window.

             wwiinnddooww--ssttaattuuss--ccuurrrreenntt--ssttyyllee _s_t_y_l_e
                     Set status line style for the currently active window.
                     For how to specify _s_t_y_l_e, see the _S_T_Y_L_E_S section.

             wwiinnddooww--ssttaattuuss--ffoorrmmaatt _s_t_r_i_n_g
                     Set the format in which the window is displayed in the
                     status line window list.  See the _F_O_R_M_A_T_S and _S_T_Y_L_E_S sec-
                     tions.

             wwiinnddooww--ssttaattuuss--llaasstt--ssttyyllee _s_t_y_l_e
                     Set status line style for the last active window.  For
                     how to specify _s_t_y_l_e, see the _S_T_Y_L_E_S section.

             wwiinnddooww--ssttaattuuss--sseeppaarraattoorr _s_t_r_i_n_g
                     Sets the separator drawn between windows in the status
                     line.  The default is a single space character.

             wwiinnddooww--ssttaattuuss--ssttyyllee _s_t_y_l_e
                     Set status line style for a single window.  For how to
                     specify _s_t_y_l_e, see the _S_T_Y_L_E_S section.

             wwiinnddooww--ssiizzee _l_a_r_g_e_s_t | _s_m_a_l_l_e_s_t | _m_a_n_u_a_l
                     Configure how ttmmuuxx determines the window size.  If set to
                     _l_a_r_g_e_s_t, the size of the largest attached session is
                     used; if _s_m_a_l_l_e_s_t, the size of the smallest.  If _m_a_n_u_a_l,
                     the size of a new window is set from the ddeeffaauulltt--ssiizzee
                     option and windows are resized automatically.  See also
                     the rreessiizzee--wwiinnddooww command and the aaggggrreessssiivvee--rreessiizzee
                     option.

             wwiinnddooww--ssttyyllee _s_t_y_l_e
                     Set the default window style.  For how to specify _s_t_y_l_e,
                     see the _S_T_Y_L_E_S section.

             wwiinnddooww--ssiizzee [ssmmaalllleesstt | llaarrggeesstt | mmaannuuaall]
                     Tell ttmmuuxx how to automatically size windows either the
                     size of the smallest session containing the window, the
                     size of the largest, or manual size.  See also the
                     rreessiizzee--wwiinnddooww command and the ddeeffaauulltt--ssiizzee and
                     aaggggrreessssiivvee--rreessiizzee options.

             wwrraapp--sseeaarrcchh [oonn | ooffff]
                     If this option is set, searches will wrap around the end
                     of the pane contents.  The default is on.

             xxtteerrmm--kkeeyyss [oonn | ooffff]
                     If this option is set, ttmmuuxx will generate xterm(1) -style
                     function key sequences; these have a number included to
                     indicate modifiers such as Shift, Alt or Ctrl.

     sshhooww--ooppttiioonnss [--ggqqssvvww] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n | _t_a_r_g_e_t_-_w_i_n_d_o_w] [_o_p_t_i_o_n]
                   (alias: sshhooww)
             Show the window options (or a single window option if given) with
             --ww (equivalent to sshhooww--wwiinnddooww--ooppttiioonnss), the server options with
             --ss, otherwise the session options for _t_a_r_g_e_t _s_e_s_s_i_o_n.  Global
             session or window options are listed if --gg is used.  --vv shows
             only the option value, not the name.  If --qq is set, no error will
             be returned if _o_p_t_i_o_n is unset.

     sshhooww--wwiinnddooww--ooppttiioonnss [--ggvv] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w] [_o_p_t_i_o_n]
                   (alias: sshhoowwww)
             List the window options or a single option for _t_a_r_g_e_t_-_w_i_n_d_o_w, or
             the global window options if --gg is used.  --vv shows only the
             option value, not the name.

HHOOOOKKSS
     ttmmuuxx allows commands to run on various triggers, called _h_o_o_k_s.  Most ttmmuuxx
     commands have an _a_f_t_e_r hook and there are a number of hooks not associ-
     ated with commands.

     A command's after hook is run after it completes, except when the command
     is run as part of a hook itself.  They are named with an `after-' prefix.
     For example, the following command adds a hook to select the even-verti-
     cal layout after every sspplliitt--wwiinnddooww:

           set-hook after-split-window "selectl even-vertical"

     All the notifications listed in the _C_O_N_T_R_O_L _M_O_D_E section are hooks (with-
     out any arguments), except %%eexxiitt.  The following additional hooks are
     available:

     alert-activity          Run when a window has activity.  See
                             mmoonniittoorr--aaccttiivviittyy.

     alert-bell              Run when a window has received a bell.  See
                             mmoonniittoorr--bbeellll.

     alert-silence           Run when a window has been silent.  See
                             mmoonniittoorr--ssiilleennccee.

     client-attached         Run when a client is attached.

     client-detached         Run when a client is detached

     client-resized          Run when a client is resized.

     client-session-changed  Run when a client's attached session is changed.

     pane-died               Run when the program running in a pane exits, but
                             rreemmaaiinn--oonn--eexxiitt is on so the pane has not closed.

     pane-exited             Run when the program running in a pane exits.

     pane-focus-in           Run when the focus enters a pane, if the
                             ffooccuuss--eevveennttss option is on.

     pane-focus-out          Run when the focus exits a pane, if the
                             ffooccuuss--eevveennttss option is on.

     pane-set-clipboard      Run when the terminal clipboard is set using the
                             xterm(1) escape sequence.

     session-created         Run when a new session created.

     session-closed          Run when a session closed.

     session-renamed         Run when a session is renamed.

     window-linked           Run when a window is linked into a session.

     window-renamed          Run when a window is renamed.

     window-unlinked         Run when a window is unlinked from a session.

     Hooks are managed with these commands:

     sseett--hhooookk [--ggRRuu] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n] _h_o_o_k_-_n_a_m_e _c_o_m_m_a_n_d
             Without --RR, sets (or with --uu unsets) hook _h_o_o_k_-_n_a_m_e to _c_o_m_m_a_n_d.
             If --gg is given, _h_o_o_k_-_n_a_m_e is added to the global list of hooks,
             otherwise it is added to the session hooks (for _t_a_r_g_e_t_-_s_e_s_s_i_o_n
             with --tt).  Like options, session hooks inherit from the global
             ones.

             With --RR, run _h_o_o_k_-_n_a_m_e immediately.

     sshhooww--hhooookkss [--gg] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
             Shows the global list of hooks with --gg, otherwise the session
             hooks.

MMOOUUSSEE SSUUPPPPOORRTT
     If the mmoouussee option is on (the default is off), ttmmuuxx allows mouse events
     to be bound as keys.  The name of each key is made up of a mouse event
     (such as `MouseUp1') and a location suffix, one of the following:

           Pane             the contents of a pane
           Border           a pane border
           Status           the status line window list
           StatusLeft       the left part of the status line
           StatusRight      the right part of the status line
           StatusDefault    any other part of the status line

     The following mouse events are available:

           WheelUp       WheelDown
           MouseDown1    MouseUp1      MouseDrag1   MouseDragEnd1
           MouseDown2    MouseUp2      MouseDrag2   MouseDragEnd2
           MouseDown3    MouseUp3      MouseDrag3   MouseDragEnd3
           DoubleClick1  DoubleClick2  DoubleClick3
           TripleClick1  TripleClick2  TripleClick3

     Each should be suffixed with a location, for example `MouseDown1Status'.

     The special token `{mouse}' or `=' may be used as _t_a_r_g_e_t_-_w_i_n_d_o_w or
     _t_a_r_g_e_t_-_p_a_n_e in commands bound to mouse key bindings.  It resolves to the
     window or pane over which the mouse event took place (for example, the
     window in the status line over which button 1 was released for a
     `MouseUp1Status' binding, or the pane over which the wheel was scrolled
     for a `WheelDownPane' binding).

     The sseenndd--kkeeyyss --MM flag may be used to forward a mouse event to a pane.

     The default key bindings allow the mouse to be used to select and resize
     panes, to copy text and to change window using the status line.  These
     take effect if the mmoouussee option is turned on.

FFOORRMMAATTSS
     Certain commands accept the --FF flag with a _f_o_r_m_a_t argument.  This is a
     string which controls the output format of the command.  Replacement
     variables are enclosed in `#{' and `}', for example `#{session_name}'.
     The possible variables are listed in the table below, or the name of a
     ttmmuuxx option may be used for an option's value.  Some variables have a
     shorter alias such as `#S'; `##' is replaced by a single `#', `#,' by a
     `,' and `#}' by a `}'.

     Conditionals are available by prefixing with `?' and separating two
     alternatives with a comma; if the specified variable exists and is not
     zero, the first alternative is chosen, otherwise the second is used.  For
     example `#{?session_attached,attached,not attached}' will include the
     string `attached' if the session is attached and the string `not
     attached' if it is unattached, or `#{?automatic-rename,yes,no}' will
     include `yes' if aauuttoommaattiicc--rreennaammee is enabled, or `no' if not.  Condition-
     als can be nested arbitrarily.  Inside a conditional, `,' and `}' must be
     escaped as `#,' and `#}', unless they are part of a `#{...}' replacement.
     For example:

           #{?pane_in_mode,#[fg=white#,bg=red],#[fg=red#,bg=white]}#W .

     Comparisons may be expressed by prefixing two comma-separated alterna-
     tives by `==' or `!=' and a colon.  For example `#{==:#{host},myhost}'
     will be replaced by `1' if running on `myhost', otherwise by `0'.  An `m'
     specifies an fnmatch(3) comparison where the first argument is the pat-
     tern and the second the string to compare, for example
     `#{m:*foo*,#{host}}'.  `||' and `&&' evaluate to true if either or both
     of two comma-separated alternatives are true, for example
     `#{||:#{pane_in_mode},#{alternate_on}}'.  A `C' performs a search for an
     fnmatch(3) pattern in the pane content and evaluates to zero if not
     found, or a line number if found.

     A limit may be placed on the length of the resultant string by prefixing
     it by an `=', a number and a colon.  Positive numbers count from the
     start of the string and negative from the end, so `#{=5:pane_title}' will
     include at most the first 5 characters of the pane title, or
     `#{=-5:pane_title}' the last 5 characters.  Prefixing a time variable
     with `t:' will convert it to a string, so if `#{window_activity}' gives
     `1445765102', `#{t:window_activity}' gives `Sun Oct 25 09:25:02 2015'.
     The `b:' and `d:' prefixes are basename(3) and dirname(3) of the variable
     respectively.  `q:' will escape sh(1) special characters.  `E:' will
     expand the format twice, for example `#{E:status-left}' is the result of
     expanding the content of the ssttaattuuss--lleefftt option rather than the content
     itself.  `T:' is like `E:' but also expands strftime(3) specifiers.
     `S:', `W:' or `P:' will loop over each session, window or pane and insert
     the format once for each.  For windows and panes, two comma-separated
     formats may be given: the second is used for the current window or active
     pane.  For example, to get a list of windows formatted like the status
     line:

           #{W:#{E:window-status-format} ,#{E:window-status-current-format} }

     A prefix of the form `s/foo/bar/:' will substitute `foo' with `bar'
     throughout.

     In addition, the first line of a shell command's output may be inserted
     using `#()'.  For example, `#(uptime)' will insert the system's uptime.
     When constructing formats, ttmmuuxx does not wait for `#()' commands to fin-
     ish; instead, the previous result from running the same command is used,
     or a placeholder if the command has not been run before.  If the command
     hasn't exited, the most recent line of output will be used, but the sta-
     tus line will not be updated more than once a second.  Commands are exe-
     cuted with the ttmmuuxx global environment set (see the _E_N_V_I_R_O_N_M_E_N_T section).

     The following variables are available, where appropriate:

     VVaarriiaabbllee nnaammee          AAlliiaass    RReeppllaacceedd wwiitthh
     alternate_on                    If pane is in alternate screen
     alternate_saved_x               Saved cursor X in alternate screen
     alternate_saved_y               Saved cursor Y in alternate screen
     buffer_created                  Time buffer created
     buffer_name                     Name of buffer
     buffer_sample                   Sample of start of buffer
     buffer_size                     Size of the specified buffer in bytes
     client_activity                 Time client last had activity
     client_created                  Time client created
     client_control_mode             1 if client is in control mode
     client_discarded                Bytes discarded when client behind
     client_height                   Height of client
     client_key_table                Current key table
     client_last_session             Name of the client's last session
     client_name                     Name of client
     client_pid                      PID of client process
     client_prefix                   1 if prefix key has been pressed
     client_readonly                 1 if client is readonly
     client_session                  Name of the client's session
     client_termname                 Terminal name of client
     client_termtype                 Terminal type of client
     client_tty                      Pseudo terminal of client
     client_utf8                     1 if client supports utf8
     client_width                    Width of client
     client_written                  Bytes written to client
     command                         Name of command in use, if any
     command_list_name               Command name if listing commands
     command_list_alias              Command alias if listing commands
     command_list_usage              Command usage if listing commands
     cursor_flag                     Pane cursor flag
     cursor_character                Character at cursor in pane
     cursor_x                        Cursor X position in pane
     cursor_y                        Cursor Y position in pane
     history_bytes                   Number of bytes in window history
     history_limit                   Maximum window history lines
     history_size                    Size of history in lines
     hook                            Name of running hook, if any
     hook_pane                       ID of pane where hook was run, if any
     hook_session                    ID of session where hook was run, if any
     hook_session_name               Name of session where hook was run, if
                                     any
     hook_window                     ID of window where hook was run, if any
     hook_window_name                Name of window where hook was run, if any
     host                   #H       Hostname of local host
     host_short             #h       Hostname of local host (no domain name)
     insert_flag                     Pane insert flag
     keypad_cursor_flag              Pane keypad cursor flag
     keypad_flag                     Pane keypad flag
     line                            Line number in the list
     mouse_any_flag                  Pane mouse any flag
     mouse_button_flag               Pane mouse button flag
     mouse_standard_flag             Pane mouse standard flag
     mouse_all_flag                  Pane mouse all flag
     pane_active                     1 if active pane
     pane_at_bottom                  1 if pane is at the bottom of window
     pane_at_left                    1 if pane is at the left of window
     pane_at_right                   1 if pane is at the right of window
     pane_at_top                     1 if pane is at the top of window
     pane_bottom                     Bottom of pane
     pane_current_command            Current command if available
     pane_current_path               Current path if available
     pane_dead                       1 if pane is dead
     pane_dead_status                Exit status of process in dead pane
     pane_format                     1 if format is for a pane (not assuming
                                     the current)
     pane_height                     Height of pane
     pane_id                #D       Unique pane ID
     pane_in_mode                    If pane is in a mode
     pane_input_off                  If input to pane is disabled
     pane_index             #P       Index of pane
     pane_left                       Left of pane
     pane_mode                       Name of pane mode, if any.
     pane_pid                        PID of first process in pane
     pane_pipe                       1 if pane is being piped
     pane_right                      Right of pane
     pane_search_string              Last search string in copy mode
     pane_start_command              Command pane started with
     pane_synchronized               If pane is synchronized
     pane_tabs                       Pane tab positions
     pane_title             #T       Title of pane
     pane_top                        Top of pane
     pane_tty                        Pseudo terminal of pane
     pane_width                      Width of pane
     pid                             Server PID
     rectangle_toggle                1 if rectangle selection is activated
     scroll_region_lower             Bottom of scroll region in pane
     scroll_region_upper             Top of scroll region in pane
     scroll_position                 Scroll position in copy mode
     selection_present               1 if selection started in copy mode
     session_alerts                  List of window indexes with alerts
     session_attached                Number of clients session is attached to
     session_activity                Time of session last activity
     session_created                 Time session created
     session_format                  1 if format is for a session (not
                                     assuming the current)
     session_last_attached           Time session last attached
     session_group                   Name of session group
     session_group_size              Size of session group
     session_group_list              List of sessions in group
     session_grouped                 1 if session in a group
     session_id                      Unique session ID
     session_many_attached           1 if multiple clients attached
     session_name           #S       Name of session
     session_stack                   Window indexes in most recent order
     session_windows                 Number of windows in session
     socket_path                     Server socket path
     start_time                      Server start time
     version                         Server version
     window_activity                 Time of window last activity
     window_activity_flag            1 if window has activity
     window_active                   1 if window active
     window_bell_flag                1 if window has bell
     window_bigger                   1 if window is larger than client
     window_end_flag                 1 if window has the highest index
     window_flags           #F       Window flags
     window_format                   1 if format is for a window (not assuming
                                     the current)
     window_height                   Height of window
     window_id                       Unique window ID
     window_index           #I       Index of window
     window_last_flag                1 if window is the last used
     window_layout                   Window layout description, ignoring
                                     zoomed window panes
     window_linked                   1 if window is linked across sessions
     window_name            #W       Name of window
     window_offset_x                 X offset into window if larger than
                                     client
     window_offset_y                 Y offset into window if larger than
                                     client
     window_panes                    Number of panes in window
     window_silence_flag             1 if window has silence alert
     window_stack_index              Index in session most recent stack
     window_start_flag               1 if window has the lowest index
     window_visible_layout           Window layout description, respecting
                                     zoomed window panes
     window_width                    Width of window
     window_zoomed_flag              1 if window is zoomed
     wrap_flag                       Pane wrap flag

SSTTYYLLEESS
     ttmmuuxx offers various options to specify the colour and attributes of
     aspects of the interface, for example ssttaattuuss--ssttyyllee for the status line.
     In addition, embedded styles may be specified in format options, such as
     ssttaattuuss--lleefftt--ffoorrmmaatt, by enclosing them in `#[' and `'].

     A style may be the single term `default' to specify the default style
     (which may inherit from another option) or a space or comma separated
     list of the following:

     ffgg==ccoolloouurr
             Set the foreground colour.  The colour is one of: bbllaacckk, rreedd,
             ggrreeeenn, yyeellllooww, bblluuee, mmaaggeennttaa, ccyyaann, wwhhiittee; if supported the
             bright variants bbrriigghhttrreedd, bbrriigghhttggrreeeenn, bbrriigghhttyyeellllooww; ccoolloouurr00 to
             ccoolloouurr225555 from the 256-colour set; ddeeffaauulltt for the default
             colour; tteerrmmiinnaall for the terminal default colour; or a hexadeci-
             mal RGB string such as `#ffffff'.

     bbgg==ccoolloouurr
             Set the background colour.

     nnoonnee    Set no attributes (turn off any active attributes).

     bbrriigghhtt (or bboolldd), ddiimm, uunnddeerrssccoorree, bblliinnkk, rreevveerrssee, hhiiddddeenn, iittaalliiccss,
             ssttrriikkeetthhrroouugghh, ddoouubbllee--uunnddeerrssccoorree, ccuurrllyy--uunnddeerrssccoorree,
             ddootttteedd--uunnddeerrssccoorree, ddaasshheedd--uunnddeerrssccoorree
             Set an attribute.  Any of the attributes may be prefixed with
             `no' to unset.

     aalliiggnn==lleefftt (or nnooaalliiggnn), aalliiggnn==cceennttrree, aalliiggnn==rriigghhtt
             Align text to the left, centre or right of the available space if
             appropriate.

     lliisstt==oonn, lliisstt==ffooccuuss, lliisstt==lleefftt--mmaarrkkeerr, lliisstt==rriigghhtt==mmaarrkkeerr, nnoolliisstt
             Mark the position of the various window list components in the
             ssttaattuuss--ffoorrmmaatt option: lliisstt==oonn marks the start of the list;
             lliisstt==ffooccuuss is the part of the list that should be kept in focus
             if the entire list won't fit in the available space (typically
             the current window); lliisstt==lleefftt--mmaarrkkeerr and lliisstt==rriigghhtt--mmaarrkkeerr mark
             the text to be used to mark that text has been trimmed from the
             left or right of the list if there is not enough space.

     rraannggee==lleefftt, rraannggee==rriigghhtt, rraannggee==wwiinnddooww||XX, nnoorraannggee
             Mark a range in the ssttaattuuss--ffoorrmmaatt option.  rraannggee==lleefftt and
             rraannggee==rriigghhtt are the text used for the `StatusLeft' and
             `StatusRight' mouse keys.  rraannggee==wwiinnddooww||XX is the range for a win-
             dow passed to the `Status' mouse key, where `X' is a window
             index.

     Examples are:

           fg=yellow bold underscore blink
           bg=black,fg=default,noreverse

NNAAMMEESS AANNDD TTIITTLLEESS
     ttmmuuxx distinguishes between names and titles.  Windows and sessions have
     names, which may be used to specify them in targets and are displayed in
     the status line and various lists: the name is the ttmmuuxx identifier for a
     window or session.  Only panes have titles.  A pane's title is typically
     set by the program running inside the pane using an escape sequence (like
     it would set the xterm(1) window title in X(7)).  Windows themselves do
     not have titles - a window's title is the title of its active pane.  ttmmuuxx
     itself may set the title of the terminal in which the client is running,
     see the sseett--ttiittlleess option.

     A session's name is set with the nneeww--sseessssiioonn and rreennaammee--sseessssiioonn commands.
     A window's name is set with one of:

     1.      A command argument (such as --nn for nneeww--wwiinnddooww or nneeww--sseessssiioonn).

     2.      An escape sequence (if the aallllooww--rreennaammee option is turned on):

                   $ printf '\033kWINDOW_NAME\033\\'

     3.      Automatic renaming, which sets the name to the active command in
             the window's active pane.  See the aauuttoommaattiicc--rreennaammee option.

     When a pane is first created, its title is the hostname.  A pane's title
     can be set via the title setting escape sequence, for example:

           $ printf '\033]2;My Title\033\\'

     It can also be modified with the sseelleecctt--ppaannee --TT command.

EENNVVIIRROONNMMEENNTT
     When the server is started, ttmmuuxx copies the environment into the _g_l_o_b_a_l
     _e_n_v_i_r_o_n_m_e_n_t; in addition, each session has a _s_e_s_s_i_o_n _e_n_v_i_r_o_n_m_e_n_t.  When a
     window is created, the session and global environments are merged.  If a
     variable exists in both, the value from the session environment is used.
     The result is the initial environment passed to the new process.

     The uuppddaattee--eennvviirroonnmmeenntt session option may be used to update the session
     environment from the client when a new session is created or an old reat-
     tached.  ttmmuuxx also initialises the TMUX variable with some internal
     information to allow commands to be executed from inside, and the TERM
     variable with the correct terminal setting of `screen'.

     Commands to alter and view the environment are:

     sseett--eennvviirroonnmmeenntt [--ggrruu] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n] _n_a_m_e [_v_a_l_u_e]
                   (alias: sseetteennvv)
             Set or unset an environment variable.  If --gg is used, the change
             is made in the global environment; otherwise, it is applied to
             the session environment for _t_a_r_g_e_t_-_s_e_s_s_i_o_n.  The --uu flag unsets a
             variable.  --rr indicates the variable is to be removed from the
             environment before starting a new process.

     sshhooww--eennvviirroonnmmeenntt [--ggss] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n] [_v_a_r_i_a_b_l_e]
                   (alias: sshhoowweennvv)
             Display the environment for _t_a_r_g_e_t_-_s_e_s_s_i_o_n or the global environ-
             ment with --gg.  If _v_a_r_i_a_b_l_e is omitted, all variables are shown.
             Variables removed from the environment are prefixed with `-'.  If
             --ss is used, the output is formatted as a set of Bourne shell com-
             mands.

SSTTAATTUUSS LLIINNEE
     ttmmuuxx includes an optional status line which is displayed in the bottom
     line of each terminal.

     By default, the status line is enabled and one line in height (it may be
     disabled or made multiple lines with the ssttaattuuss session option) and con-
     tains, from left-to-right: the name of the current session in square
     brackets; the window list; the title of the active pane in double quotes;
     and the time and date.

     Each line of the status line is configured with the ssttaattuuss--ffoorrmmaatt option.
     The default is made of three parts: configurable left and right sections
     (which may contain dynamic content such as the time or output from a
     shell command, see the ssttaattuuss--lleefftt, ssttaattuuss--lleefftt--lleennggtthh, ssttaattuuss--rriigghhtt, and
     ssttaattuuss--rriigghhtt--lleennggtthh options below), and a central window list.  By
     default, the window list shows the index, name and (if any) flag of the
     windows present in the current session in ascending numerical order.  It
     may be customised with the _w_i_n_d_o_w_-_s_t_a_t_u_s_-_f_o_r_m_a_t and
     _w_i_n_d_o_w_-_s_t_a_t_u_s_-_c_u_r_r_e_n_t_-_f_o_r_m_a_t options.  The flag is one of the following
     symbols appended to the window name:

           SSyymmbbooll    MMeeaanniinngg
           *         Denotes the current window.
           -         Marks the last window (previously selected).
           #         Window activity is monitored and activity has been
                                detected.
           !         Window bells are monitored and a bell has occurred in the
                                window.
           ~         The window has been silent for the monitor-silence
                                interval.
           M         The window contains the marked pane.
           Z         The window's active pane is zoomed.

     The # symbol relates to the mmoonniittoorr--aaccttiivviittyy window option.  The window
     name is printed in inverted colours if an alert (bell, activity or
     silence) is present.

     The colour and attributes of the status line may be configured, the
     entire status line using the ssttaattuuss--ssttyyllee session option and individual
     windows using the wwiinnddooww--ssttaattuuss--ssttyyllee window option.

     The status line is automatically refreshed at interval if it has changed,
     the interval may be controlled with the ssttaattuuss--iinntteerrvvaall session option.

     Commands related to the status line are as follows:

     ccoommmmaanndd--pprroommpptt [--11ii] [--II _i_n_p_u_t_s] [--pp _p_r_o_m_p_t_s] [--tt _t_a_r_g_e_t_-_c_l_i_e_n_t]
             [_t_e_m_p_l_a_t_e]
             Open the command prompt in a client.  This may be used from
             inside ttmmuuxx to execute commands interactively.

             If _t_e_m_p_l_a_t_e is specified, it is used as the command.  If present,
             --II is a comma-separated list of the initial text for each prompt.
             If --pp is given, _p_r_o_m_p_t_s is a comma-separated list of prompts
             which are displayed in order; otherwise a single prompt is dis-
             played, constructed from _t_e_m_p_l_a_t_e if it is present, or `:' if
             not.

             Before the command is executed, the first occurrence of the
             string `%%' and all occurrences of `%1' are replaced by the
             response to the first prompt, all `%2' are replaced with the
             response to the second prompt, and so on for further prompts.  Up
             to nine prompt responses may be replaced (`%1' to `%9').  `%%%'
             is like `%%' but any quotation marks are escaped.

             --11 makes the prompt only accept one key press, in this case the
             resulting input is a single character.  --ii executes the command
             every time the prompt input changes instead of when the user
             exits the command prompt.

             The following keys have a special meaning in the command prompt,
             depending on the value of the ssttaattuuss--kkeeyyss option:

                   FFuunnccttiioonn                             vvii        eemmaaccss
                   Cancel command prompt                Escape    Escape
                   Delete current word                            C-w
                   Delete entire command                d         C-u
                   Delete from cursor to end            D         C-k
                   Execute command                      Enter     Enter
                   Get next command from history                  Down
                   Get previous command from history              Up
                   Insert top paste buffer              p         C-y
                   Look for completions                 Tab       Tab
                   Move cursor left                     h         Left
                   Move cursor right                    l         Right
                   Move cursor to end                   $         C-e
                   Move cursor to next word             w         M-f
                   Move cursor to previous word         b         M-b
                   Move cursor to start                 0         C-a
                   Transpose characters                           C-t

     ccoonnffiirrmm--bbeeffoorree [--pp _p_r_o_m_p_t] [--tt _t_a_r_g_e_t_-_c_l_i_e_n_t] _c_o_m_m_a_n_d
                   (alias: ccoonnffiirrmm)
             Ask for confirmation before executing _c_o_m_m_a_n_d.  If --pp is given,
             _p_r_o_m_p_t is the prompt to display; otherwise a prompt is con-
             structed from _c_o_m_m_a_n_d.  It may contain the special character
             sequences supported by the ssttaattuuss--lleefftt option.

             This command works only from inside ttmmuuxx.

     ddiissppllaayy--mmeessssaaggee [--aappvv] [--cc _t_a_r_g_e_t_-_c_l_i_e_n_t] [--tt _t_a_r_g_e_t_-_p_a_n_e] [_m_e_s_s_a_g_e]
                   (alias: ddiissppllaayy)
             Display a message.  If --pp is given, the output is printed to std-
             out, otherwise it is displayed in the _t_a_r_g_e_t_-_c_l_i_e_n_t status line.
             The format of _m_e_s_s_a_g_e is described in the _F_O_R_M_A_T_S section; infor-
             mation is taken from _t_a_r_g_e_t_-_p_a_n_e if --tt is given, otherwise the
             active pane for the session attached to _t_a_r_g_e_t_-_c_l_i_e_n_t.

             --vv prints verbose logging as the format is parsed and --aa lists
             the format variables and their values.

BBUUFFFFEERRSS
     ttmmuuxx maintains a set of named _p_a_s_t_e _b_u_f_f_e_r_s.  Each buffer may be either
     explicitly or automatically named.  Explicitly named buffers are named
     when created with the sseett--bbuuffffeerr or llooaadd--bbuuffffeerr commands, or by renaming
     an automatically named buffer with sseett--bbuuffffeerr --nn.  Automatically named
     buffers are given a name such as `buffer0001', `buffer0002' and so on.
     When the bbuuffffeerr--lliimmiitt option is reached, the oldest automatically named
     buffer is deleted.  Explicitly named buffers are not subject to
     bbuuffffeerr--lliimmiitt and may be deleted with ddeelleettee--bbuuffffeerr command.

     Buffers may be added using ccooppyy--mmooddee or the sseett--bbuuffffeerr and llooaadd--bbuuffffeerr
     commands, and pasted into a window using the ppaassttee--bbuuffffeerr command.  If a
     buffer command is used and no buffer is specified, the most recently
     added automatically named buffer is assumed.

     A configurable history buffer is also maintained for each window.  By
     default, up to 2000 lines are kept; this can be altered with the
     hhiissttoorryy--lliimmiitt option (see the sseett--ooppttiioonn command above).

     The buffer commands are as follows:

     cchhoooossee--bbuuffffeerr [--NNZZ] [--FF _f_o_r_m_a_t] [--ff _f_i_l_t_e_r] [--OO _s_o_r_t_-_o_r_d_e_r] [--tt
             _t_a_r_g_e_t_-_p_a_n_e] [_t_e_m_p_l_a_t_e]
             Put a pane into buffer mode, where a buffer may be chosen inter-
             actively from a list.  --ZZ zooms the pane.  The following keys may
             be used in buffer mode:

                   KKeeyy    FFuunnccttiioonn
                   Enter  Paste selected buffer
                   Up     Select previous buffer
                   Down   Select next buffer
                   C-s    Search by name or content
                   n      Repeat last search
                   t      Toggle if buffer is tagged
                   T      Tag no buffers
                   C-t    Tag all buffers
                   p      Paste selected buffer
                   P      Paste tagged buffers
                   d      Delete selected buffer
                   D      Delete tagged buffers
                   f      Enter a format to filter items
                   O      Change sort order
                   v      Toggle preview
                   q      Exit mode

             After a buffer is chosen, `%%' is replaced by the buffer name in
             _t_e_m_p_l_a_t_e and the result executed as a command.  If _t_e_m_p_l_a_t_e is
             not given, "paste-buffer -b '%%'" is used.

             --OO specifies the initial sort order: one of `time', `name' or
             `size'.  --ff specifies an initial filter: the filter is a format -
             if it evaluates to zero, the item in the list is not shown, oth-
             erwise it is shown.  If a filter would lead to an empty list, it
             is ignored.  --FF specifies the format for each item in the list.
             --NN starts without the preview.  This command works only if at
             least one client is attached.

     cclleeaarr--hhiissttoorryy [--tt _t_a_r_g_e_t_-_p_a_n_e]
                   (alias: cclleeaarrhhiisstt)
             Remove and free the history for the specified pane.

     ddeelleettee--bbuuffffeerr [--bb _b_u_f_f_e_r_-_n_a_m_e]
                   (alias: ddeelleetteebb)
             Delete the buffer named _b_u_f_f_e_r_-_n_a_m_e, or the most recently added
             automatically named buffer if not specified.

     lliisstt--bbuuffffeerrss [--FF _f_o_r_m_a_t]
                   (alias: llssbb)
             List the global buffers.  For the meaning of the --FF flag, see the
             _F_O_R_M_A_T_S section.

     llooaadd--bbuuffffeerr [--bb _b_u_f_f_e_r_-_n_a_m_e] _p_a_t_h
                   (alias: llooaaddbb)
             Load the contents of the specified paste buffer from _p_a_t_h.

     ppaassttee--bbuuffffeerr [--ddpprr] [--bb _b_u_f_f_e_r_-_n_a_m_e] [--ss _s_e_p_a_r_a_t_o_r] [--tt _t_a_r_g_e_t_-_p_a_n_e]
                   (alias: ppaasstteebb)
             Insert the contents of a paste buffer into the specified pane.
             If not specified, paste into the current one.  With --dd, also
             delete the paste buffer.  When output, any linefeed (LF) charac-
             ters in the paste buffer are replaced with a separator, by
             default carriage return (CR).  A custom separator may be speci-
             fied using the --ss flag.  The --rr flag means to do no replacement
             (equivalent to a separator of LF).  If --pp is specified, paste
             bracket control codes are inserted around the buffer if the
             application has requested bracketed paste mode.

     ssaavvee--bbuuffffeerr [--aa] [--bb _b_u_f_f_e_r_-_n_a_m_e] _p_a_t_h
                   (alias: ssaavveebb)
             Save the contents of the specified paste buffer to _p_a_t_h.  The --aa
             option appends to rather than overwriting the file.

     sseett--bbuuffffeerr [--aa] [--bb _b_u_f_f_e_r_-_n_a_m_e] [--nn _n_e_w_-_b_u_f_f_e_r_-_n_a_m_e] _d_a_t_a
                   (alias: sseettbb)
             Set the contents of the specified buffer to _d_a_t_a.  The --aa option
             appends to rather than overwriting the buffer.  The --nn option
             renames the buffer to _n_e_w_-_b_u_f_f_e_r_-_n_a_m_e.

     sshhooww--bbuuffffeerr [--bb _b_u_f_f_e_r_-_n_a_m_e]
                   (alias: sshhoowwbb)
             Display the contents of the specified buffer.

MMIISSCCEELLLLAANNEEOOUUSS
     Miscellaneous commands are as follows:

     cclloocckk--mmooddee [--tt _t_a_r_g_e_t_-_p_a_n_e]
             Display a large clock.

     iiff--sshheellll [--bbFF] [--tt _t_a_r_g_e_t_-_p_a_n_e] _s_h_e_l_l_-_c_o_m_m_a_n_d _c_o_m_m_a_n_d [_c_o_m_m_a_n_d]
                   (alias: iiff)
             Execute the first _c_o_m_m_a_n_d if _s_h_e_l_l_-_c_o_m_m_a_n_d returns success or the
             second _c_o_m_m_a_n_d otherwise.  Before being executed, _s_h_e_l_l_-_c_o_m_m_a_n_d
             is expanded using the rules specified in the _F_O_R_M_A_T_S section,
             including those relevant to _t_a_r_g_e_t_-_p_a_n_e.  With --bb, _s_h_e_l_l_-_c_o_m_m_a_n_d
             is run in the background.

             If --FF is given, _s_h_e_l_l_-_c_o_m_m_a_n_d is not executed but considered suc-
             cess if neither empty nor zero (after formats are expanded).

     lloocckk--sseerrvveerr
                   (alias: lloocckk)
             Lock each client individually by running the command specified by
             the lloocckk--ccoommmmaanndd option.

     rruunn--sshheellll [--bb] [--tt _t_a_r_g_e_t_-_p_a_n_e] _s_h_e_l_l_-_c_o_m_m_a_n_d
                   (alias: rruunn)
             Execute _s_h_e_l_l_-_c_o_m_m_a_n_d in the background without creating a win-
             dow.  Before being executed, shell-command is expanded using the
             rules specified in the _F_O_R_M_A_T_S section.  With --bb, the command is
             run in the background.  After it finishes, any output to stdout
             is displayed in copy mode (in the pane specified by --tt or the
             current pane if omitted).  If the command doesn't return success,
             the exit status is also displayed.

     wwaaiitt--ffoorr [--LL | --SS | --UU] _c_h_a_n_n_e_l
                   (alias: wwaaiitt)
             When used without options, prevents the client from exiting until
             woken using wwaaiitt--ffoorr --SS with the same channel.  When --LL is used,
             the channel is locked and any clients that try to lock the same
             channel are made to wait until the channel is unlocked with
             wwaaiitt--ffoorr --UU.

TTEERRMMIINNFFOO EEXXTTEENNSSIIOONNSS
     ttmmuuxx understands some unofficial extensions to terminfo(5):

     _C_s, _C_r  Set the cursor colour.  The first takes a single string argument
             and is used to set the colour; the second takes no arguments and
             restores the default cursor colour.  If set, a sequence such as
             this may be used to change the cursor colour from inside ttmmuuxx:

                   $ printf '\033]12;red\033\\'

     _S_m_u_l_x   Set a styled underline.  The single parameter is one of: 0 for no
             underline, 1 for normal underline, 2 for double underline, 3 for
             curly underline, 4 for dotted underline and 5 for dashed under-
             line.

     _S_s, _S_e  Set or reset the cursor style.  If set, a sequence such as this
             may be used to change the cursor to an underline:

                   $ printf '\033[4 q'

             If _S_e is not set, Ss with argument 0 will be used to reset the
             cursor style instead.

     _T_c      Indicate that the terminal supports the `direct colour' RGB
             escape sequence (for example, \e[38;2;255;255;255m).

             If supported, this is used for the initialize colour escape
             sequence (which may be enabled by adding the `initc' and `ccc'
             capabilities to the ttmmuuxx terminfo(5) entry).

     _M_s      Store the current buffer in the host terminal's selection (clip-
             board).  See the _s_e_t_-_c_l_i_p_b_o_a_r_d option above and the xterm(1) man
             page.

CCOONNTTRROOLL MMOODDEE
     ttmmuuxx offers a textual interface called _c_o_n_t_r_o_l _m_o_d_e.  This allows appli-
     cations to communicate with ttmmuuxx using a simple text-only protocol.

     In control mode, a client sends ttmmuuxx commands or command sequences termi-
     nated by newlines on standard input.  Each command will produce one block
     of output on standard output.  An output block consists of a _%_b_e_g_i_n line
     followed by the output (which may be empty).  The output block ends with
     a _%_e_n_d or _%_e_r_r_o_r.  _%_b_e_g_i_n and matching _%_e_n_d or _%_e_r_r_o_r have two arguments:
     an integer time (as seconds from epoch) and command number.  For example:

           %begin 1363006971 2
           0: ksh* (1 panes) [80x24] [layout b25f,80x24,0,0,2] @2 (active)
           %end 1363006971 2

     The rreeffrreesshh--cclliieenntt --CC command may be used to set the size of a client in
     control mode.

     In control mode, ttmmuuxx outputs notifications.  A notification will never
     occur inside an output block.

     The following notifications are defined:

     %%cclliieenntt--sseessssiioonn--cchhaannggeedd _c_l_i_e_n_t _s_e_s_s_i_o_n_-_i_d _n_a_m_e
             The client is now attached to the session with ID _s_e_s_s_i_o_n_-_i_d,
             which is named _n_a_m_e.

     %%eexxiitt [_r_e_a_s_o_n]
             The ttmmuuxx client is exiting immediately, either because it is not
             attached to any session or an error occurred.  If present, _r_e_a_s_o_n
             describes why the client exited.

     %%llaayyoouutt--cchhaannggee _w_i_n_d_o_w_-_i_d _w_i_n_d_o_w_-_l_a_y_o_u_t _w_i_n_d_o_w_-_v_i_s_i_b_l_e_-_l_a_y_o_u_t _w_i_n_d_o_w_-_f_l_a_g_s
             The layout of a window with ID _w_i_n_d_o_w_-_i_d changed.  The new layout
             is _w_i_n_d_o_w_-_l_a_y_o_u_t.  The window's visible layout is
             _w_i_n_d_o_w_-_v_i_s_i_b_l_e_-_l_a_y_o_u_t and the window flags are _w_i_n_d_o_w_-_f_l_a_g_s.

     %%oouuttppuutt _p_a_n_e_-_i_d _v_a_l_u_e
             A window pane produced output.  _v_a_l_u_e escapes non-printable char-
             acters and backslash as octal \xxx.

     %%ppaannee--mmooddee--cchhaannggeedd _p_a_n_e_-_i_d
             The pane with ID _p_a_n_e_-_i_d has changed mode.

     %%sseessssiioonn--cchhaannggeedd _s_e_s_s_i_o_n_-_i_d _n_a_m_e
             The client is now attached to the session with ID _s_e_s_s_i_o_n_-_i_d,
             which is named _n_a_m_e.

     %%sseessssiioonn--rreennaammeedd _n_a_m_e
             The current session was renamed to _n_a_m_e.

     %%sseessssiioonn--wwiinnddooww--cchhaannggeedd _s_e_s_s_i_o_n_-_i_d _w_i_n_d_o_w_-_i_d
             The session with ID _s_e_s_s_i_o_n_-_i_d changed its active window to the
             window with ID _w_i_n_d_o_w_-_i_d.

     %%sseessssiioonnss--cchhaannggeedd
             A session was created or destroyed.

     %%uunnlliinnkkeedd--wwiinnddooww--aadddd _w_i_n_d_o_w_-_i_d
             The window with ID _w_i_n_d_o_w_-_i_d was created but is not linked to the
             current session.

     %%wwiinnddooww--aadddd _w_i_n_d_o_w_-_i_d
             The window with ID _w_i_n_d_o_w_-_i_d was linked to the current session.

     %%wwiinnddooww--cclloossee _w_i_n_d_o_w_-_i_d
             The window with ID _w_i_n_d_o_w_-_i_d closed.

     %%wwiinnddooww--ppaannee--cchhaannggeedd _w_i_n_d_o_w_-_i_d _p_a_n_e_-_i_d
             The active pane in the window with ID _w_i_n_d_o_w_-_i_d changed to the
             pane with ID _p_a_n_e_-_i_d.

     %%wwiinnddooww--rreennaammeedd _w_i_n_d_o_w_-_i_d _n_a_m_e
             The window with ID _w_i_n_d_o_w_-_i_d was renamed to _n_a_m_e.

FFIILLEESS
     ~/.tmux.conf                 Default ttmmuuxx configuration file.
     /usr/local/etc/tmux.conf     System-wide configuration file.

EEXXAAMMPPLLEESS
     To create a new ttmmuuxx session running vi(1):

           $ tmux new-session vi

     Most commands have a shorter form, known as an alias.  For new-session,
     this is nneeww:

           $ tmux new vi

     Alternatively, the shortest unambiguous form of a command is accepted.
     If there are several options, they are listed:

           $ tmux n
           ambiguous command: n, could be: new-session, new-window, next-window

     Within an active session, a new window may be created by typing `C-b c'
     (Ctrl followed by the `b' key followed by the `c' key).

     Windows may be navigated with: `C-b 0' (to select window 0), `C-b 1' (to
     select window 1), and so on; `C-b n' to select the next window; and `C-b
     p' to select the previous window.

     A session may be detached using `C-b d' (or by an external event such as
     ssh(1) disconnection) and reattached with:

           $ tmux attach-session

     Typing `C-b ?' lists the current key bindings in the current window; up
     and down may be used to navigate the list or `q' to exit from it.

     Commands to be run when the ttmmuuxx server is started may be placed in the
     _~_/_._t_m_u_x_._c_o_n_f configuration file.  Common examples include:

     Changing the default prefix key:

           set-option -g prefix C-a
           unbind-key C-b
           bind-key C-a send-prefix

     Turning the status line off, or changing its colour:

           set-option -g status off
           set-option -g status-style bg=blue

     Setting other options, such as the default command, or locking after 30
     minutes of inactivity:

           set-option -g default-command "exec /bin/ksh"
           set-option -g lock-after-time 1800

     Creating new key bindings:

           bind-key b set-option status
           bind-key / command-prompt "split-window 'exec man %%'"
           bind-key S command-prompt "new-window -n %1 'ssh %1'"

SSEEEE AALLSSOO
     pty(4)

AAUUTTHHOORRSS
     Nicholas Marriott <_n_i_c_h_o_l_a_s_._m_a_r_r_i_o_t_t_@_g_m_a_i_l_._c_o_m>

BSD                              June 23, 2019                             BSD
