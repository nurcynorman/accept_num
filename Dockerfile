# Use a minimal base image like Alpine Linux
FROM alpine:latest

# Install bash (or use sh)
RUN apk add --no-cache bash

# Create the entrypoint script
RUN echo '#!/bin/bash\n\
# Function to reject alphabetic characters\n\
reject_alphabet() {\n\
    if [[ "$1" =~ [a-zA-Z] ]]; then\n\
        echo "SansAlpha: Unknown character detected"\n\
        exit 1\n\
    fi\n\
}\n\
\n\
# Continuously read input and reject if alphabetic\n\
while true; do\n\
    read -p "Input: " input\n\
    reject_alphabet "$input"\n\
done\n\
' > /usr/local/bin/entrypoint.sh

# Make the script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entry point to start the custom script
ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint.sh"]
