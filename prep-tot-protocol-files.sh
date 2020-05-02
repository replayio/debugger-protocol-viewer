#!/bin/bash
set -x

# Machine-specific path, naturally
local_script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
protocol_repo_path="$local_script_path/../webreplay-protocol"

protocol_path="$protocol_repo_path/json/protocol.json"

# => into viewer
cd $local_script_path
local_protocol_path="pages/_data/tot.json"

if ! [ -s $protocol_path ]; then
  echo "error: couldn't find local protocol file" >&2; exit 1
fi
# copy the protocol.json over
cp $protocol_path $local_protocol_path

node create-search-index.js

# copy it into the HTML file
# => into viewer
cd $local_script_path

# we no longer printing the most recent protocol git hashes.
# we can restore this when the devtools-protocol repo starts includes that data

cat pages/tot.md | sed -Ee "s/^(<code browser>)Date.*/\1$br_date_line/" > pages/tot.md.new
cat pages/tot.md.new | sed -Ee "s/^(<code js>)Date.*/\1$js_date_line/"  > pages/tot.md
rm -f pages/tot.md.new

