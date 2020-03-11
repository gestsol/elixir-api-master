#!/usr/bin/env sh


# -----------------------------------------------------------------------------
# Configuracion
# -----------------------------------------------------------------------------

pascalCaseBefore="ApiMaster"
snakeCaseBefore="api_master"
kebabCaseBefore="api-master"

content=$(find . -type f \( \
  -name "*.ex" -or \
  -name "*.exs" -or \
  -name "*.eex" -or 
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

paths=$(find . -maxdepth 2 -mindepth 2 \( \
  -path "./lib/${snakeCaseBefore}*" -or \
  -path "./lib/${snakeCaseBefore}_*" -or \
  -path "./lib/${snakeCaseBefore}.*" -or \
  -path "./test/${snakeCaseBefore}*" -or \
  -path "./test/${snakeCaseBefore}_*" \
\))

# -----------------------------------------------------------------------------
# Funciones
# -----------------------------------------------------------------------------

header() {
  echo "\033[0;33m▶ $1\033[0m"
}

success() {
  echo "\033[0;32m▶ $1\033[0m"
}

# -----------------------------------------------------------------------------
# Validacion
# -----------------------------------------------------------------------------

if [ -z "$1" ] ; then
  echo 'Debe colocar el nombre del proyecto'
  exit 0
fi

pascalCaseAfter=$1
snakeCaseAfter=$(echo $pascalCaseAfter | sed 's/\(.\)\([A-Z]\)/\1_\2/g'| tr '[:upper:]' '[:lower:]')
kebabCaseAfter=$(echo $snakeCaseAfter | tr '_' '-')


# -----------------------------------------------------------------------------
#  Ejecucion 
# -----------------------------------------------------------------------------
header "Configuration"
echo "${pascalCaseBefore} → ${pascalCaseAfter}"
echo "${snakeCaseBefore} → ${snakeCaseAfter}"
echo "${kebabCaseBefore} → ${kebabCaseAfter}"
echo ""

header "Cambiando nombre del Proyecto dentro del Contenido....." 
for file in $content
do
  sed -i "s/$pascalCaseBefore/$pascalCaseAfter/g" $file
  sed -i "s/$snakeCaseBefore/$snakeCaseAfter/g" $file
done
success "Hecho!!!!\n"

header "Cambiando rutas de los directorios....."
for path in $paths; do
  mv $path $(echo $path | sed "s/$snakeCaseBefore/$snakeCaseAfter/g")
done
success "Hecho!!!!\n"


header "Cambiando nombre del Directorio Raiz....."
mv $PWD $(echo $PWD | sed "s/elixir-api-master/$kebabCaseAfter/g")

success "Hecho!!!!\n"

header "Eliminando el Scrip para hacer Setup al Proyecto...."
rm -fr setup.sh

success "Hecho!!!!\n"