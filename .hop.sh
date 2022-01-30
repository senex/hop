HOPRC=$HOME/.hoprc
hop()
{
    test -e $HOPRC || echo -n "" > $HOPRC
    local OPTION OPTARG OPTIND
    while getopts "s:d:lh" OPTION; do
        case "${OPTION}" in
        s)
            grep "^${OPTARG} " $HOPRC >/dev/null
            if [ $? -eq 0 ]
            then
                sed -i "s/^${OPTARG} .*/${OPTARG} $(pwd)/" $HOPRC
            else
                echo ${OPTARG} $(pwd) >> $HOPRC
            fi
            return 0
            ;;
        d)
            ENTRY=$(grep "^${OPTARG} " $HOPRC)
            if [ $? -ne 0 ] 
            then
                echo "ERROR: Target ${OPTARG} not found"
                return 1
            fi
            sed -i "/^${OPTARG} .*/d" $HOPRC
            return 0
            ;;
        l)
            grep -v "^[ #]" $HOPRC
            return 0
            ;;
        h)
            echo "USAGE: hop [OPTION] [TARGET]"
            echo "Changes directory to a given target"
            echo ""
            echo "Options:"
            echo "-s TARGET   Save the current directory as TARGET"
            echo "-d TARGET   Delete a given TARGET"
            echo "-l          List available targets"
            echo "-h          Show help"
            return 0
            ;;
        *)
            echo "Incorrect options provided"
            return 1
            ;;
        esac
    done
    shift $((OPTIND-1))
    if [ -z "$1" ]
    then
        echo "ERROR: Must specify a target"
        return 1
    fi
    ENTRY=$(grep "^${1} " $HOPRC)
    if [ $? -ne 0 ] || [ -z "$ENTRY" ]
    then
        echo "ERROR: Target ${1} not found"
        return 1
    fi
    DIR=$(echo $ENTRY | cut -f 2 -d ' ')
    cd $DIR
}
