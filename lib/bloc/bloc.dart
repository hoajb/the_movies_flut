import 'package:bloc/bloc.dart';
import 'package:the_movies_flut/util/alog.dart';

export './listdatastate.dart';
export './movies_bloc.dart';
export './movies_event.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    Alog.debug(transition);
  }
}
