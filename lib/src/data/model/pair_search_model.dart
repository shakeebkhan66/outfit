class FilterPairModel {
  List<Pairs>? pairs;
  int? ptn;

  FilterPairModel({this.pairs, this.ptn});

  FilterPairModel.fromJson(Map<String, dynamic> json) {
    if (json['pairs'] != null) {
      pairs = <Pairs>[];
      json['pairs'].forEach((v) {
        pairs!.add(Pairs.fromJson(v));
      });
    }
    ptn = json['ptn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pairs != null) {
      data['pairs'] = pairs!.map((v) => v.toJson()).toList();
    }
    data['ptn'] = ptn;
    return data;
  }
}

class Pairs {
  int? type;
  int? color;

  Pairs({this.type, this.color});

  Pairs.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['color'] = color;
    return data;
  }
}