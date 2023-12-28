class Task {
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final int reward;
  final int level;

  Task(
    this.name,
    this.description,
    this.latitude,
    this.longitude,
    this.reward,
    this.level,
  );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'reward': reward,
      'level': level,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['name'],
      json['description'],
      json['latitude'],
      json['longitude'],
      json['reward'],
      json['level'],
    );
  }
}
