# Menu du Restaurant X

Application Flutter qui affiche la carte d'un restaurant par catégorie
(Formules, Entrées, Plats, Desserts, Boissons). Chaque plat est présenté
sous forme de carte avec photo, nom, description et prix.

## Fonctionnalités

- **Catégories scrollables** : barre horizontale d'étiquettes (`ChoiceChip`)
  dans un `SingleChildScrollView`, utilisable même sur un écran étroit.
- **Cartes réutilisables** : un seul widget `PlatCard` pour tous les plats,
  sans duplication de code.
- **Sélection** : la catégorie active est mise en évidence et filtre la liste
  (« Formules » par défaut).
- **Responsive portrait / paysage** : `LayoutBuilder` affiche une liste en
  portrait et une grille de 2 ou 3 colonnes sur un écran large.
- **Animation** : transition en fondu (`AnimatedSwitcher`) au changement de
  catégorie.
- **Photos locales** : une photo par plat dans `assets/images/`, chargée avec
  `Image.asset` (fonctionne hors ligne), avec repli sur un emoji si le
  fichier est introuvable.

## Structure du code

Tout le code est dans [`lib/main.dart`](lib/main.dart) :

| Élément | Rôle |
| --- | --- |
| `Plat` | Modèle de données immuable (nom, description, prix, catégorie, emoji, nom de la photo). |
| `CategorieBar` | Barre horizontale des catégories, signale la sélection via `onSelect`. |
| `PlatsListe` | Liste (portrait) ou grille (paysage) des plats de la catégorie, construite à la demande. |
| `PlatCard` | Carte réutilisable d'un plat : image à gauche, texte et prix à droite. |
| `PlatImage` | Photo du plat (`Image.asset`) avec emoji de repli en cas d'erreur. |

`MenuPage` (StatefulWidget) garde la catégorie sélectionnée et assemble ces
composants.

## Captures d'écran

| Formules | Plats | Desserts | Boissons (barre scrollée) |
| --- | --- | --- | --- |
| ![Formules](docs/screenshots/portrait_formules.png) | ![Plats](docs/screenshots/portrait_plats.png) | ![Desserts](docs/screenshots/portrait_desserts.png) | ![Boissons](docs/screenshots/portrait_boissons.png) |

Paysage, catégorie Plats (affichage en grille) :

![Plats en paysage](docs/screenshots/paysage_plats.png)

## Vidéos de démo

- **Portrait** (~25 s) : Formules → Entrées → Plats avec scroll de la liste
  jusqu'en bas → Desserts → scroll horizontal de la barre → Boissons.
  [demo.mp4](docs/demo.mp4) · [demo.webm](docs/demo.webm)
- **Paysage** (~10 s) : affichage en grille, scroll des Plats, puis Desserts.
  [demo_paysage.mp4](docs/demo_paysage.mp4) · [demo_paysage.webm](docs/demo_paysage.webm)

## Lancer le projet

```bash
flutter pub get
flutter run -d chrome
```

## Tests

```bash
flutter test
```

Les tests vérifient que les 5 catégories s'affichent, que « Formules » est
sélectionnée par défaut et qu'un tap sur « Desserts » affiche « Crème brûlée »
et masque « Formule Midi ».

## Crédits des images

Photos sous licences Creative Commons (Flickr, via Openverse). Le détail
(titre, auteur, licence) est dans [docs/CREDITS_IMAGES.md](docs/CREDITS_IMAGES.md).
