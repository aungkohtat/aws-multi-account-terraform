#!/bin/bash

echo "Starting AWS CLI removal process..."

# Remove the downloaded ZIP file
if [ -f awscliv2.zip ]; then
    rm awscliv2.zip
    echo "Removed awscliv2.zip"
else
    echo "awscliv2.zip not found"
fi

# Remove the unzipped AWS directory
if [ -d aws ]; then
    rm -rf aws
    echo "Removed aws directory"
else
    echo "aws directory not found"
fi

# Uninstall AWS CLI
if [ -d /usr/local/aws-cli ]; then
    sudo rm -rf /usr/local/aws-cli
    echo "Removed /usr/local/aws-cli"
else
    echo "/usr/local/aws-cli not found"
fi

if [ -f /usr/local/bin/aws ]; then
    sudo rm /usr/local/bin/aws
    echo "Removed /usr/local/bin/aws"
else
    echo "/usr/local/bin/aws not found"
fi

if [ -f /usr/local/bin/aws_completer ]; then
    sudo rm /usr/local/bin/aws_completer
    echo "Removed /usr/local/bin/aws_completer"
else
    echo "/usr/local/bin/aws_completer not found"
fi

# Remove boto3 if installed
if pip3 list | grep -F boto3 > /dev/null; then
    pip3 uninstall -y boto3
    echo "Uninstalled boto3"
else
    echo "boto3 not found"
fi

echo "AWS CLI removal process completed."
echo "Note: Please manually remove any AWS CLI related lines from your shell profile if you added any."