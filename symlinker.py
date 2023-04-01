#!/usr/bin/env python3

from subprocess import run
from os import listdir, path
from typing import List
from sys import stdout, stderr

def main():

    print(f"Starting to create Symbolic Links for all dotfiles")

    HOME_DIR = path.expanduser("~")
    CONFIG_DIR = "./dotfiles"
    CONFIGFILES: List[str] = listdir(CONFIG_DIR)

    for file in CONFIGFILES:



        print(f"Linking File/Folder: {file}")

        CMD = [
            "ln",
            "-s",
            "-F",
            "-f",
            path.join(CONFIG_DIR, file),
            path.join(HOME_DIR, file),
        ]

        result = run(
            CMD,
            capture_output=True,
            text=True
        )

        print(result.stdout, file=stdout)
        print(result.stderr, file=stderr)



if __name__ == "__main__":
    main()

    
