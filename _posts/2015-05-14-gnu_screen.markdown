---
title: GNU Screen
date: 2015-05-14 02:23:17
layout: post 
---

I have recently found myself hanging out in the terminal window a lot more. As a result, I find myself wanting to hang out in two terminal windows at the same time. Much in the same way that you may want many browser windows, each with N tabs. Screen allows you to create multiple sessions (which are 'like' browser windows) and populate each session with as many windows (which are 'like' tabs). As a bonus, screen allows you to 'detach' sessions (similar to minimizing a window, but more persistent) which in turn can be 're-attached' later in order to resume whatever processes were running in the screen when it was detached. This is pretty supreme, especially if you're ssh-ing all over the place, doing important scp's, etc. etc.

This post is also here because I keep forgetting these commands and writing about them may help them stick.

[For those uninterested in the 'walk-through' style, click here to proceed to the condensed list of essential shortcuts.](#tips)

#### The wonderful world of Screen

##### Installation

The first important thing about screen is installing it. If you're on linux, then you'll have some easy set-up composed of something to the tune of...

`sudo apt-get install screen`

but maybe you're like me and you prefer to type the string (as a warm-up) and then sudo, followed by the same string. If you're on a mac, screen is already there, good job apple. If you're on a windows, well, get Cygwin... right now. You may be forced onto a windows computer for work, for economic reasons, for honor, for glory, for shizzle, but that doesn't mean you can't have a wonderful linux-y terminal when you want, where you want... get Cygwin and make sure to include screen during installation.

##### Opening Screen

The first I like to think about with screen is where I am relative to "it". So you start out in the "display terminal", this refers to your own terminal window, PowerShell, Git Bash, Putty, etc. Quick procedural note: if you're on a windows and you still aren't on Cygwin then stop reading this post and go get it, seriously. Anywho, so screen, likes to be addressed by name when you aren't in it, but want to use it. A good place to start is with, well,

`$ screen -ls`

...it does exactly what you'd think, it lists the current "sessions" you have, right now, this is 0, and screen will say something like "No Sockets found in...", what are sockets? Well, it's a dumb word, and not really lingo the "screen" community uses. As mentioned in the beginning, screen works well with a browser metaphor. To open up a new 'browser window' in screen AKA a new session, you type

`$ screen // make sure to rename session with C-a :sessionName newSessionName`  
`OR`  
`$ screen -S myRadSession`

The first option is inferior. Simply typing screen opens up a new session. The second option is better, it also opens up a new session but it has a name, forcing yourself to name a session makes you think about why you need it. If you are using your internet browser perhaps you want one browser window that has a lot of tabs related to your finances, you might name that browser window 'money', similarly, another browser window might have youtube, facebook, and wikipedia open, this window would be called 'leisure'. In screen it's the same, give your session a name so you know what sorts of windows you are going to be using in it, it is also important if you detach... but more on that later. Now, you have successfully started a session, you are in what is called a "virtual terminal". It's called a virtual terminal because it is a terminal emulated within a terminal, it is EXACTLY like any terminal UNLESS you hit ctrl+a. Ctrl-a is a little too obvious so in the biz we use 'C-' to mean Ctrl or '^C', I'm going to use 'C-' because if you get up the courage to type 'man screen', thus revealing screen's manual, you'll see a lot of 'C-'.

##### Navigation

Why 'C-a' you ask? Well, 'C-a' is screen's escape sequence. An escape sequence tells screen, 'Hey, come out of the shadows to do something for me.' So, in a session it might be useful to hit  

`C-a + w`  

you'll see a string appear in your window, either on the bottom or at the top that says '0*$ bash', congrats, you're in a window in a session and it's name is 0*$ bash. If a session is like a browser window, then a window is like browser's tab. This means you have a session going, and it's got one 'tab' called a window. Making new windows is easy  

`C-a + c`  

this key combination will take you to the new window in the session, if you hit 'C-a' + 'w' again, you'll see you now have two windows open '0*$ bash' and '1*$ bash'

So, by hitting 'C-a' you tell screen listen for shortcut keys. So, 'C-a' is indicating you want to use a shortcut key combination and 'c' is one such shortcut, it creates a new window in the session. Now, you need to be able to navigate through the windows in your session.

`C-a C-space`

// next window in session 

`C-a + p`

// previous window in session 

What if you have too many windows and you want to destroy one?

`C-a + k`

//hit 'y' to confirm the kill

What if you want to name each window in the session?   

`C-a + A`  

// input name then hit enter

##### Advanced Moves

###### ...These are just from `man screen`, but they are commands I tend to remember.

*   `C-a F //(fit)`  
     Resize the window to the current region size.
*   `C-a C-l //(redisplay)`  
     Fully refresh the current window.
*   `C-a h //(hardcopy)`  
     Write a hardcopy of the current window to the file “hardcopy.n”..
*   `C-a H //(log)`  
     Toggle logging of the current window to the file “screenlog.n”.
*   `C-a [ OR C-a C-[ OR C-a <esc>//(copy)</esc>`  
     Enter copy/scrollback mode.
*   `C-a ] OR C-a C-] // (paste)`  
     Write the contents of the paste buffer to the stdin queue of the current window.

##### Administrative

Now, there are a few things left to walk about, namely my favorite feature of screen. Screen allows you to continue a process, even if you exit out of terminal. To use this feature, you simply 'detach' whichever session has the window with the process you want to use. To detach you hit:

`C-a + C-d`  

after this you are back to your main terminal window, from here you can create a new session, which we already want over, or you can connect to a currently running session. As mentioned before type `screen -ls` to list all of the sessions, and from here you use:

`screen -r baz`

// to connect to detached session 

`screen -rx baz`

// to connect to attached session 

Lastly, if you want to destroy a session, simply open it `screen -r #name#` and use `C-a + k` on each window in the terminal to make sure there is nothing important there. Alternatively you can just use `pkill screen`

Thank You.

##### Essential Screen Shortcut Keys

Here's a great link I often refer to sometimes:  
 [Advanced GNU screen quick reference ...](http://aperiodic.net/screen/quick_reference)

    /**
    *Commands to use outside of screen
    */
    screen -ls          // list sessions
    screen              // new session, no name
    screen -S bar       // new session w/ name
    screen -r baz       // connect to detached session
    screen -rx baz      // connect to attached
                           session

    /**
    *Commands to use in screen
    */
    C-a + c             // new window... within a session
    C-a + space         // next window in session
    C-a + p             // previous window within socket
    C-a + k             // kill one window within a socket
    C-a + A	            // name current window
    C-a + C-d	    // detach session, keeps all windows
                           within session running
    C-a + C-a           // go to previous window
    C-a + C-w           // lists names of all windows in current
                           session

    /**
    *How do I kill this whole session thing?
    */
    C-a + k             // recommended: kill all windows
                           in session & it closes
    pkill screen        // I mean... you could do this
