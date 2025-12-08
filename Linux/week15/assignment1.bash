#! /bin/bash
clear

bash Courses.bash
courseFile="courses.txt"

function displayCoursesofInst() {
    echo -n "Please Input an Instructor Full Name: "
    read instName
    echo ""
    echo "Courses of $instName :"
    awk -F';' -v name="$instName" 'NR>1 && tolower($7) ~ tolower(name) {print $1" | "$2" | "$5" | "$6" | "$7}' "$courseFile"
    echo ""
}

function courseCountofInsts() {
    echo ""
    echo "Course-Instructor Distribution"
    awk -F';' 'NR>1 && $7 !~ /^[0-9]/ && $7 !~ /AM|PM/ && $7 !~ /\// && $7 != "" {print $7}' "$courseFile" \
       | sort | uniq -c | sort -nr
    echo ""
}

function displayCoursesByLocation() {
    echo -n "Please Input a Location: "
    read location
    echo ""
    echo "Courses in $location :"
    awk -F';' -v loc="$location" 'NR>1 && $10 == loc {print $1" | "$2" | "$5" | "$6" | "$7}' "$courseFile"
    echo ""
}

function displayAvailableCourses() {
    echo -n "Please Input a Course Code: "
    read courseCode
    echo ""
    echo "Available courses for $courseCode :"
    awk -F';' -v code="$courseCode" 'NR>1 && toupper($1) ~ toupper(code) && $4 > 0 {print $1" | "$2" | "$4 " seats available"}' "$courseFile"
    echo ""
}

while :
do
    echo ""
    echo "Please select an option:"
    echo "[1] Display courses of an instructor"
    echo "[2] Display course count of instructors"
    echo "[3] Display courses of a classroom"
    echo "[4] Display available courses of subject"
    echo "[5] Exit"
    read userInput
    echo ""
    case "$userInput" in
        1) displayCoursesofInst ;;
        2) courseCountofInsts ;;
        3) displayCoursesByLocation ;;
		4) displayAvailableCourses ;;
        5) echo "Goodbye"; break ;;
        *) echo "Invalid input. Please select between 1-5." ;;
    esac
done