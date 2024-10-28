class ItemModel {
  final String name;
  final String id;

  ItemModel({required this.name, required this.id});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
