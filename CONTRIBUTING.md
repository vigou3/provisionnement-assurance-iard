<!-- Emacs: -*- coding: utf-8; eval: (auto-fill-mode -1); eval: (visual-line-mode t) -*- -->

# Collaborer au projet *Provisionnement en assurance IARD*

> Seuls les étudiants de l'Université Laval inscrits au cours ACT-2008 disposent des droits en écriture requis pour effectuer la procédure décrite ci-dessous. Les autres personnes qui souhaitent contribuer au projet doivent effectuer une [demande de fusion](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html) dans le [dépôt GitLab](https://gitlab.com/vigou3/theorie-credibilite-avec-r).

La version de développement du projet [Provisionnement en assurance IARD](https://vigou3.gitlab.io/provisionnement-assurance-iard) est hébergée dans un [dépôt Git public](https://projets.fsg.ulaval.ca/git/scm/vg/provisionnement-assurance-iard-develop) de la Faculté des sciences et de génie de l'Université Laval. Le référentiel utilise [Atlassian BitBucket Server](https://www.atlassian.com/software/bitbucket/server).

La branche `master` du dépôt est réservée en écriture aux gestionnaires du projet.

Pour collaborer au projet, vous devez publier vos modifications dans une nouvelle branche et effectuer une demande de tirage (*pull request*) vers la branche `master` tel qu'expliqué ci-dessous.

1. Si  vous travaillez sur le code source pour la première fois, déplacez-vous avec la commande `cd` dans le répertoire dans lequel vous voulez enregistrer le code source du projet (le répertoire `provisionnement-assurance-iard-develop` sera créé automatiquement), clonez le dépôt et déplacez-vous ensuite dans le dossier du code source:

```
git clone https://projets.fsg.ulaval.ca/git/scm/vg/provisionnement-assurance-iard-develop.git
cd provisionnement-assurance-iard-develop
```

**OU**

1. Si vous avez déjà cloné le dépôt dans le passé et que vous voulez reprendre le travail sur le code source, déplacez-vous avec la commande `cd` dans le répertoire du code source, puis mettez à jour votre copie locale du dépôt depuis la branche `master`:

```
git checkout master
git pull
```

2. Créez une branche (locale) pour vos modifications:

```
git checkout -b <nom de branche>
```
	
3. Effectuez maintenant vos modifications. Il y a un fichier par chapitre et son nom, avec une extension `.tex` ou `.Rnw`, a un lien évident avec le titre du chapitre. Le code informatique de la section d'exemples d'un chapitre est intégré au texte du chapitre. Les solutions des exercices se trouvent avec le texte des exercices. Une fois les modifications terminées, publiez le fichier modifié dans votre dépôt local avec un commentaire utile sur la nature des modifications:
    
```
git status
git add <fichier>
git commit -m "<commentaire>"
```

4. Publiez ensuite la branche avec les modifications dans le dépôt BitBucket:

```
git push -u origin <nom de branche>
```
	
> À ce stade, Git vous demandera peut-être de vous authentifier. Utilisez votre IDUL et votre NIP. 

> Si vous éprouvez des problèmes d'authentification, vérifiez vos informations d'authentification dans le *gestionnaire de mots de passe* de votre système d'exploitation ([Gestionnaire d'identification](https://support.microsoft.com/fr-ca/help/4026814/windows-accessing-credential-manager) sous Windows; [Trousseaux d'accès](https://support.apple.com/fr-ca/guide/keychain-access/welcome/mac) sous macOS).

5. Finalement, connectez-vous à l'[interface graphique de BitBucket](https://projets.fsg.ulaval.ca/git/login) avec votre IDUL/NIP et faites une demande de tirage (*pull request*) vers la branche `master` en sélectionnant l'option correspondante dans la barre latérale.

6. Si vous avez d'autres modifications à proposer, reprenez la procédure depuis le début **en utilisant une branche différente**. Autrement, vos modifications seront combinées en une seule requête et il devient difficile de les sélectionner séparément.

7. Vérifiez l'état de votre demande de tirage dans l'interface graphique de BitBucket jusqu'à ce qu'un gestionnaire du projet ait rendu sa décision.

Pour des instructions plus détaillées, consultez les [excellents tutoriels](https://www.atlassian.com/git/tutorials) de Atlassian, en particulier celui sur le processus de collaboration [*Gitflow Workflow*](https://www.atlassian.com/git/tutorials/comparing-workflows#gitflow-workflow).

# Contributions fréquemment refusées

Les corrections mentionnées ci-dessous ont été refusées à répétition dans le passé. Elle ne peuvent donner droit à un point boni dans le cours ACT-2008 Mathématiques actuarielles IARD II.

- Le document est rédigé au moins en partie selon les règles de la [nouvelle orthographe](https://www.orthographe-recommandee.info), en particulier pour ce qui a trait à l'[accent circonflexe](https://www.orthographe-recommandee.info/regles4.htm). Alors «connait», «reconnait», «apparait» sont toutes des graphies correctes.

- Partout dans le document nous avons utilisé les [versions francisées](http://bdl.oqlf.gouv.qc.ca/bdl/gabarit_bdl.asp?t1=1&id=3168) des locutions latines *a priori* et *a posteriori* qui s'écrivent avec des accents. Donc: «à priori» et «à postériori».
