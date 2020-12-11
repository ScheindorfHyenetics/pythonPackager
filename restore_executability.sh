#!/bin/bash

if [[ -z "$1" ]]
then if [[ -z "$0" ]]
     then echo "not running from a file" 1>&2
          exit 1
     else echo "restore executability for file in $(realpath .)" 1>&2
          find . -maxdepth 1 -type f -exec "$BASH" "$0" "{}" ";"
     fi
     exit 0
else if file "$1" | grep -iqP "ELF.*(32|64)-bit.*(executable|shared.*interpreter)"
     then echo "$1 is ELF executable" 1>&2
          chmod +x "$1"
     else if head -n1 "$1" | grep -qP "^#! */"
          then echo "$1 have shebang" 1>&2
               chmod +x "$1"
          else echo "$1 is not executable" 1>&2
               chmod -x "$1"
          fi
     fi
fi
