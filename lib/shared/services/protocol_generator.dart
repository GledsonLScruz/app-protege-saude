import 'dart:math';

class ProtocolGenerator {
  ProtocolGenerator({Random? random}) : _random = random ?? Random.secure();

  final Random _random;

  String generate({DateTime? now}) {
    final date = now ?? DateTime.now();
    final number = _random.nextInt(1000000).toString().padLeft(6, '0');
    return 'DEN-${date.year}-$number';
  }
}
