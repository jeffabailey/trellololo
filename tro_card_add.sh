#!/bin/sh

echo "$1" > ./query.log

. "$HOME/Shell/configure_exports.sh"

./functions.sh

query="$1"

board="$(echo $query | cut -d';' -f1)"
name="$(echo $query | cut -d';' -f2)"
desc="$(echo $query | cut -d';' -f3)"

# echo "${board}\n"
# echo "${name}\n"
# echo "${desc}\n"

# Aliases
# TODO: move alias configuration to a separate file
case $board in
	jbb)
		boardId='LM5gT1Ka'
        listId='5e1fde3a27b17242f76c9ae2' # To Do — JBB
		;;
	jbopt)
		boardId='IB0OtGx5'
        listId='64c678b617e372dd290e102c' # New
		;;
	jbact)
		boardId='Xpe2Ry3p'
        listId='64c67c7eebcc59451a364df4' # New
		;;
	nkact)
		boardId='OKutO3CM'
        listId='64c6805041640dca856f9507' # New
		;;        
esac

url="https://api.trello.com/1/cards?idList=${listId}&key=${TRELLO_APP_KEY}&token=${TRELLO_TOKEN}"

# echo "$url\n"

# Add card
result=$(curl --silent \
    --request POST \
    --data-urlencode "name=${name}" \
    --data-urlencode "desc=${desc}" \
    --url "${url}" \
    --header 'Accept: application/json') || echo "Error: $result" > error.log

# Get lists
# curl --request GET \
#   --url "https://api.trello.com/1/boards/${boardId}/lists?key=${TRELLO_APP_KEY}&token=${TRELLO_TOKEN}" \
#   --header 'Accept: application/json'
  
# Get cards
# curl --request GET \
#   --url "https://api.trello.com/1/boards/${boardId}/cards?key=${TRELLO_APP_KEY}&token=${TRELLO_TOKEN}" \
#   --header 'Accept: application/json'