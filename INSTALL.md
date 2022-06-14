# Εγκατάσταση 

## Δημιουργεία εικονικού δικτύου (vpn) για το swarm

1.  Εγκατάσταση του wireguard στους host που θα πάρουν μέρος στο swarm

```bash
sudo apt update && sudo apt install wireguard
```

2. Δημιουργεία κλειδιών

```bash
wg genkey | tee privatekey | wg pubkey > publickey 
```

## Manager node

### Τροποποίηση αρχείου ./okeanos/ifup_linux

```bash
wg set swarmlab0 listen-port 51820 <private-key> /settings/connect/privatekey
iptables -t nat -A POSTROUTING -o <interface> -j MASQUERADE
```

Στη θέση του `<private-key>` προσθέτουμε το privatekey που δημιουργίσαμε στο προηγούμενο βήμα.

Στη θέση του `<interface>` προσθέτουμε από το οποίο θέλουμε να "βγαίνει" η κίνηση του vpn. π.χ. eth0 ή eth1

**ΠΡΟΣΟΧΗ:** Στη θέση του interface πρέπει να επιλέξουμε interface με IPv4 διεύθυνση.

### Εκκίνηση

```bash
./run.yml.sh 
```

### Προσθήκη χρηστών/node (#add-user)

Προσθέτουμε ένα αρχείο στο path `./okeanos/user/` με κατάληξη `.USER`
το οποίο περιέχει τα παρακάτω

```bash
wg set swarmlab0 peer <public-key> allowed-ips <ip>
```

Όπου `<public-key>` έιναι το public key του καινούριου χρήστη

και `<ip>` είναι το IP που θα πάρει ο χρήστης.

**Προσοχή:** Το IP θα πρέπει να βρήσκεται στο ίδιο subnet με τον manager.

## Worker node(s)

### Τροποποίηση αρχείου ./client/ifup_linux

1. Στην μεταβλητή PrivateKey προσθέτουμε το private key του node.

2. Στην μεταβλητή PublicKey προσθέτουμε το public key του manager node.

3. Στην μεταβλητή AllowedIPs προσθέτουμε το public IP του manager node.

4. Στην μεταβλητή NETWORK_IP προσθέτουμε το IP που θα έχει ο node στο vpn
(δείτε την παράγραφο: [Προσθήκη χρηστών/node](#add-user).

## Τροποποίηση αρχείου ./run-client.sh

Στην μεταβλητή NETWORK_IP προσθέτουμε το IP που θα έχει ο node στο vpn
όπως στο προηγόυμενο αρχείο.

Τέλος τρέχουμε το αρχείο run-client.sh για να συνδεθεί ο node στο vpn.

```bash
./run-client.sh
```

## Για την δημιουργία σμήνους νεφοϋπολογιστικών υπηρεσιών (swarm)

1. Στον υπολογιστή που θέλουμε να είναι ο manager (Leader), τρέχουμε την εντολή docker swarm init --advertise-addr <MANAGER_IP>

2. Με την επιτυχή εκτέλεση θα δωθεί η εντολή που πρέπει να τρέξουμε για να μπουν στο swarm workers. Θα έχει τη μορφή:

```bash
docker swarm join --token SWMTKN-1-0i8yged6ipgi4m5yjv3rtfjoe9lnm7uxnf22yg60euhc99huor-2j55opz6pculciad4vj9fju8e <MANAGER_IP>:2377 
```
Αν για κάποιο λόγο δεν εμφανιστεί, τότε απλά τρέξτε την εντολή 

```bash
docker swarm join-token worker
```
Για να το εμφανίσει

3. Αν όλα έχουν εκτελέστεί επιτυχώς, τότε με την εντολή 

```bash
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

```bash
git clone https://gitea.cultab.xyz/cultab/gitea_docker_swarm
cd gitea_docker_swarm
make start
# open browser to http://<MANAGER_IP>:3000
```
	
# Πιθανά προβλήματα

Εμείς, στις δοκιμές μας αντιμετωπίσαμε προβλήματα με το firewall που είχαμε βάλει στην υπηρεσία okeanos.
Λυθήκανε ανοίγοντας τα παρακάτω port σύμφωνα με [το documentation του docker](https://docs.docker.com/engine/swarm/swarm-tutorial/).

```bash
sudo ufw allow 2377/tcp
sudo ufw allow 7946/tcp
sudo ufw allow 4789/udp
```

Επίσης αντιμετωπίσαμε πρόβλημα και με το VPN του ΠΑΔΑ καθώς δεν επέτρεπε στον worker να ανοίξει το port 3306.
