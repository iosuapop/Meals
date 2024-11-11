enum Complexity {
  simple,
  challenging,
  hard,
}

enum Affordability {
  affordable,
  pricey,
  luxurious,
}

class Meal {
  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categories': categories,
      'title': title,
      'affordability': affordability.toString(),
      'complexity': complexity.toString(),
      'imageUrl': imageUrl,
      'duration': duration,
      'ingredients': ingredients,
      'steps': steps,
      'isGlutenFree': isGlutenFree,
      'isVegan': isVegan,
      'isVegetarian': isVegetarian,
      'isLactoseFree': isLactoseFree,
    };
  }

  static Meal fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      categories: List<String>.from(map['categories']),
      title: map['title'],
      affordability: _affordabilityFromString(map['affordability']),
      complexity: _complexityFromString(map['complexity']),
      imageUrl: map['imageUrl'],
      duration: map['duration'],
      ingredients: List<String>.from(map['ingredients']),
      steps: List<String>.from(map['steps']),
      isGlutenFree: map['isGlutenFree'],
      isVegan: map['isVegan'],
      isVegetarian: map['isVegetarian'],
      isLactoseFree: map['isLactoseFree'],
    );
    }

  static Affordability _affordabilityFromString(String affordability) {
  switch (affordability) {
    case 'Affordability.affordable':
      return Affordability.affordable;
    case 'Affordability.pricey':
      return Affordability.pricey;
    case 'Affordability.luxurious':
      return Affordability.luxurious;
    default:
      throw Exception('Unknown affordability: $affordability');
  }
  
  }

  static Complexity _complexityFromString(String complexity) {
  switch (complexity) {
    case 'Complexity.simple':
      return Complexity.simple;
    case 'Complexity.challenging':
      return Complexity.challenging;
    case 'Complexity.hard':
      return Complexity.hard;
    default:
      throw Exception('Unknown complexity: $complexity');
  }
  }
}