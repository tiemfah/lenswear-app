class Prediction {
  Map<String, double> predictions;

  Prediction({required this.predictions});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      predictions: Map<String, double>.from(json['predictions']),
    );
  }

  @override
  String toString() {
    return "predictions: $predictions";
  }
}
