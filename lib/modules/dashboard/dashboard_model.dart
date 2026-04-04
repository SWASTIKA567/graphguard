import 'package:graph_guard/repomodel.dart';

class DashboardModel {
  final double riskScore;
  final int dependencies;
  final int vulnerabilities;

  DashboardModel({
    required this.riskScore,
    required this.dependencies,
    required this.vulnerabilities,
  });

  // ✅ Dashboard API se
  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    final stats = json['stats'] as Map<String, dynamic>;
    return DashboardModel(
      riskScore: (stats['riskScore'] ?? 0).toDouble(),
      dependencies: (stats['dependencies'] ?? 0) as int,
      vulnerabilities: (stats['vulnerabilities'] ?? 0) as int,
    );
  }

  // ✅ RepoModel se directly
  factory DashboardModel.fromRepo(RepoModel repo) {
    return DashboardModel(
      riskScore: repo.riskScore,
      dependencies: repo.dependencyCount,
      vulnerabilities: repo.vulnerabilityCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "riskScore": riskScore,
      "dependencies": dependencies,
      "vulnerabilities": vulnerabilities,
    };
  }
}
