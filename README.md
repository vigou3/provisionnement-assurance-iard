<!-- Emacs: -*- coding: utf-8; eval: (auto-fill-mode -1); eval: (visual-line-mode t) -*- -->

# Provisionnement en assurance IARD

(description à venir)

## Auteurs

Vincent Goulet, École d'actuariat, Université Laval  
Frédérick Guillot, Recherche et innovation, Co-operators  
Mathieu Pigeon, Département de mathématiques, Université du Québec à Montréal

## Modèle de développement

Le processus de rédaction et de maintenance du projet se conforme au modèle [*Gitflow Workflow*](https://www.atlassian.com/git/tutorials/comparing-workflows#gitflow-workflow). Seule particularité: la branche *master* se trouve [sur GitLab]((https://gitlab.com/vigou3/provisionnement-assurance-iard)), alors que la branche de développement se trouve dans un [dépôt public](https://projets.fsg.ulaval.ca/git/scm/vg/provisionnement-assurance-iard-devel) de la Faculté des sciences et de génie de l'Université Laval.

Prière de passer par ce dépôt pour proposer des modifications; consulter le fichier `CONTRIBUTING.md` dans le dépôt pour la marche à suivre.

## Composition du document

La production du document repose sur la programmation lettrée avec LaTeX et
[Sweave](https://stat.ethz.ch/R-manual/R-devel/library/utils/doc/Sweave.pdf). La composition du document, c'est-à-dire la transformation du code source vers le format PDF, requiert les outils suivants.

### LaTeX

LaTeX est l'un des systèmes de mise en page les plus utilisés dans le monde, particulièrement dans la production de documents scientifiques intégrant de multiples équations mathématiques, des graphiques, du code informatique, etc.

La composition d'un document requiert d'abord une distribution du système LaTeX. Nous recommandons la distribution [TeX Live](https://tug.org/texlive) administrée par le [TeX Users Group](https://tug.org/). 

- [Vidéo expliquant l'installation sur Windows](https://youtu.be/7MfodhaghUk)
- [Vidéo expliquant l'installation sur macOS](https://youtu.be/kA53EQ3Q47w)

Ensuite, des connaissances de base sur le fonctionnement de LaTeX sont nécessaires. Consultez [*Rédaction avec LaTeX*](https://vigou3.gitlab.io/formation-latex-ul/), la formation LaTeX de l'Université Laval. 

>  *Rédaction avec LaTeX* est distribué avec TeX Live. 

Le moteur XeLaTeX est utilisé pour composer le document. 

### Polices de caractères

La compilation du document requiert les polices de caractères suivantes:

- [Lucida Bright OT, Lucida Math OT et Lucida Mono DK](https://tug.org/store/lucida/). Ces polices de très grande qualité sont payantes. La Bibliothèque de l'Université Laval détient une licence d'utilisation de cette police. Les étudiants et le personnel de l'Université peuvent s'en procurer une copie gratuitement en écrivant à [lucida@bibl.ulaval.ca](mailto:lucida@bibl.ulaval.ca?subject=Obtenir les polices Lucida).
- [Fira Sans](https://www.fontsquirrel.com/fonts/fira-sans) (les versions OpenType de Mozilla) en graisses *Book*, *Semi Bold*, *Book Italic* et *Semi Bold Italic*.
- [Font Awesome](http://fontawesome.io/). Cette police fournit une multitude d'icônes et de symboles. Téléchargez la [version 4.7.0](https://fontawesome.com/4.7.0 ) de la distribution et installez la police `fontawesome-webfont.ttf` du dossier `fonts`.

### Outils Unix additionnels (Windows)

La composition du document de référence est rendue plus facile par l'utilisation de l'outil Unix standard `make` qui n'est pas livré avec Windows. 

Il y a différentes manières d'installer des outils Unix sous Windows. Je recommande l'environnement de compilation [MSYS2](https://www.msys2.org/). (Vous devez savoir si vous disposez d'[une version 32 ou 64 bits de Windows](https://support.microsoft.com/fr-ca/help/15056/windows-7-32-64-bit-faq) et choisir la distribution de MSYS2 en conséquence.)

- [Télécharger MSYS2](https://www.msys2.org/) (Windows seulement)

Une fois l'installation de MSYS2 complétée (bien lire les instructions sur la page du projet), démarrez l'invite de commande MSYS et entrez

    pacman -S make

pour installer le paquetage contenant `make`.

### Outils Unix additionnels (macOS)

Les outils Unix de compilation ne sont pas livrés avec macOS, mais leur installation est très simple. Ils sont livrés avec XCode. Pour pouvoir les utiliser depuis la ligne de commande, il faut installer les *Command Line Tools*. Entrez simplement à l'invite de commande du Terminal

    xcode-select --install

puis suivez les instructions.

### Lancement de la composition

J'ai automatisé le processus de compilation avec l'outil Unix standard `make`. Le fichier `Makefile` fournit les recettes principales suivantes:

- `pdf` crée les fichiers `.tex` à partir des fichiers `.Rnw` avec Sweave et compile le document maître avec XeLaTeX;

- `zip` crée l'archive contenant le document et le code source des sections d'exemples;

- `release` crée une nouvelle version (*tag*) dans GitLab, téléverse le fichier `.zip` et modifie les liens de la page web.

Question d'éviter les publications accidentelles, `make all` est équivalent à `make pdf`.
