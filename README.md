# Kairos

Kairos est un jeu de survie 2D développé en Lua avec [LÖVE](https://love2d.org).

Vous êtes bloqué sur la Lune : récoltez des ressources, réparez votre fusée et décollez le plus vite possible — avant de manquer d'oxygène.


# Installation

### Depuis une release (aucune dépendance à installer)

Rendez-vous sur la page [Releases](https://github.com/mabaehr06/kairos/releases) et téléchargez :

| Plateforme | Fichier | Utilisation |
|---|---|---|
| Windows | `Kairos-windows-x64.zip` | Dézippez **entièrement** le dossier, puis lancez `Kairos.exe` |
| Linux | `Kairos-linux-x86_64.AppImage` | `chmod +x Kairos-linux-x86_64.AppImage` puis double-clic |
| LÖVE déjà installé | `Kairos.love` | `love Kairos.love` |

Sur Windows, les DLL doivent rester à côté de l'exécutable : lancer le `.exe` directement depuis l'archive zip ne fonctionnera pas.

Sur Ubuntu 24.04 et plus récent, si l'AppImage refuse de démarrer avec une erreur `libfuse.so.2`, installez `libfuse2t64` :


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
| R | Recommencer une partie |
| Échap | Quitter |



## Architecture

```
main.lua              point d'entrée LÖVE (load / update / draw / input)
conf.lua              fenêtre et identité du jeu
src/
├── config.lua        toutes les constantes de gameplay
├── game.lua          machine à états, chronomètre, victoire / défaite
├── map.lua           génération de la carte et des ressources
├── player.lua        déplacement, inventaire, oxygène, interactions
├── rocket.lua        étapes de réparation et décollage
├── crafts.lua        file de fabrication et pose d'objets
├── power.lua         production et consommation d'électricité
├── cycle.lua         cycle jour / nuit
├── items.lua         ressources, objets et recettes
├── camera.lua        suivi du joueur, conversion écran ↔ monde
├── save.lua          persistance du meilleur temps
├── utils.lua         fonctions utilitaires
├── gui/              menu, HUD, inventaire, écran de fin
└── debug/log.lua     journal d'événements à l'écran
assets/               images et sons
docs/                 documentation du projet
```

## Configuration

`src/config.lua` regroupe l'intégralité des valeurs de gameplay : vitesse du joueur, réserve d'oxygène, taille de la carte, densité des ressources, durée du cycle, rendement des panneaux. A  
cune valeur n'est codée en dur ailleurs — : est le seul fichier à toucher pour équilibrer le jeu.

Le meilleur temps est stocké dans `best.txt`, dans le répertoire de sauvegarde LÖVE :

- Linux — `~/.local/share/love/kairos/`
- Windows — `%APPDATA%\LOVE\kairos\`

## Problèmes

Pour tout problème trouvé, merci d'ouvrir une [issue](https://github.com/mabaehr06/kairos/issues) avec le nom du problème ainsi qu'une description pour m'aider dans la résolution de l'erreur.

## Licence

MIT — voir [LICENSE](LICENSE).