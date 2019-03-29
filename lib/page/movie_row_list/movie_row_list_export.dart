import 'package:bloc/bloc.dart';
import 'package:the_movies_flut/util/alog.dart';

export './movie_row_list_bloc.dart';
export './movie_row_list_event.dart';
export './movie_row_list_state.dart';
export './movie_row_list_widget.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    Alog.debug(transition);
  }
}
