class Recipes {
  int id;
  String name;
  String picture;
  String description;

  Recipes({
    required this.id,
    required this.name,
    required this.picture,
    required this.description,
  });

  factory Recipes.fromJson(Map<String, dynamic> json) {
    return Recipes(
        id: json["id"],
        name: json["name"],
        picture: json["picture"],
        description: json["description"],
    );
  }
}