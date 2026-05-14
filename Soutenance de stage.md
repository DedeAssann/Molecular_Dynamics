# Introduction
## Présentation du stage, de la dynamique moléculaire classique en tant que méthode de simulation numérique de système à multi-corps
L’augmentation de la puissance de calculs des ordinateurs contribue à l’émergence de simulations numériques à l’échelle de l’atome permettant de décrire des processus physico-chimiques complexes et de calculer de nombreuses propriétés de la matière. La plus simple de ces méthodes est la dynamique moléculaire classique, qui se base sur l'intégration des équations de mouvement dérivées de la loi de Newton appliquées à des atomes considérés comme des sphères dures, soumises à une force dérivant d’un potentiel d’interaction interatomique plus ou moins complexe. Elle permet de suivre avec précision la dynamique du système et donne ainsi accès à des informations sur des propriétés physiques et/ou cinétiques des processus résultant de cette dynamique. Elle est par exemple utilisée pour calculer des diagrammes de phase, étudier la diffusion de matière dans les solides ou encore reproduire le fonctionnement de membranes cellulaires. Au LSPM, cette méthode est appliquée aux calculs des propriétés structurales et cinétiques de collage de clusters de carbone rencontrés dans les plasmas poussiéreux. Une étude sur ces structures de carbone a été réalisée entre 2018 et 2021 par Amal Allouch, docteure en sciences des matériaux, étude qui a servi d'introduction et de guide pour le stage.
## Présentation des objectifs du stage
Le premier objectif du stage a été d'apprendre à utiliser les outils de calculs LAMMPS et de visualisation OVITO utilisés au LSPM, avec lesquels j'ai entrepris de reproduire dans des conditions similaires à celles de la docteure Allouch mais en moins de temps, les agrégat de carbones les plus stables prédits par son travail. Ensuite, j'ai entrepris de modéliser des agrégats de métaux comme le Tungsten, premièrement en vue d'identifier les différences avec une liaison covalente, ensuite pour étudier leur comportement dans des conditions similaires à celles existant en milieu plasma notamment dans un réacteur thermonucléaire. 
## Annonce du plan
Le travail effectué durant la période de ce stage vous sera présenté en trois parties. Premièrement, nous allons effectuer une mise en contexte du travail effectué durant ce stage en explorant les travaux de la docteure Allouch sur les agrégats de carbone et les théories sur lesquelles reposent à la fois son travail et le mien. Nous ferons aussi une brève présentation des logiciels utilisés. Dans une seconde partie, nous présenterons le travail effectué sur les agrégats de carbone dans le cadre de ce stage, les difficultés rencontrées, les solutions apportées et les conclusions tirées. Et ensuite nous verrons les travaux effectués sur le tungsten ainsi que les conclusions tirées.


# Développement 
## $I$- Première Partie

### Présentation des travaux de la docteure Allouch sur les agrégats de carbone, la méthode CRC et les logiciels LAMMPS et OVITO
Les interactions interatomiques sont fonctions des forces qui s'appliquent aux atomes considérées. Ces forces elles, dérivent d'un potentiel d'interaction qui peut être établi à l'aide de calcul de structure électronique de la mécanique quantique. Pour modéliser donc les interactions interatomique en simulations numériques nous utilisons des potentiels adaptés en fonction des atomes à modéliser. Dans le cas des clusters de carbone, nous utilisons des potentiels dits d'ordre de liaison, prenant en compte l'interaction entre un atome et son plus proche voisin, et aussi d'autres termes décrivant la torsion sur une liaison ou l'interaction à longue portée à l'image des interactions de Van-der-Waals. [image adaptée]
Il existe différentes méthodes permettant d'optimiser la formation d'agrégats d'atomes en Dynamique Moléculaire. Toutefois durant ce stage nous avons utilisé la méthode de Condensation et Recuit Combiné (CRC). Cette méthode consiste à soumettre un système de N atomes disposés aléatoirement à un échauffement jusqu'à une température $T_{max}$, effectuer ensuite une phase de régime à température constante (RTC) à cette température $T_{max}$ d'une durée $\tau_{RTC}$ pendant laquelle la structure carbonée obtenue se relaxe et finalement, une phase de refroidissement d'une durée $\tau_c$  jusqu'à la température $T_{min}$.[images de graphe montrant l'évolution d'un cluster durant le CRC]
Pour faire ces simulations, il faut dans un premier temps effectuer les calculs en lien à l'évolution de la position et de la vitesse des différents atomes du système au cours du cycle CRC, et ensuite visualiser ces données. Le calcul des positions et de vitesses des atomes du systèmes, ainsi que les énergies d'interactions se fait avec le logiciel LAMMPS (Large Scale Atomic/Molecular Passively Parallel Simulator). LAMMPS est un logiciel gratuit open-source développé et publié par Sandia national Laboratories. Dans LAMMPS, le lancement d'une simulation se fait à travers un script d'entrée dans lequel sont définis les différents paramètres utilisés (système d'unité, dimension et taille de boite de simulation, pas de temps, etc). Sont également spécifié les propriétés et informations relatives au système à exporter à chaque pas de temps dans les fichiers de sorties. Certains de ces fichiers de sorties seront utilisées pour la visualisation sur OVITO. OVITO est aussi un logiciel gratuit qui permet de construire, de visualiser des structures micro/macro-moléculaires, de visualiser la dynamique d'un système, ce qui nous sera utile pour visualiser l'évolution de la formation de nos clusters carbonés. Pour visualiser l'évolution de notre système au cours du cycle CRC, nous exportons dans des fichiers les informations telle que la position, la vitesse des particules, la température du milieu, l'énergie cinétique totale des particules, l'énergie potentielle d'interaction entre les différentes particules. OVITO a aussi des informations intégrées concernant les différents atomes et des propriétés comme leur masse, leur rayon de Van-der-Waals, etc. En spécifiant dans le fichier de sortie le type des atomes, la visualisation sur OVITO de ce fichier est encore plus spécifique et adapté au système modélisé.

## $I$- Deuxième partie
### Présentation de la structure d'un script dans LAMMPS, et des conditions dans lesquelles étaient lancées les calculs de Amal, présentation des défis rencontrés 
Un script d'entrée dans LAMMPS rassemble les instructions et les paramètres assignés au système pour le calcul. Les scripts que nous avons utilisé pour nos calculs avec LAMMPS peuvent être présentés en trois grandes parties. La première partie correspond à la définition des conditions initiales dans lesquelles se trouvent le système, ce qui comprend la définition du système d'unité à utiliser, le style de particules que l'on veut modéliser (atomes, particules chargées comme des ions, etc), le style d'espace à modéliser (un espace fini où les parois de la boîte sont considérées comme les limites et se comportent comme des murs, ou un espace périodique dans lequel la boîte ne présente qu'une portion et donc les parois de la boîte ne seront pas considérées comme des murs), la taille de la boîte de simulation, la disposition initiale des atomes et la masse des atomes ce qui va entre autre permettre leur identification par OVITO. La seconde partie consiste en la définition des paramètres qui vont orienter l'évolution du système au cours de la simulation. On y trouve la définition de la vitesse initiale des particules, la définition du potentiel d'interaction à utiliser, l'algorithme de sélection des plus proches voisins, le choix des paramètres à exporter dans les fichiers de sorties à chaque intervalle donnée ainsi que les informations à afficher durant la simulation comme la température du système, l'énergie potentielle d'interaction, le thermostat à utiliser pour guider l'évolution de la temperature dans le système. Et en dernier lieu on trouve la mise en place du cycle CRC qui dans le programme consiste en une modification à tour de rôle des paramètres du thermostat, sans oublier la conservation de l'énergie du système qu'il faut spécifier.
Nous avons débuté le stage avec comme intention de reproduire les résultats de la docteure Allouch, dans les mêmes conditions. Voici les principaux paramètres utilisés par la docteure Allouch dans son travail sur les clusters de carbones :

| **Unités de mesure**                                   | **ps, Angstrom, grams/mole, eV, Kelvin**                    |
| ------------------------------------------------------ | ----------------------------------------------------------- |
| **Taille de boîte de simulation**                      | **(100 Angstroms)$^3$**                                     |
| **Volume de disposition initial**                      | **(20 Angstroms)$^3$**                                      |
| **Thermostat**                                         | **Berendsen**                                               |
| **$T_{min},T_{max}$**                                  | **0, 3000 K**                                               |
| **Disposition initiale des atomes (seed)**             | **Choisi aléatoirement parmi des combinaisons de 6 digits** |
| **Durée des phases (chauffe/recuit, relaxe)**          | **100 ns, 100 ps**                                          |
| **Conditions aux limites de la boîte de simulation**   | **Périodique**                                              |
| **Potentiel utilisé**                                  | **Rebo**                                                    |
| **Algorithme de sélection des voisins et skin**        | **bin, 0.3**                                                |
| **Environnement dans lequel sont exécuté les calculs** | **Tchenla**                                                 |
| **Versions de LAMMPS utilisé**                         | - 16 Mars 2018<br>- 22 Aout 2018<br>- 3 Mars 2020           |

Ce sont aussi là les différents paramètres capables d'influencer le résultat du calcul lancés sur LAMMPS. Dans ces conditions, ci-après les structures de carbones les plus stables prédites par la docteure Allouch : [image montrant les différents clusters de carbone de C2 à C36].

Ces structures sont divisées en 6 grandes catégories : 
1) les clusters linéaires (de C2 à C5); [image adaptée et infos(bond length, energy)]
2) les clusters monocycliques (de C6 à C15); [image adaptée et infos(bond length, energy)]
3) les polycycles (de C16 à C19); [image adaptée et infos(bond length, energy)]
4) les graphènes-like (de C20 à C29); [image adaptée et infos(bond length, energy)]
5) les 3D-polycycles et bowl; [image adaptée et infos(bond length, energy)]
6) et les fullerènes-like; [image adaptée et infos(bond length, energy)]
Nos tentatives pour lancer le même calcul que la docteure Allouch sur d'autres ordinateurs n'ont pas été fructueuse. Dans l'objectif de comprendre ce qui nous faisait obstacle, nous avons entrepris d'étudier la réponse du système face à des modifications de certains paramètres, et en avons déduit certaines conclusions.
Le premier paramètre dont nous avons étudié l'influence est la taille de la boîte de simulation. C'est l'un des paramètres majeurs de la simulation, car elle détermine la densité initiale du gaz et peut ainsi influencer les résultats finaux de la simulation. La première taille de boîte que nous avons utilisé est de **(100 Angstroms)$^3$**. Nous avons après les premières simulations décidé de réduire la taille de la boîte, car pour de petits clusters de carbone, cette taille de boîte diminuait grandement la probabilité de rencontre de ces atomes. En partant ainsi de **(10 Angstroms)$^3$** pour les plus petits clusters (C2 à C5), nous avons progressivement augmenté la taille de la boîte pour obtenir des résultats adaptés, en fonction du nombre d'atomes à modéliser. Mais malgré cet ajustement qui contribuait à augmenter la densité initiale du gaz, la disposition initiale des atomes faisait défaut à la reproduction des structures les plus stables. Nous avons ainsi commencé l'étude de l'influence du *seed*. Le *seed* dans le code source du calcul correspond à un nombre aléatoire que l'on passe comme argument à un processus comme le choix de la position initiale des atomes, lorsqu'on veut que ce processus soit aléatoire. Autrement dit, au lieu de définir soit même dans un fichier les positions initiales des atomes et de les lire durant l'exécution du programme, on demande au logiciel d'attribuer des positions aléatoire aux atomes dans une région que l'on définit dans la boîte de simulation. Ce *seed* est en fait un échantillon statistique, qui doit donc être assez grand pour permettre des choix assez diversifié. Il se trouve qu'à chaque seed correspond une et une seule distribution spatiale des atomes dans la boîte; autrement dit, en utilisant le même seed, les atomes auront toujours initialement les mêmes positions dans l'espace. Ceci nous évite certes de contraindre la position des atomes, et donc de biaisé la structure obtenue à la fin, mais demande aussi de faire beaucoup d'essai avant de trouver le seed correspondant à la distribution spatiale initiale adéquate pour favoriser la formation de la structure la plus stable. Par contre, ce que l'on peut dicter même si le positionnement initial est aléatoire, c'est le volume dans lequel ils sont disposés. En réduisant cet espace on observe ceci : l'énergie initiale du système est très élevée, ce qui est logique car on dispose les atomes à moins de la distance d'équilibre l'une de l'autre. Cet état excité du système est favorable car le système se trouve en fait sur un pic de potentiel, ce qui augmente la probabilité de voir tous les puits de potentiels incluant le puits de potentiel global.
Selon les travaux de la docteure Allouch, le temps de relaxation ainsi que la durée de la phase de chauffe sont très importantes pour la structure finale que l'on obtient. De plus, la structure obtenue à la fin de la phase de relaxation ne change pas durant la phase de recuit, ou du moins ne change que très peu. Nous avons donc essayé de reproduire les calculs dans des conditions de vitesse de chauffe similaires, mais étant limité par le temps et les ressources nous avons dû recourir à d'autres conditions. Au lieu de lancer 1 milliard iterations pour le calcul, nous nous somme limités à 1 million d'iterations. 
Dans un premier temps, nous avons effectué nos calculs avec le potentiel **airebo** tandis que la docteure Allouch utilise le potentiel **rebo** dans ses calculs. Le potentiel **rebo** (Reactive Empirical Bond Order) est un potentiel qui évalue la force de la liaison en tenant compte de l'ordre de la liaison, de la distance et des angles. Le potentiel **airebo** a été développé à partir de ce même potentiel, mais avec quelques ajustements prend en compte une distance limite à laquelle il n'y a plus d'interaction entre atomes et aussi un terme de torsion, modélisant les contributions énergétiques dues à la rotation autour des liaisons simples. Dans le code LAMMPS, on peut choisir de ne pas activer les autres termes du potentiel **airebo**, le rendant ainsi théoriquement équivalent au potentiel **rebo**. Cependant, nos résultats ont prouvé le contraire. On voit bien les différences sur ce graphique :
![[Energie des clusters selon le potentiel utilisé.png]]
Nous avons aussi supposé que l'environnement dans lequel sont lancés les calculs pouvait influencer les résultats. Pour vérifier l'hypothèse, nous avons lancé différents calculs sur plusieurs unités de calculs. 
Dans un premier temps, nous avons lancés le calcul pour le cluster C8 sur différentes machines avec des versions différentes de LAMMPS. Les résultats obtenus sont classés dans les tableaux ci-dessous.

**Résultats des simulations lancées sur 5 Unités de calculs différents (potentiel airebo)**

| Environnement                                     | Énergie (eV/atom) |
| ------------------------------------------------- | ----------------- |
| **Ubuntu 20.04.6, LAMMPS 20 Nov 2019**            | -5.04             |
| **Ubuntu 20.04.6, LAMMPS 3 Mars 2020**            | -5.04             |
| **Ubuntu 22.04.4, LAMMPS 29 Sep 2021 (Update 2)** | -5.04             |
| **Ubuntu 22.04.3, LAMMPS 29 Sep 2021 (Update 2)** | -5.04             |

**Résultats des calculs lancés pour une taille de boîte de 10 Angstroms (C2 à C7) et 40 Angstroms (C8 et C9) (potentiel rebo)**

| Taille des clusters | Ubuntu 22.04.3 & LAMMPS 29 Sep 2021 | Ubuntu 24.04 & LAMMPS 7 Feb 2024 |
| ------------------- | ----------------------------------- | -------------------------------- |
| 2                   | -3.10                               | -3.10                            |
| 3                   | -4.30                               | -4.30                            |
| 4                   | -4.75                               | -4.75                            |
| 5                   | -5.03                               | -5.03                            |
| 6                   | -5.28                               | -5.28                            |
| 7                   | -5.51                               | -5.51                            |
| 8                   | -5.64                               | -5.64                            |
| 9                   | -5.74                               | -5.74                            |
Tous les résultats présentés précédemment sont des résultats pour des cycles de CRC de 100 picosecondes de chauffe et 10 picosecondes de relaxation.

En lançant les calculs avec les mêmes paramètres que la docteure Allouch (boite de 100 Angstroms, boite initiale de 20 Angstroms), nous trouvons les résultats suivants :

| Nombre d'iteration | Durée des cycles (chauffe, relaxation=10%chauffe) | Ubuntu 22.04.3 & LAMMPS 29 Sep 2021 (Update 2) | Ubuntu 24.04 & LAMMPS 7 Feb 2024 (Update 1) |
| ------------------ | ------------------------------------------------- | ---------------------------------------------- | ------------------------------------------- |
| 1 000 000          | 0.1 ns                                            | -12.42 eV                                      | -12.42 eV                                   |
| 10 000 000         | 1 ns                                              | -37.36 eV                                      | -41.18 eV                                   |
| 100 000 000        | 10 ns                                             | -45.18 eV                                      | -43.48 eV                                   |
| 1000 000 000       | 100 ns                                            | -45.20 eV                                      | -45.20 eV                                   |

On remarque donc que l'on ne peut reproduire les résultats de la docteure Allouch, en ne modifiant que la durée des cycles. Si l'on veut reproduire ses résultats , il faut se mettre dans exactement les mêmes conditions (mêmes paramètres et mêmes durées de cycle) ou si l'on modifie un paramètre, il faut aussi modifier le reste. L'objectif premier était en effet de reproduire les résultats de la docteure Allouch, dans le moins de temps possible. Nous voyons donc que cela ne peut être réalisée qu'en modifiant plusieurs des paramètres de la simulation. 
![[Pourcentage de formation du cluster C8 en fonction de la duree de chauffage.png]]
![[Evolution du temps de calcul en fonction de la duree de chauffage.png]]

On remarque sur ce graphique que le temps de calcul augmentant trop rapidement, ne nous permettrait pas de lancer autant de simulations que la docteure Allouch et de modéliser un cycle de 100 chauffage de 100 ns. Par ailleurs, le cluster n'est complètement formé que dans ces conditions spécifiques, avec le temps de calcul nécessaire qui est de 100 ns. 

## $III$- Troisième partie
### Présentation d'un crystal, de la liaison métallique, identification des différences avec la liaison covalente (travaux sur le Tungstène) 
La seconde partie du stage fût consacrée à l'étude d'une structure métallique : le Tungstène. Dans toutes les interactions du carbone que l'on a vu, on a remarqué que l'interaction avait une certaine direction qui était celle de la liaison covalente **C-C**. On sait de plus que les électrons sont localisés dans la liaison, ce qui va de pair avec l'interaction dirigée, et que chaque atome apporte un électron de la paire partagée. On a aussi remarqué que les clusters de carbone pouvait avoir des structures spécifiques (linéaire, mono/poly-cyclique, graphene ou fullerene, etc). La liaison métallique présente bien des différences. 

| Caractéristique                 | Liaison Covalente                    | Liaison Métallique                       |
| ------------------------------- | ------------------------------------ | ---------------------------------------- |
| **Structure électronique**      | Électrons localisés entre les atomes | Électrons délocalisés sur tout le réseau |
| **Formation**                   | Partage d'électrons entre atomes     | Mer d'électrons délocalisés              |
| **Types de composés formés**    | Molécules, réseaux covalents         | Métaux et alliages                       |
| **Exemples**                    | H₂, O₂, CH₄                          | Fe, Cu, Al, W                            |
| **État à température ambiante** | Solide, liquide, gazeux              | Solide (sauf le mercure)                 |
| **Conductivité électrique**     | Faible à nulle (sauf exceptions)     | Élevée                                   |
| **Points de fusion/ébullition** | Relativement bas                     | Élevés                                   |
| **Ductilité et malléabilité**   | Souvent fragiles                     | Ductiles et malléables                   |

| État à Température Ambiante | Exemple (Composés covalent)  | Exemples (Composes métalliques) |
| --------------------------- | ---------------------------- | ------------------------------- |
| **Solide**                  | Diamant (C), Quartz(SiO$_2$) | Fer(Fe), Tungsten(W)            |
| **Liquide**                 | Eau (H₂O)                    | Mercure(Hg)                     |
| **Gazeux**                  | Dioxyde de Carbone (CO₂)     | -                               |

![[tungsten_bcc.png]] 
![[C9.png]]

On remarque bien ici que le tungstène adopte une structure de réseau, ce qui correspond bien à la description de mer d'électrons délocalisés sur la structure.
Nous savons aussi que le tungstène à une structure crystalline **bcc** (Body Centered Cubic) où les atomes métalliques sont placés sur les sommets du cube et un atome au centre du cube.
![[bcc.png]]
![[tungsten_bcc.png]]

Pour modéliser une telle structure (corps cubique centré) de métal, il faut prendre en compte le fait que les interactions sont différentes, les distances d'équilibre sont aussi différentes, la structure l'est aussi. Le potentiel adapté permet de faire la représentation de ce réseau de tungsten.
Cependant, quelque chose d'étonnant se passe si on effectue un cycle CRC sur un gaz de tungsten. Prenons le cas où l'on dispose aléatoirement un gaz de tungsten d'une cinquantaine d'atomes

![[tungsten_alea_pos.png]]

et que l'on fasse un cycle CRC sur le gaz, ce qui nous permettrait d'obtenir la structure la plus stable du tungsten après recuit. On s'attend à obtenir une structure ordonnée, en corps cubique centré. Cependant on obtient ceci : 
![[tungsten_alea_chauff_pos.png]]
On a donc tenté de comprendre pourquoi l'on obtenait pas la structure crystalline a corps cubique centré. On a de ce fait soumis non pas un gaz de tungstène, mais une nanostructure crystalline de tungstène, au cycle CRC et avons suivi l'évolution de sa géométrie. 

![[bcc_54_0.png]]

Nous avons remarqué que la structure est passée de crystal ordonné à la même structure précédente. 

![[bcc_54_chauffe.png]]

Le changement de géométrie de la structure est marquée par un réagencement des atomes dans l'espace et donc une modification de la distance dite paramètre de maille (3.52 Angstroms) vers une distance plus petite (2.62 Angstroms). Cette réduction de la distance d'équilibre mène à une géométrie plus compacte que la structure crystalline de départ.

![[bcc_54_chauffe_graph_0.png]]

![[bcc_54_chauffe_graph.png]]


