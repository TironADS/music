part of 'music_bloc.dart';

@immutable
abstract class MusicState {}

class MusicInitial extends MusicState {}

class MusicBlocLoading extends MusicState {}

class MusicBlocLoaded extends MusicState {}

class MusicBlocError extends MusicState {}
