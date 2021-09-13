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

  List<dynamic> toData() {
    return [
      name,
      pixels.map((rows) {
        return rows.map((value) {
          return value == null ? 0 : value + 1;
        }).toList();
      }).toList(),
    ];
  }

  static ProjectSprite fromData(List<dynamic> data) {
    final name = data[0] as String;
    final pixelsData = data[1] as List<List<int>>;

    final pixels = pixelsData.map(
      (rows) {
        return rows.map((value) {
          return value == 0 ? null : value - 1;
        }).toList();
      },
    ).toList();

    return ProjectSprite(name: name, pixels: pixels);
  }
}
