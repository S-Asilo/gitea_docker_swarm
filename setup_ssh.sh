#!/bin/sh

echo "Creating git user.."
# create user git with
sudo useradd -U --uid 1337 --groups docker --create-home git

echo "Generating ssh host key.."
# create key for git user
sudo -u git ssh-keygen -b 4096 -t rsa -f /home/git/.ssh/id_rsa -q -N "" -C "Gitea Host Key"

echo "Adding generated host key to /home/git/.ssh/authorized_keys.."
# edit authorized_keys
sudo -u git cat /home/git/.ssh/id_rsa.pub | sudo -u git tee -a /home/git/.ssh/authorized_keys
sudo -u git chmod 600 /home/git/.ssh/authorized_keys

echo "Creating docker-shell.."
# add docker login shell
cat <<"EOF" | sudo tee /home/git/docker-shell
#!/bin/sh
/usr/bin/docker exec -i -u git --env SSH_ORIGINAL_COMMAND="$SSH_ORIGINAL_COMMAND" gitea sh "$@"

EOF

echo "Setting docker-shell as git user's login shell.."
sudo chmod +x /home/git/docker-shell
sudo usermod -s /home/git/docker-shell git

echo "done!"
