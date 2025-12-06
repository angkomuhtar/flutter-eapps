class AppFeature {
  final String name;
  final String image;

  const AppFeature({required this.name, required this.image});
}

const List<AppFeature> appFeatures = [
  AppFeature(name: 'Feature 1', image: 'assets/images/feature1.png'),
  AppFeature(name: 'Feature 2', image: 'assets/images/feature2.png'),
  AppFeature(name: 'Feature 3', image: 'assets/images/feature3.png'),
];