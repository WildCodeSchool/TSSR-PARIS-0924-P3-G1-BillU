

1. Analyse des effectifs

Répartition interne de BillU

|Département|Effectifs|
|---|---|
|Communication et Relations publiques|16|
|Département Juridique|6|
|Développement logiciel|89|
|Direction|3|
|DSI|18|
|Finance et Comptabilité|8|
|QHSE|4|
|Service Commercial|15|
|Service recrutement|3|
|**Total pour BillU**|**162**|

Personnel externe

|Société|Département|Effectifs|
|---|---|---|
|2Face|Développement logiciel|5|
|I-magyne|Communication et Relations publiques|1|
|Livingston & Associés|Département Juridique|4|
|Studio Dlight|Communication et Relations publiques|1|
|**Total externe**||**11**|

Effectif global à prendre en charge : 173 utilisateurs

2. Plan d’adressage IP

L'entreprise se trouve dans le réseau 172.19.0.0/16.
L’ensemble du réseau est organisé en sous-réseaux (VLANs) pour chaque département/service et les personnels externes. 
L’adressage est divisé comme suit :

| Département               | Effectifs | VLAN ID | Sous-réseau        | CIDR | Première adresse utilisable | Dernière adresse utilisable | Adresse de broadcast | Adresses disponibles | Adresses utilisables |
|---------------------------|-----------|---------|--------------------|------|----------------------------|----------------------------|----------------------|----------------------|----------------------|
| Serveurs internes          | 10        | 1       | 172.19.1.0/24      | /24  | 172.19.1.2                | 172.19.1.254              | 172.19.1.255         | 256                  | 254                  |
| Communication et RP        | 16        | 10      | 172.19.10.0/24     | /24  | 172.19.10.1               | 172.19.10.254             | 172.19.10.255        | 256                  | 254                  |
| Département juridique      | 6         | 20      | 172.19.20.0/24     | /24  | 172.19.20.1               | 172.19.20.254             | 172.19.20.255        | 256                  | 254                  |
| Développement logiciel     | 89        | 30      | 172.19.30.0/24     | /24  | 172.19.30.1               | 172.19.30.254             | 172.19.30.255        | 256                  | 254                  |
| Direction                  | 3         | 40      | 172.19.40.0/24     | /24  | 172.19.40.1               | 172.19.40.254             | 172.19.40.255        | 256                  | 254                  |
| DSI                        | 18        | 50      | 172.19.50.0/24     | /24  | 172.19.50.1               | 172.19.50.254             | 172.19.50.255        | 256                  | 254                  |
| Finance et Comptabilité    | 8         | 60      | 172.19.60.0/24     | /24  | 172.19.60.1               | 172.19.60.254             | 172.19.60.255        | 256                  | 254                  |
| QHSE                       | 4         | 70      | 172.19.70.0/24     | /24  | 172.19.70.1               | 172.19.70.254             | 172.19.70.255        | 256                  | 254                  |
| Service Commercial         | 15        | 80      | 172.19.80.0/24     | /24  | 172.19.80.1               | 172.19.80.254             | 172.19.80.255        | 256                  | 254                  |
| Service Recrutement        | 3         | 90      | 172.19.90.0/24     | /24  | 172.19.90.1               | 172.19.90.254             | 172.19.90.255        | 256                  | 254                  |
| Invités/externes           | 11        | 100     | 172.19.100.0/24    | /24  | 172.19.100.1              | 172.19.100.254            | 172.19.100.255       | 256                  | 254                  |



3. Liste du matériel et un schéma réseau de l'infrastructure





4. Convention de nommage



