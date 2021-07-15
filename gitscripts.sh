SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${SCRIPT_DIR}/scripts/gitcleanup.sh
source ${SCRIPT_DIR}/scripts/gitnewbranch.sh
source ${SCRIPT_DIR}/scripts/gitcheckout.sh
source ${SCRIPT_DIR}/scripts/gitsave.sh
source ${SCRIPT_DIR}/scripts/gittest.sh




