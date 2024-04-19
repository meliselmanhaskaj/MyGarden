DateTime calculateHarvestDate(dynamic plantData) {
  List<String> parts = plantData["planted_day"].split('-');
  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);
  DateTime plantedDay = DateTime(year, month, day);
  int estimatedGrowingDays = plantData["estimated_growing_days"];
  DateTime harvestDate = plantedDay.add(Duration(days: estimatedGrowingDays));
  return harvestDate;
}
