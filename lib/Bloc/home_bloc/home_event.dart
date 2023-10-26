part of 'home_bloc.dart';

class HomeEvent {}

class GetShortedUrl extends HomeEvent {
  final String url;
  final BuildContext context;

  GetShortedUrl(this.url, this.context);
}

class CopyToKeyboard extends HomeEvent {}
