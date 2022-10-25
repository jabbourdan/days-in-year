#!/bin/bash

#is_number()---------------------------#
#This function tests if the arguments is number 
#input 		 : from one to several arguments
#output 	 : if one of the arguments is not a number exits with 1 else return 0
#used functions  : none 
#--------------------------------------#

is_number(){
    regx='^[0-9]+$'
    for num in $@
    do
    if [[ ! $num =~ $regx ]]
    then
        echo "not number"
        exit 1
    fi
    done 
}

#not_dividable_by()-------------------#
#This function tests if the arg1 is dividable by arg2 
#input 		 : 2 numbers as arguments
#output 	 : if dividable returns 0 else return 1
#used functions  : is_number
#-------------------------------------#

not_dividable_by(){

    if [ $# -ne 2 ]
    then
        echo argument not correct
        exit 1
    fi
    is_number $@
    if [ $2 -eq 0 ]
    then
        echo "Error! cannot divide by zero"
        exit 1
    fi

    num_div=$1
    divide_by=$2
    if (( num_div%divide_by ))
    then 
    return 0
    else
    return 1
    fi
}

#mounth_days()----------------------------#
#This function takes two arguments year and mounth (YYYY,MM) and return the number  -
# of days in that mounth
#input		 : 2 numbers "year and mounth (YYYY,MM)
#output 	 : exit 1 if wrong input ,else exit number_of_days
#used functions  : is_number() & not_dividable_by() & is_leap()
#-----------------------------------------#

mounth_days(){
    local year=$1
    local mounth=$2

    case $mounth in
    1 | 3 | 5 | 7 | 8 | 10 | 12)
        echo 31
        return 31;;
    4 | 6 | 9 | 11)
        echo 30
        return 30;;
    2)
         if is_leap $year
        then
            echo 29
            return 29
        else
            echo 28
        return 28
        fi  ;;
     *)
        echo mounth not correct
        exit 1 ;;
    esac
}

#years_day()------------------------------#
#This function takes three arguments "year, mounth and day (YYYY,MM,DD)" and return the -
# day number in the year
#input		 : 3 numbers "year, mounth and day (YYYY,MM,DD)" 
#exit code	 : if wrong input exit 1 with error massage, else returns and print number of days
#used functions  : is_number() & not_dividable_by() & is_leap() $ mounth_days()
#-----------------------------------------#

years_day(){
    if [ $# -ne 3 ]
    then
        echo not correct number of argus
        exit 1
    fi
    is_number $@


    local year=$1
    local mounth=$2
    local day=$3

    echo $year $mounth $day
    mounth_index=1
    day_of_the_year=$day
    while [ $mounth_index -lt $mounth ]
    do
    let day_of_the_year+=$(mounth_days $year $mounth_index)
    let mounth_index++
    done
    echo $day_of_the_year

}

#----------------------------------------#
#test place


if [ $# -ne 3 ]
then
    echo not correct number of argus
    exit 1
fi
is_number $@
years_day $1 $2 $3




