SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo $SCRIPT_DIR
source ./scripts/gitcleanup.sh
source ./scripts/gitnewbranch.sh
source ./scripts/gitcheckout.sh
source ./scripts/gitsave.sh
source ./scripts/gittest.sh




