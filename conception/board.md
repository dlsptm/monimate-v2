# Board - Monimate V2

## 19 Juillet 2025 : configuration du projet
-  Début : 17h45 - 21h55 (**4 heures et 10 minutes**)

### Création des dépôts Git

- [GitHub](https://github.com/dlsptm/monimate-v2)
- [GitLab](https://gitlab.com/dlsptm/monimate-new-version)


### Choix du framework

- Utilisation de **Symfony 7** en mode **webapp**  
  Bénéfices : dernières fonctionnalités, meilleures performances.


### Packages et outils intégrés

- **PHP-CS-Fixer**  
  Formate automatiquement le code PHP selon les standards (PSR-12) pour garantir un code propre et cohérent.

- **PHPStan**  
  Analyse statique du code PHP pour détecter erreurs et incohérences sans exécuter le code.

- **Webpack Encore**  
  Simplifie la gestion des assets frontend (JS, CSS, images), compilation et optimisation via Webpack.

- **Bootstrap**  
  Framework CSS pour créer rapidement des interfaces responsives et modernes.

- **Sass**  
  Préprocesseur CSS avec fonctionnalités

### Infrastructure et automatisation

- **Makefile**  
  Ajouté pour automatiser les tâches courantes et faciliter le développement.

- **Docker**  
  Première version du `Dockerfile` et du `docker-compose.yml`
    - Image non optimisée
    - Pas encore de configuration réseau spécifique

- **CI/CD GitLab**  
  Pipeline généré automatiquement par Gitlab.


### Ressenti

La configuration d’un Dockerfile fonctionnel a été un véritable défi au départ. J’ai eu du mal à choisir la bonne image PHP, hésitant entre une image Alpine légère et d’autres variantes plus complètes. Initialement, j’ai essayé PHP 8.5, mais cela a provoqué des incompatibilités avec certains packages essentiels. J’ai donc dû revenir à PHP 8.4, plus stable dans mon contexte, et finalement j’ai opté pour l’image `php:8.4-fpm`. 

Je ne sais pas si c’est la meilleure configuration possible, mais pour l’instant cela fonctionne correctement.

___

## 20 Juillet 2025 : base de données, mailer, authentification
Début : 11h15 – 12h45 (1 heure 30) / 13h45 – 17h50 (4 heures 5 minutes)
Total : 5 heures 35 minutes

### Changement de base de données
- Passage de MySQL à PostgreSQL pour bénéficier d’une meilleure conformité SQL et d'une gestion plus robuste des données.
- Configuration d’une image PostgreSQL dans Docker, mappée sur le port 5494 de la machine locale.
- Ajout de commandes liées à la base de données dans le Makefile (création, migration, reset, etc.).

### User stories
- Création des User Stories principales (avec critères d’acceptation) :
  - Création d’un compte personnel 
  - Authentification 
  - Création d’un compte partagé
  - Modification des informations personnelles 
  - Réinitialisation de mot de passe (mot de passe oublié)

### Début de la mise en place des maquettes et wireframes
- Page principale
- Page d’authentification
- Page d’enregistrement

### Packages et outils intégrés
- **symfony/uid**  
  Pour la génération d'identifiants uniques et sûrs (UUID).
- **symfonycasts/verify-email-bundle**  
  Pour gérer la vérification d’email après l’enregistrement d’un utilisateur.

### Sécurité & authentification
- Ajout de la table User avec les premiers champs nécessaires. 
- Mise en place de la connexion et de la création de compte (enregistrement). 
- Authentification classique opérationnelle (email + mot de passe). 
- Prévision d’un ajout futur de l’authentification Google (OAuth via Google Login).

### Simplon
- Création d’un groupe de travail avec Nicolas et Renaud pour faciliter les retours et les échanges.
- Partage du lien du projet GitLab pour centraliser le développement.

### Ressenti :
Aucune difficulté particulière rencontrée aujourd’hui.
Les choses se sont enchaînées naturellement, même si certaines étapes prennent du temps (surtout la rédaction des user stories et la configuration fine de l’authentification).
C’est long, mais le projet commence à bien prendre forme 😊


### Next
- [ ] Créer un Trello
- [ ] OAuth via Google Login et  Apple Login

---

## 13 Août 2025
**16h – 20h** (4 heures)

### OAuth via Google Login
- Intégration de l'authentification Google avec les packages suivants :

```json
"knpuniversity/oauth2-client-bundle": "^2.18",
"league/oauth2-google": "^4.0"
```
  
- Configuration des fichiers :  
  - `knpu_oauth2_client.yaml`  
  - `security.yaml`  
- Création du `GoogleAuthenticator` et du `GoogleController` pour gérer l'authentification.  

### Diagramme et architecture
- Réalisation d’un diagramme de classes représentant l’authentification classique et via Google, ainsi que l’enregistrement des utilisateurs.  

### Gestion du projet
- Création du [Trello](https://trello.com/b/h5Jq6vzv/monimate) pour organiser les tâches et le suivi du projet.  

### Front-end / SCSS
- Début de la mise en place des styles SCSS.  

### Next
- Continuer la mise en place du front (SCSS).  
- Ajouter Apple Login pour l’authentification OAuth.
