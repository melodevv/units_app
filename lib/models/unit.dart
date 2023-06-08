Map<dynamic, dynamic> convertTodoListToMap(List<Unit> units) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < units.length; i++) {
    map.addAll({'$i': units[i].toJson()});
  }
  return map;
}

List<Unit> convertMapToUnitList(Map<dynamic, dynamic> map) {
  List<Unit> units = [];
  for (var i = 0; i < map.length; i++) {
    units.add(Unit.fromJson(map['$i']));
  }
  return units;
}

class Unit {
  String unitDesc;
  String reflections;

  Unit({
    required this.unitDesc,
    required this.reflections,
  });

  Map<String, Object?> toJson() => {
        'unitDesc': unitDesc,
        'reflections': reflections,
      };

  static Unit fromJson(Map<dynamic, dynamic>? json) => Unit(
        unitDesc: json!['unitDesc'] as String,
        reflections: json['reflections'] as String,
      );

  @override
  bool operator ==(covariant Unit unit) {
    return (unitDesc.toUpperCase().compareTo(unit.unitDesc.toUpperCase()) == 0);
  }

  @override
  int get hashCode {
    return unitDesc.hashCode;
  }
}
