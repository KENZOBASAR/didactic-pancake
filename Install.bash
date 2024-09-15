#!/bin/bash

# Install dialog if not already installed
pacman -S dialog

# Show the initial radiolist menu
dialog --radiolist "Choose an option:" 15 50 4 \
  1 "Start Demo" off \
  2 "Install now" on \
  3 "Exit" off 2> /tmp/choice.txt

# Read the user's choice
choice=$(< /tmp/choice.txt)

if [ "$choice" -eq 2 ]; then
    # Confirm installation
    dialog --yesno "Do you want to install?" 7 60
    response=$?

    if [ $response -eq 0 ]; then
        # Show progress gauge
        {
            for i in {1..100}; do
                echo "$i"
                sleep 0.1  
            done
        } | dialog --gauge "Installing" 7 60 0

        # Input box for installation directory
        dialog --inputbox "Enter the installation directory:" 10 30 2> /tmp/dir.txt
        install_dir=$(< /tmp/dir.txt)

        # Country selection radiolist
        dialog --radiolist "Select your country:" 15 50 6 \
          1 "America" on \
          2 "Asia (Any country)" on \
          3 "India" on  \
          4 "Pakistan" on  \
          5 "Europe (Any country)" on  \
          6 "Other" on 2> /tmp/country.txt

        country=$(< /tmp/country.txt)

        dialog --msgbox "Installation completed in $install_dir for $country!" 7 60

    elsenceled
        dialog --msgbox "Installation canceled" 7 60
    fi
else
    dialog --msgbox "Exiting..." 7 60
fi

rm -f /tmp/choice.txt /tmp/dir.txt /tmp/country.txt
