# hop
Hop to various bookmarks in the filesystem in a BASH shell

# Installation
To install hop on your system, do the following:
* Copy hop.sh to your filesystem (git clone is fine)
* Add the following line to your $HOME/.bashrc
    source ~/path/to/hop.sh
* Either reboot or re-source $HOME/.bashrc on all your shells
    source ~/.bashrc

# Usage
A new command (shell function) named hop will be available allowing
you to jump around the filesystem to bookmarked locations

    $ hop -h
    USAGE: hop [OPTION] [TARGET]
    Changes directory to a given target

    Options:
    -s TARGET   Save the current directory as TARGET
    -d TARGET   Delete a given TARGET
    -l          List available targets
    -h          Show help

To create a bookmark/target, cd to the destination directory and run
hop -s TARGET to save that directory as the name TARGET.

Example usage:

    user@host:~$ cd ~/workspace/github
    user@host:~/workspace/github$ hop -s github
    user@host:~/workspace/github$ hop -l
    github /home/user/workspace/github
    user@host:~/workspace/github$ cd ~/
    user@host:~$ hop github
    user@host:~/workspace/github$ pwd
    /home/user/workspace/github
    user@host:~/workspace/github$ 
