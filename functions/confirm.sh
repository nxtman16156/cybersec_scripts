readable=false
while [[ $readable = false ]]
do
    read -p "${1}? [y/n] " answer
    if [[ $answer = y ]] || [[ $answer = n ]]
    then
        readable=true
    else
        echo "Please enter valid answer"
    fi
done

if [[ $answer = y ]]
then
    exit 1
else
    exit 2
fi