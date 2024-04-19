Future<List<DateTime>> loadWatering(
    DateTime plantedDay, int giorni, DateTime harvestDate) async {
  List<DateTime> wateringDays = [];
  DateTime indexDate = plantedDay;
  while (indexDate.isBefore(harvestDate)) {
    wateringDays.add(indexDate);
    indexDate = indexDate.add(Duration(days: giorni));
  }
  return wateringDays;
}
