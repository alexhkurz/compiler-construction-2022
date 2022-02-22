# @name: bfrun
# @author: Matt Raymond
# @email: m4tt.r4ymond@gmail.com
# @date: 03/15/2020
# @version: 1.0
#
# @description: This script compiles code in bnfc and cleans out the extra files
#               that you don't need to keep your code from being too messy
#
# @usage: `./bfrun -c <input_file>` only compiles the code
#         `./bfrun <input_file> <testing_file>` compiles and runs the code

# Checks to see what flags are passed
# If help flag is passed, it prints the help dialoge
if [ "$1" == "-h" ]; then
    echo -e "Compile:\tbfrun -c <input_file>"
    echo -e "Comp/Run:\t\tbfrun <input_file> <testing_file>"
    echo -e "Run:\t\tbfrun -r <testing_file>"
    echo -e "Run:\t\tbfrun <parser> <testing_file>"
    echo -e "Help:\t\tbfrun -h"
# If compile flag is passed, then it only compiles the code
elif [ "$1" == "-c" ]; then
    if [ "$2" != "" ]; then
        clear
        bnfc -m -haskell "$2" && make
    else
        echo "Usage: bfrun -c <input_file>"
    fi
# If run flag is passed, then it only runs the parser
elif [ "$1" == "-r" ]; then
    if [ "$3" != "" ]; then
        clear
        cat "$3" | "./"$2
    elif [ "$2" != "" ]; then
        clear
        test="Test*"
        allTests=($test)
        if [ ${#allTests[@]} == 1 ]; then
            cat "$2" | "./"${test}
        else
            echo "Please specify: "${Test}
            echo "bfrun -r <parser> <testing_file>"
        fi
    else
        echo "Usage: bfrun -c <input_file>"
    fi
# If you pass two files, then it compiles and runs
elif [ "$1" != "" ] && [ "$2" != "" ]; then
    clear
    bnfc -m -haskell "$1" && make && cat "$2" | "./Test${1%.cf}"
else
    echo "try bnf -h"
fi

# Declares a list of files to clean up
declare -a arr=("*.hs" "*.hi" "*.bak" "*.o" "*.x" "Makefile" "*.info" "*.y"
                ".DS_Store" "DocCpp.txt")

# Cycles through every extension
for extension in "${arr[@]}"; do
    # Cycles through every file of the extension
    for file in ${extension}; do
        # If the file exists, deletes it
        [ -e ${file} ] && rm ${file}
    done
done
