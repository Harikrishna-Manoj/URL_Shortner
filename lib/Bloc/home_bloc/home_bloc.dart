import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial(url: '', dataFeatchingSuccess: false)) {
    final dio = Dio();
    late String shortedLink = '';
    on<GetShortedUrl>((event, emit) async {
      String url = event.url;
      if (url.isEmpty) {
        emit(const HomeInitial(url: '', dataFeatchingSuccess: false));
      }
      try {
        final Response response = await dio
            .post("https://cleanuri.com/api/v1/shorten", data: {"url": url});

        if (response.statusCode == 200) {
          shortedLink = response.data["result_url"];
          emit(HomeInitial(
            url: response.data["result_url"],
            dataFeatchingSuccess: true,
          ));
        } else {
          emit(const HomeInitial(url: '', dataFeatchingSuccess: false));
        }
      } catch (e) {
        emit(const HomeInitial(url: '', dataFeatchingSuccess: false));
      }
    });
    on<CopyToKeyboard>((event, emit) {
      Clipboard.setData(ClipboardData(text: shortedLink));
    });
  }
}
