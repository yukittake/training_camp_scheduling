import 'package:training_camp_scheduling/domain/entities/band.dart';
import 'package:training_camp_scheduling/infrastructure/hive_classes/hive_band.dart';

extension BandToHive on Band {
  HiveBand toHive() => HiveBand(
    bandTitle: bandTitle,
    members: members.cast<String>(),
    open: open
  );
}

extension HiveToBand on HiveBand {
  Band toDomain() => Band(
    bandTitle: bandTitle,
    members: members.cast<String>(),
    open: open,
  );
}