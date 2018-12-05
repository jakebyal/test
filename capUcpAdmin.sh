#!/bin/sh
printf "Bash script to configure Capacity Managment access to CentOS/RHEL servers"

printf "\nCurrent Date and Time: $(date)"

printf "\nValidate running user..."
u="$(whoami)"
printf "\n\tUser running script: $u"
if [ $u != 'root' ];
then
  printf "\n\tERROR: Run as root\n"
  exit
fi

printf "\nGranting SSH access..."
/bin/bash -c "/usr/sbin/realm permit -g capplanx"

printf "\n\nGranting sudo access..."
echo "#Ansible managed

#capacity team sudo access
Defaults:%capplanx,capplang,capmanp !requiretty
%capplanx,capplang,capmanp SERVERS=(ROOT) PASSWD:LOG_OUTPUT: FULL_SUDO" >> /etc/sudoers.d/cap_admin

printf "\n\nInstalling NMON...\n"
yum install -y nmon

printf "\n\nAdding capmanp passwordless SSH...\n"
mkhomedir_helper capmanp
sudo -u capmanp bash -c 'cd ~;
                         mkdir .ssh;
                         touch .ssh/authorized_keys;
                         echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAuYPHDxVgKPU49v83mLiHdjdxBOrYU026tBTUq5ZVNGWmaDK9GnIb/m/J5+eBdaq8njJTh1osaQ/XqbqBFqg7S7Cf7f9HKHBsYF8UTVdEbKMhp6gzTn/MjzMmjq/OLsJZ2PrMOFGEREsUBHygIJd8mwihEJtQyQzQ1G2ZoZlgfeT67I+oQ2VQKjGGPEqqOtSXGaiq4TDDoC8xCeFbJZgYSdxuLlyT+FL0Q2Us9H8bxJ8k+UGd1UI1/NR9o014y4DUQnS0+Mszt2XKmk2RvJEue3ffIVp5riVtRjvVkZHFiwJjVWCI+CUerQf+3RhZuESAomlGdbFsXqySvpHdVxbplw== capmanp@lxt-stna-000026" >> .ssh/authorized_keys;
                         chmod 700 ~/.ssh;
                         chmod 600 ~/.ssh/authorized_keys;'

printf "\n\nAdding capplang passwordless SSH...\n"
mkhomedir_helper capplang
sudo -u capplang bash -c 'cd ~;
                         mkdir .ssh;
                         touch .ssh/authorized_keys;
                         echo "ssh-dss AAAAB3NzaC1kc3MAAACBALC51/tDfwcekq0Nra5HbE9m+4aN4GfkAIo4ioJy2xce4cIkM3Fw6sESOGOlEsP+/oi0nE7IiMOqz85ZUQDBbECziYZv2WHVgZjedLfImMmF3N8GcVpBlsPw6ryscwAMWcCyZtfMLXYimKQ/45GmeTT0QZbcf3LOtKPa2buza06PAAAAFQD5T9cR4xaF5ww8mugTIA1YuMXxkwAAAIEAm3fBQbxfE1wj820X/ZqrSxMqIGchw3KX0R8eFhfw0oIghEHp5qZnMCGjtqTpgQvfkKign2+J6o6CXQnWziWl7QiXeovoP7VovIFueeOtD3auOvBbBVNb134Bv83618agPcz4mRZ0fm+S3RiGgvFfiB9YAnaOKOdPb/7cEaW8VD4AAACAcFdjStmuq5tdQQjznC3wNhVyNSOx9nOlYARwJoszEtA4F5LuUU/GxgvaaUXJhDoezz05L9N9X1W76UM73Qv/bGsDtyRocVpOeY+LpyplXoeVSnEhzKjFW5oyUcsBc72fjf2SpPP7SwuWgjPN5I4VoRcVeW2kY60tBywZk5+VVvo=" >> .ssh/authorized_keys;
                         echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA1kjh6adUousll0aTsvs92p0+ynDjcdfFOIHIZ+wxHv992DyHtBS9os2AT5YRXH58OetCQEuHZKojhFM9xBPs2JZqI+0HL4d1Nqw0BTAy+GqlFGSTlLB5z2ih7wtK59ROQxdG643tk+LskwRM/PWy5KLj1MOkwBz4yRv+pylx6HLls0Qq8dP0Z18SKgVaOoiyCYtG3G/2AQWO2eCQo5rCIRDLkZ+TPX19IOc1PoMXAJAnLxlKTCYK42lU7k6qd1iGuj+/jKEGZzmP00w+iKuKGREKjOWVB9bntSu+Qg0s1H6aOoicSDdTOrt3sP0K9izQti3908tRzFS11+iuc2uFxQ== capplang@lxt-stna-000026" >> .ssh/authorized_keys;
                         chmod 700 ~/.ssh;
                         chmod 600 ~/.ssh/authorized_keys;'

printf "\n"
exit
