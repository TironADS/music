import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/BloC/music_bloc.dart';
import 'package:music/Repository/Model_Class/MusicModel.dart';
import 'package:just_audio/just_audio.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

bool clicked = false;
late MusicModel data;
late AudioPlayer _audioPlayer;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Center(
            child: Text(
          'Spotify 144p',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.green,
              child: Center(
                child: CircleAvatar(
                  radius: 50,backgroundColor: Colors.white,
                  child: Center(
                    child: CircleAvatar(
                      radius: 30,backgroundColor: Colors.green,
                      child: Center(
                        child: CircleAvatar(
                          radius: 10,backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<MusicBloc, MusicState>(
            builder: (context, state) {
              if (state is MusicBlocLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is MusicBlocError) {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<MusicBloc>(context).add(FetchMusic());
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                        child: Icon(
                      Icons.loop,
                      color: Colors.red,
                      size: 35,
                    )),
                  ),
                );
              }
              if (state is MusicBlocLoaded) {
                data = BlocProvider.of<MusicBloc>(context).musicModel;
                return Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector (

                      onTap: () {
                        setState(() {
                          clicked = !clicked;
                        });
                        _audioPlayer = AudioPlayer();
                        _audioPlayer.setUrl(data.results![0].Kbps.toString());
                        _audioPlayer.play();
                      },

                      child: clicked == false
                          ? Icon(
                              Icons.play_circle_rounded,
                              color: Colors.white,
                              size: 60,
                            )
                          : Icon(
                              Icons.pause_circle_filled_rounded,
                              color: Colors.white,
                              size: 60,
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _audioPlayer.stop();

                        });

                      },
                      child: Icon(
                        Icons.stop_circle,
                        color: Colors.white,
                        size: 55,
                      ),
                    ),
                  ],
                ),
                );

              } else {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<MusicBloc>(context).add(FetchMusic());
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                        child: Text(
                      'Play',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.green),
                    )),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
