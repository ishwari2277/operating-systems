#!/bin/bash
# Shell programming: Address book with options for creating, viewing, inserting, deleting, and modifying records.

echo "Welcome to my address book..."
read -p "Enter the address book name: " bname

if [ ! -e "$bname" ]; then
    touch "$bname"
    echo "Address book with the name $bname created successfully"
    echo -e "ID\t\tNAME\t\tMOBILE\t\tEMAIL" >> "$bname"
else 
    echo "Address book already exists!"
fi

while true; do
    echo ""
    echo "************** Address Book **************"
    echo "a. Display Address book"
    echo "b. Insert a record"
    echo "c. Delete a record"
    echo "d. Modify a record"
    echo "e. Exit"
    read -p "Enter your choice: " ch

    case $ch in
    a)
        cat "$bname"
        echo ""
        ;;
    b)
        read -p "Enter ID: " id
        read -p "Enter Name: " name
        read -p "Enter Mobile: " mobile
        read -p "Enter Email: " email
        read -e "$id\t\t$name\t$mobile\t$email" >> "$bname"
        ;;
    c)
        read -p "Enter the ID to be deleted: " did
        if grep -qw "$did" "$bname"; then
            grep -vw "$did" "$bname" > temp && mv temp "$bname"
            echo "Record deletion successful..."
        else
            echo "Record with ID $did does not exist"
        fi
        ;;
    d)
        read -p "Enter the ID to be modified: " mid
        if grep -qw "$mid" "$bname"; then
            grep -vw "$mid" "$bname" > temp && mv temp "$bname"
            read -p "Enter New ID: " id
            read -p "Enter New Name: " name
            read -p "Enter New Mobile: " mobile
            read -p "Enter New Email: " email
            echo -e "$id\t\t$name\t$mobile\t$email" >> "$bname"
            echo "Record modified successfully..."
        else
            echo "Record with ID $mid does not exist"
        fi
        ;;
    e)
        echo "Thank you!"
        exit
        ;;
    *)
        echo "Please enter a valid choice"
    esac
done
