#!/usr/bin/env python3

from subprocess import run
from os import listdir, path
from typing import List
from sys import stdout, stderr, exit

def main():

    def safetyCheck():
        print(f"Warning: Running this script will overwrite all existing configuration files!", file=stderr)
        return input("Type yes to continue: ")


    if safetyCheck() != "yes":
        print("Aborted Process", file=stderr)
        exit()

    
    print(f"Starting to create Symbolic Links...\n---")

    HOME_DIR = path.expanduser("~")
    REPO = "dotfiles"
    CONFIG_DIR = "dotfile-directory"
    CONFIGFILES: List[str] = listdir(CONFIG_DIR)

    for file in CONFIGFILES:

        print(f"Linking <{file}> with:")

        CMD = [
            "ln",
            "-s",
            "-F",
            "-f",
            path.join(HOME_DIR, REPO, CONFIG_DIR, file),
            path.join(HOME_DIR, file),
        ]

        for token in CMD:
            print(token, end=" ")
        print()

        result = run(
            CMD,
            capture_output=True,
            text=True
        )

        print(result.stdout, file=stdout)
        print(result.stderr, file=stderr)



if __name__ == "__main__":
    main()

    
