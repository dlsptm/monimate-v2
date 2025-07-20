# Relevé de Données Brutes – Application de Gestion de Budget

## 1. Utilisateur (`User`)
- ID utilisateur
- Pseudo
- Email
- Mot de passe (hashé)
- Activation du compte (oui/non, défaut non)
- Role (défaut `user`)
- Date de création du compte
- Dernière connexion
- Langue / devise préférée
- Photo de profil

| Champ                | Type     | Détail                    |
|----------------------| -------- | ------------------------- |
| ID utilisateur       | UUID     | Clé primaire              |
| Pseudo               | String   | —                         |
| Email                | String   | Unique, validé            |
| Mot de passe         | String   | Hashé (bcrypt)  |
| Activation du compte | Boolean  | Par défaut `false`        |
| Rôle                 | Enum     | `user` (défaut), `admin` ? |
| Date de création     | DateTime | —                         |
| Dernière connexion   | DateTime | Null si jamais connecté   |
| Langue préférée      | String   | (ex : `fr`, `en`)         |
| Devise préférée      | String   | (ex : `EUR`, `USD`)       |
| Photo de profil      | URL      | Optionnelle               |


## 2. Compte Budgétaire (`Account`)
- ID compte
- Nom du compte (ex: "Compte personnel", "Famille Dupont", etc.)
- Type de compte (personnel / partagé)
- ID propriétaire (référence à `User`)
- Liste des membres (références à `User`)
- Slug du compte
- Date de création
- Date de modification 
- modification par (références à `User`)
- Créer par  (références à `User`)

| Champ                | Type                         | Détail                                                         |
| -------------------- | ---------------------------- |----------------------------------------------------------------|
| ID compte            | UUID                         | Clé primaire                                                   |
| Nom du compte        | String                       | Exemple : "Perso", "Famille Dupont"                            |
| Type de compte       | Enum                         | `personnel` / `partagé`                                        |
| Propriétaire         | Référence → `User`           | Créateur et admin du compte                                    |
| Membres              | Liste de références → `User` | Collaborateurs                                                 |
| Slug                 | String                       | Pour URLs propres (`compte-perso-x`) et éviter les UUID en URL |
| Date de création     | DateTime                     | —                                                              |
| Date de modification | DateTime                     | —                                                              |
| Modifié par          | Référence → `User`           | —                                                              |
| Créé par             | Référence → `User`           | (identique à propriétaire en général)                          |


## 3. Transactions (`Transaction`)
- ID transaction
- Montant
- Type (revenu / dépense)
- Titre de la transaction
- Description
- Date de transaction
- Répétition (oui/non, fréquence si oui)
- ID compte (référence à `Account`)
- ID Catégorie (référence à `Catégory`)
- Créé par (référence à `User`)

| Champ               | Type                   | Détail                          |
| ------------------- | ---------------------- | ------------------------------- |
| ID transaction      | UUID                   | —                               |
| Montant             | Decimal                | Positif ou négatif selon `type` |
| Type                | Enum                   | `revenu` / `dépense`            |
| Titre               | String                 | Court                           |
| Description         | Text                   | Optionnelle                     |
| Date de transaction | DateTime               | —                               |
| Répétition          | Boolean + fréquence    | `quotidien`, `mensuel`, etc.    |
| Compte associé      | Référence → `Account`  | —                               |
| Catégorie           | Référence → `Category` | —                               |
| Créé par            | Référence → `User`     | Historique                      |


## 4. Revenus (`Income`)
- ID revenu
- Montant
- Source (salaire, freelance, etc.)
- Date de réception
- Récurrent (oui/non)
- ID compte (référence à `Account`)
- Ajouté par (référence à `User`)

| Champ             | Type                  | Détail                                  |
| ----------------- | --------------------- | --------------------------------------- |
| ID revenu         | UUID                  | —                                       |
| Montant           | Decimal               | —                                       |
| Source            | String                | Exemple : "Salaire", "Projet freelance" |
| Date de réception | DateTime              | —                                       |
| Récurrent         | Boolean               | —                                       |
| Compte associé    | Référence → `Account` | —                                       |
| Ajouté par        | Référence → `User`    | —                                       |


## 5. Économies (`Saving`)
- ID économie
- Nom (ex: Épargne vacances)
- Montant total prévu
- Montant atteint
- Date de début
- Date d’objectif
- ID compte (référence à `Account`)

| Champ           | Type                  | Détail                     |
| --------------- | --------------------- | -------------------------- |
| ID économie     | UUID                  | —                          |
| Nom             | String                | Exemple : "Vacances été"   |
| Montant cible   | Decimal               | —                          |
| Montant actuel  | Decimal               | Mis à jour automatiquement |
| Date de début   | Date                  | —                          |
| Date d’objectif | Date                  | Deadline                   |
| Compte associé  | Référence → `Account` | —                          |


## 6. Objectifs Budgétaires (`Goal`)
- ID objectif
- Nom de l’objectif
- Type (réduction de dépense, augmentation de revenu, solde à atteindre)
- Montant cible
- Date de début
- Date d’échéance
- Statut (en cours / atteint / échoué)
- ID compte (référence à `Account`)

| Champ          | Type                  | Détail                               |
| -------------- | --------------------- | ------------------------------------ |
| ID objectif    | UUID                  | —                                    |
| Nom            | String                | —                                    |
| Type           | Enum                  | `réduction`, `augmentation`, `solde` |
| Montant cible  | Decimal               | —                                    |
| Date de début  | Date                  | —                                    |
| Échéance       | Date                  | —                                    |
| Statut         | Enum                  | `en cours`, `atteint`, `échoué`      |
| Compte associé | Référence → `Account` | —                                    |


## 7. Factures (`Invoice`)
- ID facture
- Nom de la facture
- Montant
- Fournisseur / Destinataire
- Statut (payée / en attente / en retard)
- Date d’échéance
- Fichier joint (pdf, image)
- ID compte (référence à `Account`)

| Champ          | Type                  | Détail                             |
| -------------- | --------------------- | ---------------------------------- |
| ID facture     | UUID                  | —                                  |
| Titre          | String                | Exemple : "EDF Avril"              |
| Montant        | Decimal               | —                                  |
| Fournisseur    | String                | Ou destinataire                    |
| Statut         | Enum                  | `payée`, `en attente`, `en retard` |
| Échéance       | Date                  | —                                  |
| Fichier joint  | URL / Blob            | PDF, image, etc.                   |
| Compte associé | Référence → `Account` | —                                  |



## 8. Categorie (`Category`)
- ID categorie
- Nom de la catégorie
- Icon de la catégorie

| Champ        | Type   | Détail                                          |
| ------------ | ------ | ----------------------------------------------- |
| ID catégorie | UUID   | —                                               |
| Nom          | String | Exemple : "Courses", "Logement"                 |
| Icône        | String | Nom de fichier ou référence (FontAwesome, etc.) |


## 9. Tableau de bord (`Dashboard`) - Données dynamiques
💡 Données calculées, non stockées.

- Solde actuel (revenus - dépenses)
- Total des dépenses ce mois
- Total des revenus ce mois
- Progrès des économies (%)
- Objectifs atteints / en cours
- Factures à venir / en retard

| Élément                       | Description                  |
| ----------------------------- | ---------------------------- |
| Solde actuel                  | Revenus - Dépenses du compte |
| Total des dépenses ce mois    | Agrégat                      |
| Total des revenus ce mois     | Agrégat                      |
| Progrès des économies (%)     | Ratio cumulé/objectif        |
| Objectifs atteints / en cours | Statistiques                 |
| Factures à venir / en retard  | Dates + statuts              |

---

## Relations principales
- Un utilisateur peut avoir plusieurs comptes.
- Un compte peut avoir plusieurs utilisateurs (si partagé).
- Un compte possède des transactions, revenus, économies, objectifs, et factures.
- Chaque action est traçable à un utilisateur (créateur/modificateur).

