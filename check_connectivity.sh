# Set your gateway IP address here
GATEWAY_IP=$(ip route | grep default | awk '{print $3}')

NOW=$(date)

# Number of ping attempts
PING_ATTEMPTS=4

# Ping the gateway
ping -q -W 1 -c $PING_ATTEMPTS $GATEWAY_IP > /dev/null 2>&1

# Check the exit status of the ping command
if [ $? -ne 0 ]; then
    echo "$NOW Shutting down..."
    sudo shutdown -h now
else
    # echo "Gateway is reachable."
fi
