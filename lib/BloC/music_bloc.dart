import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music/Repository/API/Music_Api.dart';

import '../Repository/Model_Class/MusicModel.dart';

part 'music_event.dart';

part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicAPI musicApi = MusicAPI();
  late MusicModel musicModel;

  MusicBloc() : super(MusicInitial()) {
    on<MusicEvent>((event, emit) async {
        emit (MusicBlocLoading());
        try{
          musicModel = await musicApi.getMusic();
          emit (MusicBlocLoaded());
        }catch(e){
          print(e);
          emit(MusicBlocError());
        }
    });
  }
}
