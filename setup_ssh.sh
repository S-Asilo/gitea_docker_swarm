#!/bin/sh

# create user git with
sudo useradd -U --uid 1337 --groups docker --create-home git

# create key for git user
sudo -u git ssh-keygen -b 4096 -t rsa -f /home/git/.ssh/id_rsa -q -N "" -C "Gitea Host Key"

# edit authorized_keys
sudo -u git cat /home/git/.ssh/id_rsa.pub | sudo -u git tee -a /home/git/.ssh/authorized_keys
sudo -u git chmod 600 /home/git/.ssh/authorized_keys

# add docker login shell
cat <<"EOF" | sudo tee /home/git/docker-shell
#!/bin/sh
/usr/bin/docker exec -i -u git --env SSH_ORIGINAL_COMMAND="$SSH_ORIGINAL_COMMAND" gitea sh "$@"

EOF

sudo chmod +x /home/git/docker-shell
sudo usermod -s /home/git/docker-shell git
