#!/usr/bin/env python3

from subprocess import run
from os import listdir, path
from typing import List
from sys import stdout, stderr, exit


def safety_check():
    """ warn user to avoid the loss of existing dot files """
    print(f"Warning: Running this script will overwrite all existing configuration files!", file=stderr)
    if input("Type yes to continue: ") != "yes":
        print("Aborted Process", file=stderr)
        exit()


def prepend_dot(file: str) -> str:
        """ Prepends a dot to filenames """
        if file.startswith("."):
            return file
        else:
            return f".{file}"


def main():

    safety_check()
    
    print(f"Starting to create Symbolic Links...\n---")

    HOME_DIR = path.expanduser("~")
    REPO = "dotfiles"
    CONFIG_DIR = "dotfile-directory"
    CONFIGFILES: List[str] = listdir(CONFIG_DIR)

    

    for file in CONFIGFILES:

        command = [
            "ln",
            "-s",
            "-F",
            "-f",
            path.join(HOME_DIR, REPO, CONFIG_DIR, file),
            path.join(HOME_DIR, prepend_dot(file)),
        ]

        print(f"Linking configuration file <{file}> with:")

        for token in command:
            print(token, end=" ")
        print()

        result = run(
            command,
            capture_output=True,
            text=True
        )

        print(result.stdout, file=stdout)
        print(result.stderr, file=stderr)



if __name__ == "__main__":
    main()

    
