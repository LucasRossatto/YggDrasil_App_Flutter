import 'package:intl/intl.dart';

String formatarData(String dataIso) {
  try {
    final data = DateTime.parse(dataIso);
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(data);
  } catch (e) {
    return dataIso;
  }
}
