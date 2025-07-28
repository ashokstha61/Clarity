class SoundModel {
  final List<String> category;
  final String filepath;
  final String icon;
  final bool isFav;
  final bool isLocked;
  final bool isNew;
  final bool isSelected;
  final String musicURL;
  final String title;
  final double volume; // Assuming volume is a number (1 in the example)

  SoundModel({
    required this.category,
    required this.filepath,
    required this.icon,
    required this.isFav,
    required this.isLocked,
    required this.isNew,
    required this.isSelected,
    required this.musicURL,
    required this.title,
    required this.volume,
  });

  // Factory constructor to create a SoundModel from JSON
  factory SoundModel.fromJson(Map<String, dynamic> json) {
    return SoundModel(
      category: json['category'] != null ? List<String>.from(json['category']) : [],
      filepath: json['filepath'] ?? '',
      icon: json['icon'] ?? '',
      isFav: json['isFav'] ?? false,
      isLocked: json['isLocked'] ?? false,
      isNew: json['isNew'] ?? false,
      isSelected: json['isSelected'] ?? false,
      musicURL: json['musicURL'] ?? '',
      title: json['title'] ?? '',
      volume: (json['volume'] ?? 1.0).toDouble(), // Convert to double, default to 1.0
    );
  }

  // Method to convert SoundModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'filepath': filepath,
      'icon': icon,
      'isFav': isFav,
      'isLocked': isLocked,
      'isNew': isNew,
      'isSelected': isSelected,
      'musicURL': musicURL,
      'title': title,
      'volume': volume,
    };
  }
}