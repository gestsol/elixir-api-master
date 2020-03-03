#!/usr/bin/env sh

content=$(find . -type f \( \
  -name "*.ex" -or \
  -name "*.exs" -or \
  -name "*.ees" -or \
  -name "*.sh" -or \
  -name "*.json" -or \
  -name "*.js" -or \
  -name "*.yml" -or \
  -name "*.md" -or \
  -name ".env.*" -or \
  -name "Dockerfile" -or \
  -name "Makefile" \
\) \
  -and ! -path "./setup.sh" \
  -and ! -path "./setupP.sh" \
  -and ! -path "./assets/node_modules/*" \
  -and ! -path "./_build/*" \
  -and ! -path "./deps/*" \
)

paths=$(find .\( \
  -path "./lib/${snakeCaseBefore}*" -or \
  -path "./lib/${snakeCaseBefore}_*" -or \
  -path "./lib/${snakeCaseBefore}.*" -or \
  -path "./test/${snakeCaseBefore}" -or \
  -path "./test/${snakeCaseBefore}_*" \
\))

#echo " $paths"

# -----------------------------------------------------------------------------
# Configuracion
# -----------------------------------------------------------------------------

pascalCaseBefore="ApiMaster"
snakeCaseBefore="api_master"
kebabCaseBefore="api-master"



# -----------------------------------------------------------------------------
# Validacion
# -----------------------------------------------------------------------------

if [ -z "$1" ] ; then
  echo 'Debe colocar el nombre del proyecto'
  exit 0
fi

pascalCaseAfter=$1
snakeCaseAfter=$(echo $pascalCaseAfter | sed 's/\(.\)\([A-Z]\)/\1_\2/g'| tr '[:upper:]' '[:lower:]')
#kebabCaseAfter=$(echo $snakeCaseAfter | tr '_' '-')


# -----------------------------------------------------------------------------
#  Ejecucion 
# -----------------------------------------------------------------------------

for file in $content
do
  sed -i "s/$pascalCaseBefore/$pascalCaseAfter/g" $file
  sed -i "s/$snakeCaseBefore/$snakeCaseAfter/g" $file
done

for path in $paths; do
  mv $path $(echo $path | sed "s/$snakeCaseBefore/$snakeCaseAfter/g")
done
