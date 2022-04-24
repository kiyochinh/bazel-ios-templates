#!/bin/sh
set -e

# Script inspired by https://gist.github.com/szeidner/613fe4652fc86f083cefa21879d5522b

readonly PROGNAME=$(basename $0)
readonly WORKING_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

die() {
    echo "$PROGNAME: $*" >&2
    exit 1
}

usage() {
    if [ "$*" != "" ] ; then
        echo "Error: $*"
    fi

    cat << EOF
Usage: $PROGNAME --bundle-id [BUNDLE_ID] --project-name [PROJECT_NAME]
Set up an iOS app from tuist template.
Options:
-h, --help                                   display this usage message and exit
-b, --bundle-id [BUNDLE_ID]       the production id (i.e. com.example.package)
-n, --project-name [PROJECT_NAME]            the project name (i.e. MyApp)
EOF
    exit 1
}

bundle_id=""
project_name=""

readonly CONSTANT_PROJECT_NAME="{PROJECT_NAME}"
readonly CONSTANT_BUNDLE_ID="{BUNDLE_ID}"

while [ $# -gt 0 ] ; do
    case "$1" in
    -h|--help)
        usage
        ;;
    -b|--bundle-id)
        bundle_id="$2"
        shift
        ;;
    -n|--project-name)
        project_name="$2"
        shift
        ;;
    -*)
        usage "Unknown option '$1'"
        ;;
    *)
        usage "Too many arguments"
      ;;
    esac
    shift
done

if [ -z "$bundle_id" ] ; then
    read -p "BUNDLE ID (i.e. com.example.project):" bundle_id
fi

if [ -z "$project_name" ] ; then
    read -p "PROJECT NAME (i.e. NewProject):" project_name
fi

if [ -z "$bundle_id" ] || [ -z "$project_name" ] ; then
    usage "Input cannot be blank."
fi

# Enforce package name
regex='^[a-z][a-z0-9_]*(\.[a-z0-9_]+)+[0-9a-z_]$'
if ! [[ $bundle_id =~ $regex ]]; then
    die "Invalid Package Name: $bundle_id (needs to follow standard pattern {com.example.package})"
fi

echo "=> 🐢 Starting init $project_name ..."

# Trim spaces in APP_NAME
readonly PROJECT_NAME_NO_SPACES=$(echo "$project_name" | sed "s/ //g")

# Rename files structure
echo "=> 🔎 Replacing files structure..."


## user define function
rename_folder(){
	local DIR=$1
	local NEW_DIR=$2
    if [ -d "$DIR" ]
    then
        mv ${DIR} ${NEW_DIR}
    fi
}

# Rename app folder structure
rename_folder "${CONSTANT_PROJECT_NAME}" "${PROJECT_NAME_NO_SPACES}"

# Rename test folder structure
rename_folder "${PROJECT_NAME_NO_SPACES}/${CONSTANT_PROJECT_NAME}Tests" "${PROJECT_NAME_NO_SPACES}/${PROJECT_NAME_NO_SPACES}Tests"

# Rename UI Test folder structure
rename_folder "${PROJECT_NAME_NO_SPACES}/${CONSTANT_PROJECT_NAME}UITests" "${PROJECT_NAME_NO_SPACES}/${PROJECT_NAME_NO_SPACES}UITests"

# Add AutoMockable.generated.swift file
mkdir -p "${PROJECT_NAME_NO_SPACES}/${PROJECT_NAME_NO_SPACES}Tests/Sources/Mocks/Sourcery"
touch "${PROJECT_NAME_NO_SPACES}/${PROJECT_NAME_NO_SPACES}Tests/Sources/Mocks/Sourcery/AutoMockable.generated.swift"

# Add R.generated.swift file
mkdir -p "${PROJECT_NAME_NO_SPACES}/Sources/Supports/Helpers/Rswift"
touch "${PROJECT_NAME_NO_SPACES}/Sources/Supports/Helpers/Rswift/R.generated.swift"

echo "✅  Completed"

# Search and replace in files
echo "=> 🔎 Replacing package and package name within files..."
BUNDLE_ID_ESCAPED="${bundle_id//./\.}"
LC_ALL=C find ../ -type f -exec sed -i "" "s/$CONSTANT_BUNDLE_ID/$BUNDLE_ID_ESCAPED/g" {} +
LC_ALL=C find ../ -type f -exec sed -i "" "s/$CONSTANT_PROJECT_NAME/$PROJECT_NAME_NO_SPACES/g" {} +
echo "✅  Completed"

# check for tuist and install
if ! command -v tuist &> /dev/null
then
    echo "Tuist could not be found"
    echo "Installing tuist"
    readonly TUIST_VERSION=`cat .tuist-version`
    curl -Ls https://install.tuist.io | bash
    tuist install ${TUIST_VERSION}
fi

# Install dependencies
echo "Installing pod dependencies"
rm -f .git/index
make install
make build
make project
echo "✅  Completed"

# Remove gitkeep files
echo "Remove gitkeep files from project"
sed -i "" "s/.*\(gitkeep\).*,//" build-system/tulsi/$PROJECT_NAME_NO_SPACES.xcodeproj/project.pbxproj
echo "✅  Completed"

# Remove script files and git/index
echo "Remove script files and git/index"
rm -rf make.sh
rm -rf .github/workflows/test_install_script.yml
rm -f .git/index
echo "✅  Completed"

# Done!
echo "=> 🚀 Done! App is ready to be tested 🙌"