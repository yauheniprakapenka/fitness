realpath() {
  OURPWD=$PWD
  cd "$(dirname "$1")"
  LINK=$(readlink "$(basename "$1")")
  while [ "$LINK" ]; do
    cd "$(dirname "$LINK")"
    LINK=$(readlink "$(basename "$1")")
  done
  REALPATH="$PWD/$(basename "$1")"
  cd "$OURPWD"
  echo "$REALPATH"
}


SWAGGEN_EXEC=${1:-swaggen}
SPEC_PATH='../API/Bundled/openapi3combined.yaml'
SPEC_PATH_ABS=$(realpath $SPEC_PATH)
TEMPLATES_FOLDER='./Templates'
TEMPLATES_FOLDER_ABS=$(realpath $TEMPLATES_FOLDER)
OUT_FOLDER='../iOS/LocalCocoaPods/FitnessAPI'
OUT_FOLDER_ABS=$(realpath $OUT_FOLDER)


# remove all previous generated content
rm -rf ${OUT_FOLDER_ABS}*

echo Start generating

# generate
${SWAGGEN_EXEC} generate $SPEC_PATH_ABS --template ${TEMPLATES_FOLDER_ABS} --destination ${OUT_FOLDER_ABS}