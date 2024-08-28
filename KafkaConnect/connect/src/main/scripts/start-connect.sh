#!/bin/bash
#set -a
#set -x
function show_help () {
  printf "usage:\t%s  [-log4j=<Log4j properties file>] [-mode=standalone|distributed] \n" ${0##*/}
  printf "\tThese arguments *must* appear before any other arguments or they may not be parsed.\n"
  printf "\tParsing ends after '--' or the first argument not beginning with '-'. \n"
} >&2

CAT=/bin/cat
GREP=/bin/grep
WC=/usr/bin/wc
SED=/bin/sed

#
# Script options from command line arguments.
#
KAFKA_HOME="/opt/kafka/"
LOG_LEVEL="WARN"
MODE="standalone"
LOG_PROPS_FILE="$KAFKA_HOME/config/connect-log4j.properties"
KAFKA_CONNECT_STANDALONE="$KAFKA_HOME/bin/connect-standalone.sh"
KAFKA_CONNECT_DISTRIBUTED="$KAFKA_HOME/bin/connect-distributed.sh"

while :
do
  case $1 in
    -h | --help | -\?)
      show_help
      exit 0
    ;;
    -log4j=*)
      LOG_PROPS_FILE=${1#*=}
      cp $LOG_PROPS_FILE "$KAFKA_HOME/config/connect-log4j.properties"
      shift
    ;;
    -mode=*)
      MODE=${1#*=}
      shift
    ;;
    --) # End of all options
      shift
      break
    ;;
    *)
      #echo "WARN: Unknown option: $1" >&2
      OTHER_PARAMS+=" ${*} "
      #shift
	break
    ;;
 #   *)  # no more options. Stop while loop
  #    break
   # ;;
  esac
done

echo Other Params.... $OTHER_PARAMS

if [[ $MODE == "standalone" ]]; then
	echo $MODE $KAFKA_CONNECT_STANDALONE $OTHER_PARAMS
	$KAFKA_CONNECT_STANDALONE $OTHER_PARAMS
else
	$KAFKA_CONNECT_DISTRIBUTED $OTHER_PARAMS
fi
