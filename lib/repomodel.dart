class RepoModel {
  final String id;
  final String name;
  final String url;
  final int stars;
  final int forks;
  final String language;
  final double riskScore;

  final int vulnerabilityCount;
  final int dependencyCount;
  final String status;
  final bool webhookEnabled;
  final int scanCount;
  final DateTime? lastScanned;

  RepoModel({
    required this.id,
    required this.name,
    required this.url,
    required this.stars,
    required this.forks,
    required this.language,
    required this.riskScore,
    required this.vulnerabilityCount,
    required this.dependencyCount,
    required this.status,
    required this.webhookEnabled,
    required this.scanCount,
    required this.lastScanned,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      url: json["url"] ?? "",
      stars: json["stars"] ?? 0,
      forks: json["forks"] ?? 0,
      language: json["language"] ?? "Unknown",
      riskScore: (json["riskScore"] ?? 0).toDouble(),
      vulnerabilityCount: json["vulnerabilityCount"] ?? 0,
      dependencyCount: json["dependencyCount"] ?? 0,
      status: json["status"] ?? "unknown",
      webhookEnabled: json["webhookEnabled"] ?? false,
      scanCount: json["scanCount"] ?? 0,
      lastScanned: json["lastScanned"] != null
          ? DateTime.parse(json["lastScanned"])
          : null,
    );
  }

  String get riskLevel {
    if (riskScore < 3) return "Low";
    if (riskScore < 7) return "Medium";
    return "High";
  }
}
