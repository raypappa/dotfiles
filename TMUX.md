# Tmux Cheat Sheet

## Sessions

### New Session

* `tmux new [-s name] [cmd]` (`:new`) - new session
### Switch Session

* `tmux ls` (`:ls`) - list sessions
* `tmux switch [-t name]` (`:switch`) - switches to an existing session
* `tmux as [id] [-t name]` (`:attach`) - attaches to an existing session
* `<C-a>c` (`:detach`) - detach the currently attached session

### Session Management

* `<C-a>s` - list sessions
* `<C-a>$` - name session

### Close Session

* `tmux kill-session [-t name]` (`:kill-session`)

## Windows

### New Window

* `<C-a>c` (`:neww [-n name] [cmd]`) - new window
### Cursor Movement

* `<C-a>[i]` (`:selectw -t [i]`) - go to window `[i]`
* `<C-a>l` - go to last window
* `<C-a>p` - go to previous window
* `<C-a>n` - go to next window

### Window Management

* `<C-a>T` - rename window
* `<C-a>,` - rename window
* `<C-a>w` - list all windows
* `<C-a>f` - find window by name
* `<C-a>.` - move window to another session (promt)
* `:movew` - move window to next unused number

### Close Window

* `<C-a>&` (`:kill-window`) - kill window

## Panes

### New Pane

* (%) `<C-a>|` (`:splitw [-v] [-p width] [-t focus] [cmd]`) - split current pane vertically
* (") `<C-a>s` (`:splitw -h [-p width] [-t focus] [cmd]`) - split current pane horizontally

### Cursor Movement
* `<C><k>` (`:selectp -U`) - move cursor to the pane above
* `<C><j>` (`:selectp -D`) - move cursor to the pane below
* `<C><h>` (`:selectp -L`) - move cursor to the pane to the left
* `<C><l>` (`:selectp -R`) - move cursor to the pane to the right

### Close Pane

* `<C-a>x` (`:kill-pane`) - kill current pane

## Sources

* http://robots.thoughtbot.com/post/2641409235/a-tmux-crash-course
* https://wiki.archlinux.org/index.php/Tmux
* https://gist.github.com/henrik/1967800
* http://blog.hawkhost.com/2010/06/28/tmux-the-terminal-multiplexer/
* https://gist.github.com/Starefossen/5955406
