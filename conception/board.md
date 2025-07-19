# Board - Monimate V2

## 19 Juillet 2025 : configuration d'un 
-  Début : 17h45 - 21h55 (4 heures et 10 minutes)

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
La configuration d’un Dockerfile fonctionnel a été un véritable défi au départ. J’ai eu du mal à choisir la bonne image PHP, hésitant entre une image Alpine légère et d’autres variantes plus complètes. Initialement, j’ai essayé PHP 8.5, mais cela a provoqué des incompatibilités avec certains packages essentiels. J’ai donc dû revenir à PHP 8.4, plus stable dans mon contexte, et finalement j’ai opté pour l’image `php:8.4-fpm`. 

Je ne sais pas si c’est la meilleure configuration possible, mais pour l’instant cela fonctionne correctement.
