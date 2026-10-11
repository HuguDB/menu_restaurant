import 'package:flutter/material.dart';

void main() {
  runApp(const RestaurantApp());
}

// ---------------------------------------------------------------------------
// MODÈLE DE DONNÉES
// Une classe simple et immuable pour représenter un plat.
// ---------------------------------------------------------------------------
class Plat {
  const Plat({
    required this.nom,
    required this.description,
    required this.prix,
    required this.categorie,
    required this.emoji,
    required this.image,
  });

  final String nom;
  final String description;
  final double prix;
  final String categorie;
  final String emoji; // affiché si l'image ne charge pas
  final String image; // nom du fichier dans assets/images/

  String get imagePath => 'assets/images/$image.jpg';
}

// Les catégories sont listées dans l'ordre d'affichage de la barre.
const List<String> categories = [
  'Formules',
  'Entrées',
  'Plats',
  'Desserts',
  'Boissons',
];

// Données codées en dur (autorisé par la consigne).
const List<Plat> plats = [
  // Formules
  Plat(nom: 'Formule Midi', description: 'Entrée + plat ou plat + dessert, servie du lundi au vendredi.', prix: 16.90, categorie: 'Formules', emoji: '🍽️', image: 'formule_midi'),
  Plat(nom: 'Formule Complète', description: 'Entrée, plat et dessert au choix dans la carte du jour.', prix: 22.50, categorie: 'Formules', emoji: '🥂', image: 'formule_complete'),
  Plat(nom: 'Menu Enfant', description: 'Steak haché frites, sirop à l’eau et une boule de glace.', prix: 9.90, categorie: 'Formules', emoji: '🧒', image: 'menu_enfant'),
  // Entrées
  Plat(nom: 'Salade de chèvre chaud', description: 'Toasts de chèvre, miel, noix et mesclun.', prix: 8.50, categorie: 'Entrées', emoji: '🥗', image: 'salade_chevre'),
  Plat(nom: 'Velouté de potiron', description: 'Crème légère et graines de courge torréfiées.', prix: 6.90, categorie: 'Entrées', emoji: '🎃', image: 'veloute_potiron'),
  Plat(nom: 'Œufs mayonnaise', description: 'Le grand classique de bistrot, mayonnaise maison.', prix: 5.50, categorie: 'Entrées', emoji: '🥚', image: 'oeufs_mayonnaise'),
  // Plats
  Plat(nom: 'Bœuf bourguignon', description: 'Mijoté 6 heures au vin rouge, pommes vapeur.', prix: 17.90, categorie: 'Plats', emoji: '🍲', image: 'boeuf_bourguignon'),
  Plat(nom: 'Pavé de saumon', description: 'Sauce beurre blanc, riz basmati et légumes de saison.', prix: 18.50, categorie: 'Plats', emoji: '🐟', image: 'pave_saumon'),
  Plat(nom: 'Burger du chef', description: 'Pain brioché, cheddar affiné, oignons confits, frites maison.', prix: 15.90, categorie: 'Plats', emoji: '🍔', image: 'burger_chef'),
  Plat(nom: 'Risotto aux cèpes', description: 'Riz arborio crémeux, parmesan et huile de truffe.', prix: 16.50, categorie: 'Plats', emoji: '🍄', image: 'risotto_cepes'),
  Plat(nom: 'Poulet rôti', description: 'Poulet fermier rôti, pommes grenaille et haricots verts.', prix: 16.90, categorie: 'Plats', emoji: '🍗', image: 'poulet_roti'),
  Plat(nom: 'Lasagnes maison', description: 'Bolognaise mijotée, béchamel et parmesan gratiné.', prix: 14.50, categorie: 'Plats', emoji: '🍝', image: 'lasagnes'),
  Plat(nom: 'Magret de canard', description: 'Magret rosé, sauce au miel et légumes croquants.', prix: 21.00, categorie: 'Plats', emoji: '🦆', image: 'magret_canard'),
  Plat(nom: 'Moules-frites', description: 'Moules marinières au vin blanc, frites maison.', prix: 15.50, categorie: 'Plats', emoji: '🦪', image: 'moules_frites'),
  // Desserts
  Plat(nom: 'Crème brûlée', description: 'À la vanille de Madagascar, caramélisée minute.', prix: 7.00, categorie: 'Desserts', emoji: '🍮', image: 'creme_brulee'),
  Plat(nom: 'Fondant au chocolat', description: 'Cœur coulant, boule de glace vanille.', prix: 7.50, categorie: 'Desserts', emoji: '🍫', image: 'fondant_chocolat'),
  Plat(nom: 'Tarte Tatin', description: 'Pommes caramélisées, crème fraîche épaisse.', prix: 7.00, categorie: 'Desserts', emoji: '🥧', image: 'tarte_tatin'),
  // Boissons
  Plat(nom: 'Limonade artisanale', description: 'Citron pressé et sucre de canne, 33 cl.', prix: 4.00, categorie: 'Boissons', emoji: '🍋', image: 'limonade'),
  Plat(nom: 'Verre de vin rouge', description: 'Côtes-du-Rhône, 12 cl.', prix: 5.50, categorie: 'Boissons', emoji: '🍷', image: 'vin_rouge'),
  Plat(nom: 'Café gourmand', description: 'Expresso et trio de mignardises.', prix: 8.00, categorie: 'Boissons', emoji: '☕', image: 'cafe_gourmand'),
];

// Formatage français du prix : 12.5 -> "12,50 €"
String formatPrix(double prix) =>
    '${prix.toStringAsFixed(2).replaceAll('.', ',')} €';

// ---------------------------------------------------------------------------
// APPLICATION
// ---------------------------------------------------------------------------
class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu du Restaurant X',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const MenuPage(),
    );
  }
}

// StatefulWidget car la catégorie sélectionnée change l'affichage.
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String _categorieSelectionnee = categories.first;

  @override
  Widget build(BuildContext context) {
    // Filtrage des plats selon la catégorie active.
    final platsFiltres =
        plats.where((p) => p.categorie == _categorieSelectionnee).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Menu du Restaurant X'),
      ),
      // Column : la barre de catégories en haut, la liste des plats dessous.
      body: Column(
        children: [
          CategorieBar(
            categories: categories,
            selection: _categorieSelectionnee,
            onSelect: (c) => setState(() => _categorieSelectionnee = c),
          ),
          // Expanded : la liste occupe toute la hauteur restante, ce qui
          // évite l'erreur "unbounded height" d'une ListView dans une Column.
          Expanded(
            // AnimatedSwitcher : transition en fondu au changement de catégorie.
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: PlatsListe(
                key: ValueKey(_categorieSelectionnee),
                plats: platsFiltres,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// BARRE DE CATÉGORIES
// SingleChildScrollView horizontal + Row : la Row aligne les étiquettes,
// le scroll permet d'en afficher plus que la largeur de l'écran.
// ---------------------------------------------------------------------------
class CategorieBar extends StatelessWidget {
  const CategorieBar({
    super.key,
    required this.categories,
    required this.selection,
    required this.onSelect,
  });

  final List<String> categories;
  final String selection;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          for (final c in categories)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              // ChoiceChip : étiquette avec état sélectionné intégré.
              child: ChoiceChip(
                label: Text(c),
                selected: c == selection,
                onSelected: (_) => onSelect(c),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// LISTE DES PLATS (responsive)
// LayoutBuilder donne la largeur réellement disponible :
// - écran étroit (portrait) : ListView.builder, une carte par ligne ;
// - écran large (paysage, tablette) : GridView.builder sur 2 ou 3 colonnes.
// Dans les deux cas, les éléments sont construits à la demande (builder).
// ---------------------------------------------------------------------------
class PlatsListe extends StatelessWidget {
  const PlatsListe({super.key, required this.plats});

  final List<Plat> plats;

  @override
  Widget build(BuildContext context) {
    if (plats.isEmpty) {
      return const Center(child: Text('Aucun plat dans cette catégorie.'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        const padding = EdgeInsets.fromLTRB(12, 0, 12, 12);

        if (constraints.maxWidth < 600) {
          return ListView.builder(
            padding: padding,
            itemCount: plats.length,
            itemBuilder: (context, i) => PlatCard(plat: plats[i]),
          );
        }

        final colonnes = constraints.maxWidth < 1000 ? 2 : 3;
        return GridView.builder(
          padding: padding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: colonnes,
            mainAxisExtent: 140, // hauteur fixe : cartes homogènes
            crossAxisSpacing: 8,
          ),
          itemCount: plats.length,
          itemBuilder: (context, i) => PlatCard(plat: plats[i]),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// CARTE D'UN PLAT (composant réutilisable, évite la duplication)
// Row : image à gauche, informations à droite.
// Expanded autour de la Column pour que le texte prenne la place restante
// et passe à la ligne au lieu de déborder.
// ---------------------------------------------------------------------------
class PlatCard extends StatelessWidget {
  const PlatCard({super.key, required this.plat});

  final Plat plat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 3,
      clipBehavior: Clip.antiAlias, // arrondit aussi l'image
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: 120, child: PlatImage(plat: plat)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plat.nom,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    // Description limitée à 2 lignes (consigne).
                    Text(
                      plat.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                    const Spacer(), // pousse le prix en bas de la carte
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          formatPrix(plat.prix),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Image du plat : photo locale (assets/images/) avec repli sur un emoji
// si le fichier est introuvable.
class PlatImage extends StatelessWidget {
  const PlatImage({super.key, required this.plat});

  final Plat plat;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      plat.imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        alignment: Alignment.center,
        child: Text(plat.emoji, style: const TextStyle(fontSize: 44)),
      ),
    );
  }
}
