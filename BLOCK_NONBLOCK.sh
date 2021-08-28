#!/bin/bash
IS_BLOCK_ENABLED_STRING="isBlockEnabled - TRUE"
​
function printdata()
{  output=$1
   echo -e "output :: $output"
}
​
PodNameMap=$(/u01/lcm/podmetadata/bin/get_prop.py pod.fact.name)
PodName=$(echo $PodNameMap | cut -f2 -d=)
printdata "Pod Name=$PodName"
​
PodArchMap=$(/u01/lcm/podmetadata/bin/get_prop.py pod.fact.architecture)
podArchitecture=$(echo $PodArchMap | cut -f2 -d=)
printdata "Pod Architecture=$podArchitecture"
​
if [[ "$podArchitecture" == "OCI" ]]; then
    isBlockEnabled=$(/podscratch/lcm-artifacts/pod-storage-util/pod-storage-util/bin/podstorage-util-tool.sh is_block_enabled)
    printdata "Pod Is block Enabled :: isBlockEnabled - $isBlockEnabled"
    if [[ $isBlockEnabled = *TRUE* ]]; then
        printdata "Pod $PodName is block enabled"
    else
        printdata "Pod $PodName is NOT block enabled"
    fi
else
    printdata "Pod $PodName is NOT OCI"