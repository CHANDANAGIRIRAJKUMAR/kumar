#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl enable apache2 -y
sudo systemctl start apache2 -y
