#!/system/bin/sh

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'  # No Color

# File to store toggle states
TOGGLE_FILE="/sdcard/toggle_state.txt"

# Function to initialize toggle states
init_toggle_states() {
    if [ ! -f "$TOGGLE_FILE" ]; then
        touch "$TOGGLE_FILE"
        echo "ISLAND_ON=false" >> "$TOGGLE_FILE"
        echo "PROGRAM_B_ON=false" >> "$TOGGLE_FILE"
    fi
    source "$TOGGLE_FILE"
}

# Function to save toggle states
save_toggle_states() {
    echo "ISLAND_ON=$ISLAND_ON" > "$TOGGLE_FILE"
    echo "PROGRAM_B_ON=$PROGRAM_B_ON" >> "$TOGGLE_FILE"
}

# Function to display the submenu
display_submenu() {
    echo -e "${CYAN}Submenu:${NC}"
    echo -e "${YELLOW}1. Suboption 1${NC}"
    echo -e "${YELLOW}2. Suboption 2${NC}"
    echo -e "${YELLOW}3. Suboption 3${NC}"
    echo -e "${YELLOW}4. Suboption 4${NC}"
    echo -e "${YELLOW}5. Suboption 5${NC}"
    echo -e "${YELLOW}6. Suboption 6${NC}"
    echo -e "${YELLOW}7. Suboption 7${NC}"
    echo -e "${YELLOW}8. Suboption 8${NC}"
    echo -e "${YELLOW}9. Suboption 9${NC}"
    echo -e "${YELLOW}10. Suboption 10${NC}"
    echo -e "${YELLOW}11. Back${NC}"
}

# Main script
init_toggle_states

while true; do
    # Display the main menu
    echo -e "${BLUE}Select an option:${NC}"
    if [ "$ISLAND_ON" = true ]; then
        echo -e "${YELLOW}1. ISLAND BYPASS (Status: ${GREEN}ON${YELLOW})${NC}"
    else
        echo -e "${YELLOW}1. ISLAND BYPASS (Status: ${RED}OFF${YELLOW})${NC}"
    fi
    if [ "$PROGRAM_B_ON" = true ]; then
        echo -e "${YELLOW}2. OBB MODIFICATION (STEPS: ${GREEN}1${YELLOW})${NC}"
    else
        echo -e "${YELLOW}2. OBB MODIFICATION (STEPS: ${RED}2${YELLOW})${NC}"
    fi
    echo -e "${YELLOW}3. CONFIGS APPLY${NC}"
    echo -e "${YELLOW}4. LOGS CLEANER${NC}"
    echo -e "${YELLOW}5. CREATE FOLDER 1TIME${NC}"
    echo -e "${YELLOW}6. Exit${NC}"

    echo -n -e "${CYAN}Enter your choice: ${NC}"
    read choice

    case $choice in
        1)
            if [ "$ISLAND_ON" = true ]; then
                ISLAND_ON=false
                echo -e "${RED}ISLAND BYPASS OFF.${NC}"
                sh /sdcard/BABAMODZ/SH_FILE/OFF.sh
            else
                ISLAND_ON=true
                echo -e "${GREEN}ISLAND BYPASS ON.${NC}"
                sh /sdcard/BABAMODZ/SH_FILE/ON.sh
            fi
            save_toggle_states
            ;;
        2)
            if [ "$PROGRAM_B_ON" = true ]; then
                PROGRAM_B_ON=false
                echo -e "${RED} ACTIVATION.${NC}"
                sh /sdcard/BABAMODZ/SH_FILE/MOD.sh
            else
                PROGRAM_B_ON=true
                echo -e "${GREEN}MODDED OBB.${NC}"
                sh /sdcard/BABAMODZ/SH_FILE/MOD.sh
            fi
            save_toggle_states
            ;;
        3)
            echo -e "${GREEN}Applying Configuration...${NC}"

            # Display the submenu after applying configuration
            while true; do
                display_submenu
                echo -n -e "${CYAN}Enter your choice: ${NC}"
                read subchoice

                case $subchoice in
                    1)
                        echo "You selected Suboption 1"
                        # Add your code for Suboption 1 here
                        ;;
                    2)
                        echo "You selected Suboption 2"
                        # Add your code for Suboption 2 here
                        ;;
                    3)
                        echo "You selected Suboption 3"
                        # Add your code for Suboption 3 here
                        ;;
                    4)
                        echo "You selected Suboption 4"
                        # Add your code for Suboption 4 here
                        ;;
                    5)
                        echo "You selected Suboption 5"
                        # Add your code for Suboption 5 here
                        ;;
                    6)
                        echo "You selected Suboption 6"
                        # Add your code for Suboption 6 here
                        ;;
                    7)
                        echo "You selected Suboption 7"
                        # Add your code for Suboption 7 here
                        ;;
                    8)
                        echo "You selected Suboption 8"
                        # Add your code for Suboption 8 here
                        ;;
                    9)
                        echo "You selected Suboption 9"
                        # Add your code for Suboption 9 here
                        ;;
                    10)
                        echo "You selected Suboption 10"
                        # Add your code for Suboption 10 here
                        ;;
                    11)
                        break ;;
                    *)
                        echo -e "${RED}Invalid option. Please select a valid option.${NC}"
                        ;;
                esac
            done
            ;;
        4)
            echo -e "${GREEN}Cleaning Logs...${NC}"
            sh /sdcard/BABAMODZ/SH_FILE/LOGS.sh
            ;;
        5)
            echo -e "${GREEN}Creating Folder and Copying Files...${NC}"
            ls /storage/emulated/0/Android/data/com.pubg.imobile/files/UE4Game/ShadowTrackerExtra/ShadowTrackerExtra/Saved/Paks/game_patch_3.1.0.185[0-9][0-9].pak | xargs -n 1 basename > /storage/emulated/0/BABAMODZ/file_names.txt
            source_directory="/storage/emulated/0/BABAMODZ/"
            destination_directory="/storage/emulated/0/BABAMODZ/FILEPAK/"
            while IFS= read -r file_name; do
                mkdir -p "$destination_directory/$file_name"
            done < "$source_directory/file_names.txt"
            Paks="/storage/emulated/0/Android/data/com.pubg.imobile/files/UE4Game/ShadowTrackerExtra/ShadowTrackerExtra/Saved/Paks/"
            cd "$Paks" && sleep 2 && cp game_patch_3.1.0.185[0-9][0-9].pak /storage/emulated/0/BABAMODZ/OGPAK/ && echo -e "${GREEN}Successful ✅${NC}" || echo -e "${RED}Error: Copying files failed.${NC}"
            ;;
        6)
            echo -e "${RED}Exiting...${NC}"; break
            ;;
        *)
            echo -e "${RED}Invalid option. Please select a valid option.${NC}"
            ;;
    esac
done