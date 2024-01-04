class Task {
  final String name;
  final String description;
  final String map;
  final int reward;
  final int level;
  final String url;

  Task(
    this.name,
    this.description,
    this.map,
    this.reward,
    this.level,
    this.url,
  );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'map': map,
      'reward': reward,
      'level': level,
      'url': url,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['name'],
      json['description'],
      json['map'],
      json['reward'],
      json['level'],
      json['url'],
    );
  }
}
