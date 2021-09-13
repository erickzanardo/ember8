part of 'project.dart';

class ProjectSprite extends Equatable {
  final String name;
  final List<List<int?>> pixels;

  const ProjectSprite({
    required this.name,
    required this.pixels,
  });

  @override
  List<Object?> get props => [name, pixels];

  ProjectSprite copyWithNewPixels(List<List<int?>> pixels) {
    return ProjectSprite(name: name, pixels: pixels);
  }
}
