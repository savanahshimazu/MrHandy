#!/bin/bash

# Function to ask the user if they have any communist sympathies
ask_communist_sympathies_dialog() {
    communist_sympathies="Yes"
    while [ "$communist_sympathies" = "Yes" ]; do
        dialog --backtitle "CAUTION" \
               --title "Communist Sympathies Detector" \
               --yesno "Attention, citizen!

               Are you now, or have you ever been, a sympathizer of Communism?

               Remember, it's your civic duty to report any suspicious activities. Choose your response wisely." \
               15 70

        response=$?

        if [ $response -eq 0 ]; then
            dialog --backtitle "Communism Test" \
                   --title "Communist Sympathies Detector" \
                   --msgbox "Communist detected!

                   This is a reminder that any form of communism is strictly prohibited in the Free World. Please reconsider your beliefs.

                   Remember, democracy is non-negotiable." \
                   15 70

            communist_sympathies="Yes"
        else
            dialog --backtitle "Communism Test" \
                   --title "Congratulations, Citizen" \
                   --msgbox "Freedom preserved!

                   Thank you for your cooperation, citizen. Your dedication to democracy is duly noted.

                   Stay vigilant, and may the spirit of liberty guide your path." \
                   15 70

            communist_sympathies="No"
        fi
    done
}

# Function to show introduction, Bethesda please don't hate me ;)
show_intro_dialog() {
    dialog --backtitle "Timberwolf Software Solutions" \
           --title "Mr. Handy Programs" \
           --msgbox "Welcome, fellow wanderer!

           Greetings, wasteland survivor! Allow me, your friendly neighborhood Mr. Handy, to introduce you to Mr. Handy Programs - your trusty companion for navigating the post-apocalyptic world.

           In your journey across the irradiated wastes, you'll often find the need to harness the power of the command line. Fear not! With Mr. Handy Programs, you can craft and export shell scripts with ease, empowering you to automate tasks and overcome the challenges of the wasteland.

           Whether you're scavenging for resources, fortifying your shelter, or scripting your own survival, Mr. Handy Programs stands ready to assist you.

           Prepare yourself, adventurer, for a journey filled with coding escapades, resourceful utilities, and a dash of retro-futuristic charm!" \
           20 70
}


# Function to create directory if it doesn't exist
create_directory() {
    if [ ! -d "../MrHandy_Programs" ]; then
        mkdir "../MrHandy_Programs"
    fi
}

# Function to create a new file
create_new_file() {
    create_directory
    filename=$(dialog --title "New File" --inputbox "Enter filename (without extension):" 10 40 --stdout)
    if [ -n "$filename" ]; then
        nano "../MrHandy_Programs/$filename.txt"
    fi
}

# Function to open existing file
open_file() {
    files=$(ls ../MrHandy_Programs/*.txt 2>/dev/null)
    if [ -n "$files" ]; then
        filename=$(dialog --title "Open File" --menu "Choose a file to open:" 20 60 10 $(for file in $files; do echo "$file" "$(basename "$file" .txt)"; done) --stdout)
        if [ -n "$filename" ]; then
            nano "$filename.txt"
        fi
    else
        dialog --msgbox "No files found in ../MrHandy_Programs directory." 10 40
    fi
}

# Function to export file
export_file() {
    ask_communist_sympathies_dialog
    files=$(ls ../MrHandy_Programs/*.txt 2>/dev/null)
    if [ -n "$files" ]; then
        filename=$(dialog --title "Export File" --menu "Choose a file to export:" 20 60 10 $(for file in $files; do echo "$file" "$(basename "$file" .txt)"; done) --stdout)
        if [ -n "$filename" ]; then
            choice=$(dialog --title "Export Options" --menu "Choose export option:" 15 40 3 \
            "Utility" "Export as utility script" \
            "Web" "Export as web script" \
            "Entertainment" "Export as entertainment script" --stdout)
            if [ -n "$choice" ]; then
                case $choice in
                    Utility)
                        sudo cp "$filename" "../Utility/$(basename "$filename" .txt).sh"
                        dialog --msgbox "File exported as utility script: ../../Utility/$(basename "$filename" .txt).sh" 10 60
                        ;;
                    Web)
                        sudo cp "$filename" "../Web/$(basename "$filename" .txt).sh"
                        dialog --msgbox "File exported as web script: ../../Web/$(basename "$filename" .txt).sh" 10 60
                        ;;
                    Entertainment)
                        sudo cp "$filename" "../Entertainment/$(basename "$filename" .txt).sh"
                        dialog --msgbox "File exported as entertainment script: ../Entertainment/$(basename "$filename" .txt).sh" 10 60
                        ;;
                esac
            fi
        fi
    else
        dialog --msgbox "No files found in ../MrHandy_Programs directory." 10 40
    fi
}


# Main dialog menu

show_intro_dialog
while true; do
    choice=$(dialog --clear --title "MrHandy Programs" --menu "Choose an option:" 15 40 3 \
    "New" "Create a new file" \
    "Open" "Open an existing file" \
    "Export" "Export a file" --stdout)

    case $choice in
        New)
            create_new_file
            ;;
        Open)
            open_file
            ;;
        Export)
            export_file
            ;;
        *)
            break
            ;;
    esac
done
