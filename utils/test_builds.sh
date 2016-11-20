set -eu
set -o pipefail

for dir in $(find scripts/* -maxdepth 1 -type dir -name '*' -print); do
    package_name=$(basename $dir)
    for subdir in $(find $dir/* -maxdepth 1 -type dir -name '*' -print); do
        version=$(basename $subdir)
        RESULT=0
        OUTPUT=$(./mason fetch $package_name $version 2>&1) || RESULT=$?
        if [[ ${RESULT} != 0 ]]; then
            echo "Fail($package_name $version): $OUTPUT"
        fi
    done
done