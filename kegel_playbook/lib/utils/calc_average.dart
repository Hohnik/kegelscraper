double calcAverage(List<num> numbers) {
  if (numbers.isEmpty) return 0;
  final total = numbers.fold<double>(0, (sum, number) => sum + number);
  return total / numbers.length;
}
