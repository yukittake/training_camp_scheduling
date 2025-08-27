import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:training_camp_scheduling/presentation/state/camp_state.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';


class DownloadCsvButton extends ConsumerWidget {
  final int _campIndex;
  const DownloadCsvButton({
    super.key,
    required campIndex,
  }):
   _campIndex=campIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(onPressed: ()async{
        final campState=ref.read(campStateNotifierProvider);
        final encodedSchedule=campState[_campIndex].encodingSchedule();
        final dir = await getTemporaryDirectory();
        final path = '${dir.path}/schedule.csv';
        final file = File(path);
        await file.writeAsBytes(encodedSchedule, flush: true);

        await SharePlus.instance.share(
          ShareParams(
          files:  [XFile(file.path)],)
        );
      },
    style: ButtonStyle(
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColor.greyWidgetLine;
          }
          return null;
        },
      ),
    ),
    child: Text("CSVファイルをダウンロード",style: AppText.tappable,),
    );
  }
}