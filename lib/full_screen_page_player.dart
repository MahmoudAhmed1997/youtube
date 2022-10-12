import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:youtube_quality/meta_dat.dart';
import 'package:youtube_quality/play_pause_button.dart';
import 'model/youtube_model.dart';

class YoutubePlayerDemo extends StatefulWidget {
  const YoutubePlayerDemo({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _YoutubePlayerDemoState createState() => _YoutubePlayerDemoState();
}

class _YoutubePlayerDemoState extends State<YoutubePlayerDemo> {
  late YoutubePlayerController _ytbPlayerController;
  bool v = true;
  bool vi = true;
  List<YoutubeModel> videosList = [
    const YoutubeModel(id: 1, youtubeId: 'jA14r2ujQ7s'),
    const YoutubeModel(id: 2, youtubeId: 'UQGoVB_zMYQ'),
    const YoutubeModel(id: 3, youtubeId: 'FLcRb289uEM'),
    const YoutubeModel(id: 4, youtubeId: 'g2nMKzhkvxw'),
    const YoutubeModel(id: 5, youtubeId: 'qoDPvFAk2Vg'),
  ];

  @override
  void initState() {
    super.initState();
    _ytbPlayerController = YoutubePlayerController(
      initialVideoId: 'adB9_iRaldM',

      params: YoutubePlayerParams(

        playlist: [
          'adB9_iRaldM',
          "MnrJzXM7a6o",
          "FTQbiNvZqaY",
          "iYKXdt0LRs8",
        ],
        //startAt: Duration(minutes: 1, seconds: 5),
        showControls: vi,
        showFullscreenButton: true,
        autoPlay: true,
        strictRelatedVideos: true

      ),
    )..listen((value) {
      if (value.playerState == PlayerState.buffering) {
        String _time(Duration duration) {
          return "${duration.inMinutes}:${duration.inSeconds}";
        }

        Future.delayed(Duration(milliseconds: 1000), () {
          final bufferedTime = _ytbPlayerController.value.position;
          return print("${_time(bufferedTime)}");
        });
      }

      if (value.isReady && !value.hasPlayed) {
        _ytbPlayerController
          ..hidePauseOverlay()
          ..play()
          ..hideTopMenu() ;




      }
    });
    _ytbPlayerController.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    };
    _ytbPlayerController.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    };
    // _ytbPlayerController.onEnterFullscreen = () {
    //   SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.landscapeLeft,
    //     DeviceOrientation.landscapeRight,
    //   ]);
    // };
    // _ytbPlayerController.onExitFullscreen = () {
    // };
  }


  @override
  void dispose() {
    super.dispose();

    _setOrientation([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _ytbPlayerController.close();
  }

  _setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {

    });
    _ytbPlayerController  ;
  }
  @override
  Widget build(BuildContext context) {
    _ytbPlayerController;

    return
      Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
             i_buildYtbView(),

             // _buildMoreVideoTitle(),
             // _buildMoreVideosView(),
          ],
        ),
      ),
    );
  }

  Widget i_buildYtbView() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: _ytbPlayerController != null
          ? Column(
            children: [
              Stack(
        children: [
              YoutubePlayerIFrame(
                aspectRatio: 16/9,

                controller: _ytbPlayerController,


              ),

              Positioned(
                top: 50,bottom: 50,right: MediaQuery.of(context).size.width*0.15,left: MediaQuery.of(context).size.width*0.15,
                child: YoutubePlayerControllerProvider(
                    controller: _ytbPlayerController,

                    child:  Column(children: [
                      YoutubeValueBuilder(
                        builder: (context,value){
                          return Visibility(
                            visible:  _ytbPlayerController.value.playerState == PlayerState.paused?true:false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const  Icon( Icons.skip_previous,color: Colors.white,size: 35, ),
                                  onPressed: _ytbPlayerController.previousVideo,
                                ),
                                SizedBox(width: 170,),

                                IconButton(
                                  icon: const Icon(Icons.skip_next,color: Colors.white,size: 35,),
                                  onPressed: _ytbPlayerController.nextVideo,
                                ),

                              ],
                            ),);
                        },

                      ),



                    ],)
                ),),



        ],

              ),

            ],
          )
          : const Center(child:   CircularProgressIndicator()),
    );
  }


}