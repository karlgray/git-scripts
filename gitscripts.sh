SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


#ANSI Colour codes.
NC='\e[0m';
RED='\033[0;31m'
GREEN='\033[0;32m'

source ${SCRIPT_DIR}/scripts/gitcleanup.sh
source ${SCRIPT_DIR}/scripts/gitnewbranch.sh
source ${SCRIPT_DIR}/scripts/gitcheckout.sh
source ${SCRIPT_DIR}/scripts/gitsave.sh
source ${SCRIPT_DIR}/scripts/gittest.sh
source ${SCRIPT_DIR}/scripts/test.sh




