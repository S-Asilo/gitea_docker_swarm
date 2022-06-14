# Εγκατάσταση 

## Για την δημιουργία σμήνους νεφοϋπολογιστικών υπηρεσιών (swarm)

1. Στον υπολογιστή που θέλουμε να είναι ο manager (Leader), τρέχουμε την εντολή docker swarm init --advertise-addr <MANAGER_IP>

2. Με την επιτυχή εκτέλεση θα δωθεί η εντολή που πρέπει να τρέξουμε για να μπουν στο swarm workers. Θα έχει τη μορφή:

```
docker swarm join --token SWMTKN-1-0i8yged6ipgi4m5yjv3rtfjoe9lnm7uxnf22yg60euhc99huor-2j55opz6pculciad4vj9fju8e <MANAGER_IP>:2377 
```
Αν για κάποιο λόγο δεν εμφανιστεί, τότε απλά τρέξτε την εντολή 

```
docker swarm join-token worker
```
Για να το εμφανίσει

3. Αν όλα έχουν εκτελέστεί επιτυχώς, τότε με την εντολή 
```
docker node ls
```
Μπορούμε να επαληθεύσουμε την επιτυχή δημιουργία του swarm



## Για την εγκατάσταση και την χρήση του gitea χρειάζονται τα ακόλουθα βήματα:

1. Εκτέλεση της εντολής make start (από manager node του docker swarm)

2. Άνοιγμα ενός browser στο http://<MANAGER_IP>:3000 όπου <MANAGER_IP> είναι δημόσιο το IP του manager node.

3. Στο πεδίο host της mysql, θα πρέπει να μπεί το IP του worker που κάνει host το gitea_db.

4. Επιλογή Συνέχεια.

5. (Προαιρετικό) Για τη ρύθμιση του ssh passthrough (δυνατότητα χρήσης ssh για την διαχείρηση των git repository),
εκτέλεση της εντολής make setup_ssh.

```
git clone https://gitea.cultab.xyz/cultab/gitea_docker_swarm
cd gitea_docker_swarm
make start
# open browser to http://<MANAGER_IP>:3000
```
	
# Πιθανά προβλήματα

Εμείς, στις δοκιμές μας αντιμετωπίσαμε προβλήματα με το firewall που είχαμε βάλει στην υπηρεσία okeanos.
Λυθήκανε ανοίγοντας τα παρακάτω port σύμφωνα με [το documentation του docker](https://docs.docker.com/engine/swarm/swarm-tutorial/).

```
sudo ufw allow 2377/tcp
sudo ufw allow 7946/tcp
sudo ufw allow 4789/udp
```

Επίσης αντιμετωπίσαμε πρόβλημα και με το VPN του ΠΑΔΑ καθώς δεν επέτρεπε στον worker να ανοίξει το port 3306.
