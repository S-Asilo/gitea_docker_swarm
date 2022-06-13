For english see [the english README](README_en.md)

Το gitea είναι μια ελαφριά υπηρεσία φιλοξενίας κώδικα γραμμένη σε Go που αναπτύσσεται και διαχειρίζεται από την κοινότητα.
Εκδίδεται κάτω από τους όρους του [MIT license](https://choosealicense.com/licenses/mit/).

Το gitea_docker_swarm παρέχει τα απαραίτητα αρχεία και οδηγίες
ώστε να τρέξει κάποιος τον git server [gitea](https://gitea.io/en-us/) σε [docker swarm](https://docs.docker.com/engine/swarm/)
(με την προϋπόθεση ότι υπάρχει ήδη ένα δίκτυο swarm).

## Ρύθμιση υπηρεσίας

Οι ρυθμίσεις του gitea βρίσκονται στο αρχείο
`./gitea/gitea/conf/app.ini`. 
Εδώ κάποιος θα δηλώσει το
base url, ssh url
και άλλες σημαντικές ρυθμίσεις.
Το αρχείο δημιουργείτε μετά την πρώτη εκκίνηση.
Οδηγίες για τις επιλογές υπάρχουν στο [documentation του gitea](https://docs.gitea.io/en-us/config-cheat-sheet/).

## Εκκίνηση Υπηρεσίας

Η υπηρεσία ξεκινάει με την εντολή `make start`.

## Παύση Υπηρεσίας

Η υπηρεσία σταματάει με την εντολή `make stop`.

## Ρύθμιση ssh container passthrough

Για τη ρύθμιση του ssh container passthrough εκτελέστε `make setup_ssh`.

Θα ζητηθούν δικαιώματα διαχειριστή ώστε να δημιουργηθεί ο χρήστης `git`.

## Αλλαγή default κωδικών, username και database host

```
cp DOTenv .env
edit .env
```

Στην γραμμή `GITEA__database__HOST` προσθέτουμε το
IP του δεύτερου node στο vpn.
