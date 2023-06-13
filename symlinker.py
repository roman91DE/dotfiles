#!/usr/bin/env python3

import os
import sys
from datetime import datetime


class Utils:
    """Utility functions for the symlinker"""

    paths = {
        "home": os.path.expanduser("~"),
        "repo": os.path.dirname(__file__),
        "config_src": os.path.join(os.path.dirname(__file__), "configfiles"),
    }

    uids = {
        "user": os.getuid(),
    }

    @staticmethod
    def prepend_dot(filename: str) -> str:
        """Prepends a dot to filenames"""
        if filename.startswith("."):
            return filename
        else:
            return f".{filename}"

    @staticmethod
    def safety_check():
        """warn user to avoid the loss of existing dot files"""
        while True:
            print(
                f"Warning: Running this script will overwrite all existing configuration files!",
                file=sys.stderr,
            )
            answer = input("Type yes to continue, or no to abort: ")
            if answer.lower() == "yes":
                break
            elif answer.lower() == "no":
                print("Aborted Process", file=sys.stderr)
                sys.exit()
            else:
                print("Invalid input. Please enter 'yes' or 'no'.", file=sys.stderr)

    @staticmethod
    def backup_existing_files() -> bool:
        """ask user if they want to backup their existing dot files"""
        while True:
            print(
                f"Do you want to backup any configuration files that already exist?",
                file=sys.stdout,
            )
            answer = input("Type yes to continue, or no to abort: ")
            if answer.lower() == "yes":
                return True
            elif answer.lower() == "no":
                return False
            else:
                print("Invalid input. Please enter 'yes' or 'no'.", file=sys.stderr)


def main():
    Utils.safety_check()
    create_backups = Utils.backup_existing_files()

    print(f"Starting to create Symbolic Links...\n---")

    configfiles = os.listdir(Utils.paths["config_src"])

    for file in configfiles:
        file_path = os.path.join(Utils.paths["config_src"], file)
        link_path = os.path.join(Utils.paths["home"], Utils.prepend_dot(file))

        # handle existing files
        if os.path.exists(link_path):
            # skip if file is not owned by user
            if os.stat(link_path).st_uid != Utils.uids["user"]:
                print(
                    f"Skipping {link_path} as it is not owned by the user {os.getlogin()}",
                    file=sys.stderr,
                )
                continue

            # remove existing symbolic links
            elif os.path.islink(link_path):
                os.remove(link_path)
                print(
                    f"Replacing {link_path} as it is is already a symbolic link",
                    file=sys.stderr,
                )

            # backup existing files if option selected
            elif (not os.path.islink(link_path)) and create_backups:
                backup_path = os.path.join(
                    Utils.paths["home"],
                    f"{file}.bak-{datetime.now().strftime('%Y%m%d%H%M%S')}",
                )
                os.rename(link_path, backup_path)
                print(f"Backed up {link_path} to {backup_path}", file=sys.stderr)

        try:
            os.symlink(file_path, link_path)
            print(f"Created symbolic link for {file} in {link_path}")
        except Exception as e:
            print(f"Failed to create symbolic link for {file}: {e}", file=sys.stderr)


if __name__ == "__main__":
    main()
