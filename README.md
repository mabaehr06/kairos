<p align="center">
  <img src="assets/banner_1680_640.png" alt="Kairos — Escape from the Moon" width="620">
</p>

Kairos est un jeu de survie 2D développé en Lua avec [LÖVE](https://love2d.org).

Vous êtes bloqué sur la Lune : récoltez des ressources, réparez votre fusée et décollez le plus vite possible — avant de manquer d'oxygène. Votre score est le temps passé sur place : le plus court est le meilleur.


# Installation

### Depuis une release (aucune dépendance à installer)

Rendez-vous sur la page [Releases](https://github.com/mabaehr06/kairos/releases) et téléchargez :

| Plateforme | Fichier | Utilisation |
|---|---|---|
| Windows | `Kairos-windows-x64.zip` | Dézippez **entièrement** le dossier, puis lancez `Kairos.exe` |
| Linux | `Kairos-linux-x86_64.AppImage` | `chmod +x Kairos-linux-x86_64.AppImage` puis double-clic |
| LÖVE déjà installé | `Kairos.love` | `love Kairos.love` |

Sur Windows, les DLL doivent rester à côté de l'exécutable : lancer le `.exe` directement depuis l'archive zip ne fonctionnera pas.

Sur Ubuntu 24.04 et plus récent, si l'AppImage refuse de démarrer avec une erreur `libfuse.so.2` :

```bash
sudo apt install libfuse2t64
```

### Depuis les sources

- [LÖVE 11.5](https://love2d.org)
- `love .` depuis la racine du projet

## Contrôles

| Touche | Action |
|---|---|
| Z Q S D | Déplacement |
| F | Récolter / interagir (fusée & objets) |
| E | Ouvrir l'inventaire |
| C | Consommer de la glace (+1 oxygène) |
| V | Consommer de l'oxygène pur (+5 oxygène) |
| Clic gauche (inventaire) | Lancer une fabrication |
| Clic droit (inventaire) | Sélectionner un objet à poser |
| Clic (carte) | Poser l'objet sélectionné |
| R | Recommencer une partie (en jeu) |
| Échap | Quitter |

## Langues

Le jeu est jouable en français, anglais, espagnol et italien, au choix depuis l'écran de paramètres.
Le changement s'applique immédiatement, et la langue choisie est retenue d'une partie à l'autre.

## Architecture

Le projet sépare les **écrans** des **composants**. Un écran vit dans `src/scenes` : il possède son état, ses entrées et son dessin, et expose `enter`, `update`, `draw`, `keypressed` et `mousepressed`. Un composant vit dans `src/gui` : il ne connaît rien des états du jeu et se contente d'être réutilisé par les écrans.

`main.lua` ne fait que transmettre : une table associe chaque état du jeu à sa scène, et les quatre fonctions de LÖVE donnent la main à la scène courante.

```
main.lua              point d'entrée LÖVE, transmet tout à la scène de l'état courant
conf.lua              fenêtre et identité du jeu
src/
├── config.lua        réglages des systèmes de jeu
├── items.lua         ressources, objets, recettes et niveaux du radar
├── game.lua          machine à états, chronomètre, victoire / défaite
├── map.lua           génération de la carte et des ressources
├── player.lua        déplacement, inventaire, oxygène, interactions
├── rocket.lua        étapes de réparation et décollage
├── crafts.lua        file de fabrication et pose d'objets
├── power.lua         production et consommation d'électricité
├── radar.lua         niveau du radar et champ de vision du joueur
├── cycle.lua         cycle jour / nuit
├── camera.lua        suivi du joueur, conversion écran ↔ monde
├── save.lua          persistance du meilleur temps
├── settings.lua      réglages du joueur, et leur persistance
├── lang.lua          résolution des textes dans la langue choisie
├── fonts.lua         polices du jeu, en tailles relatives à la fenêtre
├── version.lua       version du jeu, injectée depuis le tag git à la release
├── utils.lua         fonctions utilitaires
├── gui/              les composants : bouton, rangée de réglage et HUD
├── scenes/           les écrans : menu, paramètres, partie et inventaire, écrans de fin
├── lang/             un fichier de traduction par langue
└── debug/log.lua     journal d'événements à l'écran
assets/               logo, bannière, polices et drapeaux des langues
docs/                 documentation du projet
```

## Configuration

`src/config.lua` regroupe les réglages des systèmes : vitesse du joueur, réserve d'oxygène, taille de la carte, durée du cycle, rendement des panneaux, champ de vision de départ. `src/items.lua` tient la définition de tout ce que le jeu contient et son coût : densité des ressources, recettes des objets, étapes de réparation de la fusée et niveaux du radar. Aucune de ces valeurs n'est codée en dur ailleurs, ces deux fichiers sont les seuls à toucher pour équilibrer le jeu.
le jeu peut gérer n'importe quelle résolution.
Le plein écran et l'écran utilisé se règlent dans la section `graphics` de `src/config.lua`.

La section `settings` de `src/config.lua` est à part : elle liste ce que le joueur peut changer depuis l'écran de paramètres, et la valeur de départ de chaque réglage. Une clé absente de cette section est une clé que le jeu ignore, en lecture comme en écriture.

Le meilleur temps est stocké dans `best.txt` et les réglages dans `settings.txt`, dans le répertoire de sauvegarde LÖVE :

- Linux — `~/.local/share/love/kairos/`
- Windows — `%APPDATA%\LOVE\kairos\`

## Releases

Le jeu suit un versionnage `vX.Y.Z` :

| Position | Quand l'incrémenter | Exemples |
|---|---|---|
| **X** — majeur | Reste à `0` tant que la boucle de jeu n'est pas complète. Passera à `1` à la première version finie et jouable de bout en bout, puis à chaque refonte qui change le jeu en profondeur ou casse la compatibilité des sauvegardes. | `v1.0.0` |
| **Y** — mineur | Un pan du jeu apparaît ou est entièrement refait : un nouvel écran, un nouveau système de jeu, la refonte complète d'une interface existante. Remet `Z` à zéro. | `v0.1.0` refonte du menu, `v0.2.0` refonte de l'inventaire |
| **Z** — correctif | Tout ce qui ne change pas la structure : corrections de bugs, équilibrage, ajout de sprites, retouches visuelles ponctuelles. | `v0.1.1` textures des minerais, `v0.1.2` sprites de la fusée |

Pousser un tag construit les trois formats et publie la release. Le tag est annoté, et son message résume la version en une ligne :

```bash
git tag -a v0.2.0 -m "Inventory screen redesigned, with panels, ressource sprites, craft buttons and progress bars"
git push origin v0.2.0
```

Le nom du tag devient la version affichée dans le menu.

## Problèmes

Pour tout problème trouvé, merci d'ouvrir une [issue](https://github.com/mabaehr06/kairos/issues) avec le nom du problème ainsi qu'une description pour m'aider dans la résolution de l'erreur. Quelques exemples sont déjà affichés pour vous aider..

## Licence

Le code est sous licence MIT — voir [LICENSE](LICENSE).

La police [Alexandria](https://fonts.google.com/specimen/Alexandria) est distribuée sous SIL Open Font License 1.1, dont le texte accompagne le fichier dans [assets/fonts](assets/fonts).
