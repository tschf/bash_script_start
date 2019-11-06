#!/bin/bash
# Starting point script. Place all the logic you may need in order to get started
# on a new bash script that received any arguments.

# Load args
# Solution as documented on this Stack Overflow Question:
# https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash

# POSITIONAL is so we can use an array. I think for the most part we wouldn't
# use an array here, but it may be a requirement so leaving as is. If you just
# want one unamed parameter, you can safely just remove the POSITIONAL variable
# and define whatever the name of the variable will be in the *) case statement.
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -a1|--arg1)
    ARG1="$2"
    shift # past argument
    shift # past value
    ;;
    -a2|--arg2)
    ARG2="$2"
    shift # past argument
    shift # past value
    ;;
    --b1) # Bool var - not second arg to read
    BOOL1=true
    shift # past argument
    ;;
    *)    # unknown option
    echo $1
    POSITIONAL+=("$1")
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[1]}" # restore positional parameters

printf "ARG1=$ARG1\n"
printf "ARG2=$ARG2\n"
printf "BOOL1=$BOOL1\n"
printf "${POSITIONAL[*]}\n" # We can reference a specific value with an index

# Validations. Make sure arg1 is supplied. Solution adapted from the following
# Question on stack overflow:
# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
#
# Basically, we need the `+x` part so we can distinguish between an unset variable
# and a variable with an emty string. If ARG1 is undefined, it passes the check
# that it has not been set. If it is set, even to empty string, the return will be "x"
if [[ -z "${ARG1+x}" ]]
then

    printf "[ERROR] ARG1 is not set\n" >&2
    exit 1

fi