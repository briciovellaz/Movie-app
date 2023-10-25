import '../../util/strings.dart' as strings;

mixin AdultParameter{
  bool? adult;

  String get adultParam => '${strings.apiAdult}${_getValue()}';

  String _getValue()=> (adult!=null && adult!) ? 'true' : 'false';
}
