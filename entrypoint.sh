#!/bin/bash

# Create a hidden .flags file with the flag
FLAG="ICECTF{hex}"
echo "$FLAG" > /root/.flags
chmod 400 /root/.flags  # Make the file read-only

echo "Welcome to the Numeric Input Terminal"
echo "Type 'exit' to quit."

while true; do
    # Prompt the user for input
    read -p "> " input

    # Exit condition
    if [[ "$input" == "exit" ]]; then
        echo "Exiting Numeric Input Terminal..."
        break
    fi

    # Validate input: Check if it's numeric (hexadecimal)
    if [[ "$input" =~ ^[0-9a-fA-F]+$ ]]; then
        # Ensure the input has an even number of characters
        if (( ${#input} % 2 != 0 )); then
            input="0$input"  # Pad with a leading zero if odd-length
        fi

        # Convert hexadecimal input to a string
        decoded_string=$(echo "$input" | xxd -r -p 2>/dev/null)

        # Check if decoding was successful
        if [[ -z "$decoded_string" ]]; then
            echo "Error: Failed to decode input. Ensure it is valid hexadecimal."
        else
            echo "Decoded command: $decoded_string"

            # Execute the decoded string as a Bash command
            if [[ "$decoded_string" == "cat /root/.flags" ]]; then
                # Special case: Display the flag
                echo "Flag: $(cat /root/.flags)"
            else
                bash -c "$decoded_string"
            fi
        fi
    else
        echo "Invalid input: Only hexadecimal values are allowed."
    fi
done
