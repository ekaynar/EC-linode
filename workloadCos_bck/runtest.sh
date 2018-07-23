
# Bring in other script files
myPath="${BASH_SOURCE%/*}"
if [[ ! -d "$myPath" ]]; then
    myPath="$PWD" 
fi

sleeptime="2"
# Variables
source "$myPath/vars.shinc"

# Functions
source "$myPath/Utils/functions.shinc"

# Create log file - named in vars.shinc
if [ ! -d $RESULTSDIR ]; then
  mkdir -p $RESULTSDIR || \
    error_exit "$LINENO: Unable to create RESULTSDIR."
fi
touch $LOGFILE || error_exit "$LINENO: Unable to create LOGFILE."
updatelog "${PROGNAME} - Created logfile: $LOGFILE" $LOGFILE


#>>> PHASE 1: Run Workload <<<
# Start the COSbench I/O workload
pbench-user-benchmark "Utils/cos.sh ${myPath}/${RUNTESTxml} $LOGFILE" &

PIDpbench=$!
updatelog "** pbench-user-benchmark cosbench started as PID: ${PIDpbench}" $LOGFILE 
# VERIFY it successfully started
sleep "${sleeptime}"
if ps -p $PIDpbench > /dev/null; then
    updatelog "START: IO-Workload - running... " $LOGFILE
    sleep 600
else
    error_exit "pbench-user-benchmark cosbench FAILED"
fi

# sleep for closuredelay directive in ioWorkload.xml
sleep 30


#>>> PHASE 2: Collect Results <<<
# Wait for pbench to complete
while ps -p $PIDpbench > /dev/null; do
    updatelog "Waiting for pbench-user-benchmark to complete" $LOGFILE
    sleep 1m
done
updatelog "pbench-user-benchmark process completed" $LOGFILE

# Copy the LOGFILE, PBENCH and COSbench results to /var/www/html/pub
Cresults=`ls -tr $cosPATH/archive | tail -n 1`
Dpath="/var/www/html/pub/$Cresults.$ts"
mkdir $Dpath
cp -r $cosPATH/archive/$Cresults $Dpath/.
Presults=`ls -tr /var/lib/pbench-agent | grep pbench-user-benchmark | tail -n 1`
cp -r /var/lib/pbench-agent/$Presults $Dpath/.

updatelog "FINALIZING: Pbench and COSbench results copied to $Dpath" $LOGFILE



# copy LOGFILE to results dir
cp $LOGFILE $Dpath/.

# END

