echo "Hello, To Assignment 1"

read -p "Enter your name : " name

# if [ rollno == 29 ]; then 
#     echo "You are great developer"
# else
#     echo "You are not great developer"
# fi

# for i in {0..50..5}; do 
#     echo "$i"
# done

# read -p "Enter count : " count
# while [ $count -le 5 ]; do
#     echo "Count : $count"
#     count = $((count+1))
# done

# a = 5,b = 10
# echo $((a+b))
# echo $((b-a))
# echo $((b*a))
# echo $((b/a))


echo "Enter the first number:"
read num1
echo "Enter the second number:"
read num2

# Perform arithmetic comparisons
echo $((num1+num2))


if [ "$num1" -eq "$num2" ]; then
  echo "$num1 is equal to $num2"
fi

if [ "$num1" -ne "$num2" ]; then
  echo "$num1 is not equal to $num2"
fi

if [ "$num1" -gt "$num2" ]; then
  echo "$num1 is greater than $num2"
fi

if [ "$num1" -lt "$num2" ]; then
  echo "$num1 is less than $num2"
fi

if [ "$num1" -ge "$num2" ]; then
  echo "$num1 is greater than or equal to $num2"
fi

if [ "$num1" -le "$num2" ]; then
  echo "$num1 is less than or equal to $num2"
fi
