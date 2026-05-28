import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  static const List<_ExploreCategory> _categories = [
    _ExploreCategory(
      title: 'Healing Crystals',
      rocks: [
        _ExploreRock(
          name: 'Amethyst',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/2/20/Amethyst._Magaliesburg%2C_South_Africa.jpg',
          description:
              'Calming purple quartz known for easing stress and promoting clarity.',
        ),
        _ExploreRock(
          name: 'Rose Quartz',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/2/2e/Rose_quartz_ball_%28Madagascar%29.jpg',
          description:
              'Soft pink stone associated with compassion and emotional healing.',
        ),
        _ExploreRock(
          name: 'Clear Quartz',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Quartz%2C_Tibet.jpg',
          description:
              'Versatile crystal used to amplify energy and intentions.',
        ),
        _ExploreRock(
          name: 'Citrine',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/77/Citrine-Brazil.jpg',
          description: 'Golden quartz linked to optimism, abundance, and creativity.',
        ),
        _ExploreRock(
          name: 'Black Tourmaline',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/1/19/Schorl-tourmaline-173777.jpg',
          description: 'Protective stone believed to absorb negative energy.',
        ),
        _ExploreRock(
          name: 'Selenite',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/3/31/Gypsum-var.-selenite-_Naica_Mine%2C_Municipio_de_Saucillo%2C_Chihuahua%2C_Mexico.jpg',
          description: 'Translucent gypsum prized for cleansing and gentle energy.',
        ),
        _ExploreRock(
          name: 'Labradorite',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/4/4d/Labradorite-polished.jpg',
          description: 'Iridescent feldspar said to spark intuition and transformation.',
        ),
        _ExploreRock(
          name: 'Smoky Quartz',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/1/1f/Quartz_smoky_%28GW_31281%29.jpg',
          description: 'Earthy quartz that supports grounding and release.',
        ),
        _ExploreRock(
          name: "Tiger's Eye",
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/f/f7/Tigers_eye.jpg',
          description: 'Chatoyant stone for confidence and focus.',
        ),
        _ExploreRock(
          name: 'Green Aventurine',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/9/9d/Green_Aventurine_%286534505798%29.jpg',
          description: 'Green quartz for luck and heart-centered balance.',
        ),
      ],
    ),
    _ExploreCategory(
      title: 'Gemstones',
      rocks: [
        _ExploreRock(
          name: 'Sapphire',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/7a/Sapphire_gem.JPG',
          description: 'Blue corundum valued for durability and regal color.',
        ),
        _ExploreRock(
          name: 'Ruby',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/c/cd/Ruby_gem.JPG',
          description: 'Red corundum symbolizing passion and vitality.',
        ),
        _ExploreRock(
          name: 'Emerald',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Emerald_gem2.jpg',
          description: 'Green beryl prized for rich color and rarity.',
        ),
        _ExploreRock(
          name: 'Diamond',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/03/Cut_diamond.jpg',
          description: 'Hardest gemstone known for brilliance and strength.',
        ),
        _ExploreRock(
          name: 'Opal',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/1/10/Opal-Pietra.JPG',
          description: 'Play-of-color gem with shifting rainbow flashes.',
        ),
        _ExploreRock(
          name: 'Topaz',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/4/42/Topaz-gem.JPG',
          description: 'Gemstone in warm hues linked to clarity and joy.',
        ),
        _ExploreRock(
          name: 'Garnet',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/8/80/Garnet-gem-01.jpg',
          description: 'Deep red gem that represents protection and devotion.',
        ),
        _ExploreRock(
          name: 'Peridot',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/2/2f/Peridot-gem.JPG',
          description: 'Olive-green gem born from volcanic origins.',
        ),
        _ExploreRock(
          name: 'Aquamarine',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/2/2c/Aquamarine-gem.jpg',
          description: 'Sea-blue beryl associated with calm and clarity.',
        ),
        _ExploreRock(
          name: 'Tanzanite',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/d/d6/Tanzanite-gem.jpg',
          description: 'Violet-blue gem found only in Tanzania.',
        ),
      ],
    ),
    _ExploreCategory(
      title: 'Birthstones',
      rocks: [
        _ExploreRock(
          name: 'Garnet',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/8/80/Garnet-gem-01.jpg',
          description: 'January birthstone with deep red glow and resilience.',
        ),
        _ExploreRock(
          name: 'Amethyst',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/2/20/Amethyst._Magaliesburg%2C_South_Africa.jpg',
          description: 'February birthstone celebrated for serenity and wisdom.',
        ),
        _ExploreRock(
          name: 'Aquamarine',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/2/2c/Aquamarine-gem.jpg',
          description: 'March birthstone evoking tranquil seas.',
        ),
        _ExploreRock(
          name: 'Diamond',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/03/Cut_diamond.jpg',
          description: 'April birthstone known for enduring brilliance.',
        ),
        _ExploreRock(
          name: 'Emerald',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Emerald_gem2.jpg',
          description: 'May birthstone symbolizing renewal and growth.',
        ),
        _ExploreRock(
          name: 'Pearl',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/e/e8/Pearl_gem_02.jpg',
          description: 'June birthstone with luminous, organic beauty.',
        ),
        _ExploreRock(
          name: 'Ruby',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/c/cd/Ruby_gem.JPG',
          description: 'July birthstone tied to passion and courage.',
        ),
        _ExploreRock(
          name: 'Peridot',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/2/2f/Peridot-gem.JPG',
          description: 'August birthstone with bright green sparkle.',
        ),
        _ExploreRock(
          name: 'Sapphire',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/7a/Sapphire_gem.JPG',
          description: 'September birthstone signifying loyalty and truth.',
        ),
        _ExploreRock(
          name: 'Opal',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/1/10/Opal-Pietra.JPG',
          description: 'October birthstone famed for iridescent color play.',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final category in _categories)
            _CategorySection(category: category, theme: theme),
        ],
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({required this.category, required this.theme});

  final _ExploreCategory category;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category.title,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          for (final rock in category.rocks) _RockCard(rock: rock, theme: theme),
        ],
      ),
    );
  }
}

class _RockCard extends StatelessWidget {
  const _RockCard({required this.rock, required this.theme});

  final _ExploreRock rock;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              rock.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80,
                height: 80,
                color: Colors.black26,
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rock.name,
                  style:
                      theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  rock.description,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreCategory {
  const _ExploreCategory({required this.title, required this.rocks});

  final String title;
  final List<_ExploreRock> rocks;
}

class _ExploreRock {
  const _ExploreRock({
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  final String name;
  final String imageUrl;
  final String description;
}
