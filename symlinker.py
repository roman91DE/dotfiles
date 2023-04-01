#!/usr/bin/env python3

import subprocess
from os import listdir
from typing import List


if __name__ == "__main__":

    CONFIGFILES: List[str] = listdir("./dotfiles")

    for file in CONFIGFILES:
        print(file)
