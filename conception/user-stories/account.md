# User stories relatives aux comptes

## Création d'un compte personnel
En tant que nouvel utilisateur, je veux créer un compte avec un mail, un nom d’utilisateur, un mot de passe, un rôle et une date de création, afin de pouvoir accéder à l’application avec un profil personnel.

Critères d'acceptation :

- [ ] Tant que l'utilisateur n'est pas connecté, il n’aura pas le droit d’accéder à l’ensemble du site : role (Le rôle `user` est attribué automatiquement lors de l’inscription)
- [ ] L'utilisateur devra accéder à un lien `S'inscrire`qui le redirigera au formulaire d'enregistrement.
- [ ] L'utilisateur doit remplir un formulaire de création de compte et le valider grâce à un bouton.
- [ ] L'utilisateur devra renseigner son email, son nom d'utilisateur et son mot de passe.
- [ ] L'email de l'utilisateur doit être **valide** et **unique** dans le système.
- [ ] Un nom d’utilisateur devra contenir plus de trois caractères alphanumériques. Les noms composés peuvent inclure un tiret (-) via une expression régulière.
- [ ] Si le nom d'utilisateur a moins de 3 caractères ou contient des signes spéciaux, le message d'erreur `Le nom d'utilisateur ne doit contenir que des caractères alphanumériques et doit contenir plus de 3 caractères` s'affichera.
- [ ] Le mot de passe de l'utilisateur doit respecter des critères de sécurité au moins huit caractères, une majuscule, un chiffre, et un caractère spécial.
- [ ] Si le mot de passe ne respecte pas les mesures de sécurité `le mot de passe doit contenir 8 caractères dont au minimum une lettre majuscule, un chiffre et un caractère spécial`.
- [ ] L'utilisateur doit confirmer son mot de passe dans un champ supplémentaire. En cas de non-correspondance, un message d'erreur `Les mots de passe ne correspondent pas.` s'affichera.
- [ ] Si l'email de l'utilisateur est déjà utilisé, le message d'erreur `Ce mail est déjà utilisé par un autre utilisateur.` s'affichera.
- [ ] Un message de confirmation de création de compte est affiché après soumission réussie du formulaire.
- [ ] Une fois enregistré, l'utilisateur est invité à valider par mail son compte et est redirigé vers la page de connexion avec le message `Veuillez vous connecter une fois avoir validé votre compte (vérifiez vos mails)`.
- [ ] Limiter le nombre de tentatives de création de compte par IP pour limiter les abus/bots.
- [ ] Un captcha est affiché pour empêcher la création automatisée de comptes par des bots.

___

## Authentification
En tant qu'utilisateur non authentifié, je fournis mon e-mail et mon mot de passe, pour me connecter afin d’avoir accès à l’application avec un profil personnel.

Critères d'acceptation :

- [ ] L'utilisateur accède au formulaire de connexion via un lien `Se connecter`
- [ ] L'utilisateur doit renseigner son identifiant unique (email, nom d'utilisateur) et un mot de passe.
- [ ] Le mot de passe est hashé en base de données pour sécuriser mon application.
- [ ] Quand le formulaire est soumis, l'application vérifie la validité du mot de passe et de l'identifiant.
- [ ] Si l'identifiant ou le mot de passe est incorrect, un message d'erreur est affiché. ` L'email et/ou le mot de passe est erroné.`
- [ ] L'utilisateur connecté est accueilli par un message de bienvenue (“Salut, X”) et accède à l'ensemble des fonctionnalités de l'application qui lui sont propres.
- [ ] Limiter le nombre de tentatives de connexion par IP pour limiter les attaques par force brute.
- [ ] Si l'utilisateur n'a pas validé son email, le message `Veuillez valider votre adresse email avant de vous connecter. s'affichera.
- [ ] L'utilisateur peut cocher une case `Se souvenir de moi` pour rester connecté pendant X jours.

___

## Création d'un compte partagé
En tant qu'utilisateur connecté, je veux pouvoir créer un compte partagé avec un ou plusieurs utilisateurs en fournissant leur email et un nom de compte, afin de gérer un budget commun de manière collaborative.

Critères d'acceptation :

- [ ] L'utilisateur accède à une interface de création de compte partagé via un bouton `Ajouter un compte`.
- [ ] L'utilisateur fournit un ou plusieurs emails et un titre de compte.
- [ ] Si l’email appartient à un utilisateur déjà inscrit, celui-ci reçoit un email d’invitation avec un lien pour accepter ou refuser l’invitation (valable X jours).
- [ ] Si l’email n’appartient pas encore à un utilisateur, une invitation à créer un compte personnel + rejoindre le compte partagé lui est envoyée.
- [ ] Une fois l’invitation acceptée, le nouvel utilisateur rejoint le compte partagé avec un rôle collaborateur.
- [ ] Le créateur du compte partagé devient le propriétaire par défaut.
- [ ] L'administrateur du compte partagé peut consulter l'état des invitations envoyées (en attente, acceptées, expirées).
- [ ] Le propriétaire peut révoquer une invitation envoyée tant qu’elle n’a pas été acceptée.
- [ ] Le collaborateur a accès à toutes les fonctionnalités du compte partagé sauf la suppression du compte ou des membres.

___

## Modification du profil

En tant qu'utilisateur connecté, j'ai la possibilité de changer mes informations personnelles.

### Critères d'acceptation :

- [ ] L'utilisateur accède à une interface de modification via un bouton `Modifier mes informations personnelles` depuis son profil.
- [ ] L'utilisateur peut modifier son email, son nom d'utilisateur et/ou son mot de passe.
- [ ] L'email modifié doit être **valide** et **unique** dans le système.
- [ ] Le nom d'utilisateur doit contenir **au minimum TROIS caractères alphanumériques**. Les noms composés peuvent contenir un tiret (`-`).
- [ ] Si le nom d'utilisateur est invalide, un message d'erreur s'affiche : `Le nom d'utilisateur ne doit contenir que des caractères alphanumériques et doit contenir plus de 3 caractères.`
- [ ] Le nouveau mot de passe doit respecter les règles de sécurité : **au moins huit caractères**, dont **une lettre majuscule**, **un chiffre**, et **un caractère spécial**.
- [ ] Si le mot de passe ne respecte pas ces critères, le message d'erreur suivant s'affiche : `Le mot de passe doit contenir 8 caractères dont au minimum une lettre majuscule, un chiffre et un caractère spécial.`
- [ ] L'utilisateur doit confirmer le mot de passe dans un champ de confirmation. En cas de non-correspondance, un message d'erreur s'affiche : `Les mots de passe ne correspondent pas.`
- [ ] Si l'email saisi est déjà utilisé par un autre utilisateur, le message d'erreur suivant s'affiche : `Ce mail est déjà utilisé par un autre utilisateur.`
- [ ] Une fois les modifications enregistrées, un message de confirmation s'affiche : `Vos informations personnelles ont bien été mises à jour.`
- [ ] Si l'utilisateur modifie son adresse email, il est automatiquement déconnecté et doit valider à nouveau son compte via un lien envoyé à sa nouvelle adresse email.
- [ ] Lorsqu'une modification critique (email ou mot de passe) est effectuée, notifier l'utilisateur par email de sécurité. `Un changement de mot de passe a été effectué pour votre compte. Si ce n'était pas vous, veuillez contacter le support immédiatement`
___

## Mot de passe oublié

En tant qu'utilisateur enregistré mais non connecté, je veux pouvoir réinitialiser mon mot de passe de manière sécurisée si je l'ai oublié, afin de pouvoir accéder à nouveau à mon compte.

### Critères d'acceptation :

- [ ] L'utilisateur accède à l’interface de réinitialisation via un lien `Mot de passe oublié ?` présent sur la page de connexion.
- [ ] L'utilisateur saisit son adresse e-mail dans le formulaire prévu à cet effet.
- [ ] Si l’email saisi n’existe pas dans le système, un message d’erreur s’affiche : `L'email fourni n'existe pas. Veuillez créer un compte ou fournir un email valide.`
- [ ] Si l’email est reconnu, un email est envoyé contenant un lien unique et sécurisé pour réinitialiser le mot de passe (valable pendant X minutes/heures).
- [ ] Si l’utilisateur tente d’utiliser un lien expiré ou déjà utilisé, un message s’affiche : `Ce lien est expiré ou a déjà été utilisé. Veuillez recommencer la procédure.`
- [ ] L’utilisateur peut demander un renvoi du mail de validation en cas de non-réception.
- [ ] Le lien redirige vers un formulaire de réinitialisation de mot de passe.
- [ ] L'utilisateur saisit un nouveau mot de passe et confirme ce mot de passe dans un champ dédié.
- [ ] Le nouveau mot de passe doit respecter les règles de sécurité : **au moins huit caractères**, dont **une lettre majuscule**, **un chiffre**, et **un caractère spécial**.
- [ ] Si le mot de passe ne respecte pas ces critères, un message s’affiche : `Le mot de passe doit contenir 8 caractères dont au minimum une lettre majuscule, un chiffre et un caractère spécial.`
- [ ] Si les mots de passe ne correspondent pas, un message d’erreur s’affiche : `Les mots de passe ne correspondent pas.`
- [ ] Une fois le mot de passe modifié avec succès, l'utilisateur est redirigé vers la page de connexion avec un message de confirmation : `Votre mot de passe a été modifié avec succès. Veuillez vous reconnecter.`

