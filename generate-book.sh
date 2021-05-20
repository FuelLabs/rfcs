#!/usr/bin/env bash

set -e

if [ ! -d src ]; then
    mkdir src
fi

printf -- '# Summary\n\n' > src/SUMMARY.md

printf -- '- [RFCS](introduction.md)\n' >> src/SUMMARY.md

find ./text ! -type d -print0 | xargs -0 -I {} ln -frs {} -t src/

find ./text ! -type d -name '*.md' -print0 \
  | sort -z \
  | while read -r -d '' file;
do
    printf -- '    - [%s](%s)\n' "$(basename "$file" ".md")" "$(basename "$file")"
done >> src/SUMMARY.md

ln -frs README.md src/introduction.md

printf -- '- [Code Standards Introduction](code-standards-intro.md)\n' >> src/SUMMARY.md

ln -frs code-standards/README.md src/code-standards-intro.md

find ./code-standards/text ! -type d -print0 | xargs -0 -I {} ln -frs {} -t src/

find ./code-standards/text ! -type d -name '*.md' -print0 \
  | while read -r -d '' file;
do
    printf -- '    - [%s](%s)\n' "$(basename "$file" ".md")" "$(basename "$file")"
done >> src/SUMMARY.md

mdbook build .
