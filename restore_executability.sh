#!/bin/bash

if [[ -z "$1" ]]
then if [[ -z "$0" ]]
     then echo "not running from a file" 1>&2
          exit 1
     else echo "restore executability for file in $(realpath .)" 1>&2
          find . -maxdepth 1 -type f -exec "$BASH" "$0" "{}" ";"
     fi
     exit 0
else if file "$1" | grep -iqP "ELF.*(32|64)-bit.*(executable|shared)"
     then echo "$1 is ELF executable" 1>&2
          chmod +x "$1"
     else if head -n1 "$1" | grep -qP "^#! */"
          then echo "$1 have shebang" 1>&2
               chmod +x "$1"
          else if [[ ${1##*.} = "exe" ]] || [[ ${1##*.} = "run" ]] || [[ ${1##*.} = "appimage" ]]
               then case ${1##*.} in
                    exe) echo "$1 is windows executable (.exe)" ;;
                    run) echo "$1 is probably executable (.run)" ;;
                    appimage) echo "$1 is an app-image executable package (.appimage)" ;;
                    esac
                    chmod +x "$1"
               else if [[ ${1##*.} = "jar" ]] 
                    then if [[ -e "${1%.*}" ]] 
                         then echo "not overwriting ${1%.*}"
                         else echo "$1 is java archive, probably executable by java VM, creating execution script ${1%.*}"
                              chmod -x "$1"
                              if not test -z $JAVA_HOME ; then
                              echo "#!/bin/bash"   >> "${1%.*}"
                              RP=$(realpath $1)
                              echo "pushd \"${RP%/*}\""  >> "${1%.*}"
                              echo "$JAVA_HOME/jre/bin/java -jar \"./${1##*/}\""   >> "${1%.*}"
                              echo "popd"  >> "${1%.*}"
                              chmod +x "${1%.*}"
                              else echo "please define \$JAVA_HOME to jre/jdr root path"
                              fi
                         fi
                    else echo "$1 is not probed to be executable" 1>&2
                         chmod -x "$1"
                    fi
               fi
          fi
     fi 
fi               
