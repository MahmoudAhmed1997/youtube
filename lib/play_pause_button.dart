import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

///
class PlayPauseButtonBar extends StatefulWidget {
  final bool ?v ;

  const PlayPauseButtonBar({Key? key, this.v}) : super(key: key);
  @override
  State<PlayPauseButtonBar> createState() => _PlayPauseButtonBarState();
}

class _PlayPauseButtonBarState extends State<PlayPauseButtonBar> {
  final ValueNotifier<bool> _isMuted = ValueNotifier(false);



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Visibility(
          visible: widget.v!,
          child: IconButton(
            icon: const Icon(Icons.skip_previous),
            onPressed: context.ytController.previousVideo,
          ),
        ),
        YoutubeValueBuilder(
          builder: (context, value) {
            return IconButton(
              icon: Icon(
                value.playerState == PlayerState.playing
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
              onPressed: value.isReady
                  ? () {
                if(value.playerState == PlayerState.playing){

                  setState(() {

                  });
                  context.ytController.pause();
                //  v = false;
                }else{

                  setState(() {

                  });
                  context.ytController.play();

                }
                // value.playerState == PlayerState.playing
                //     ? context.ytController.pause()
                //     : context.ytController.play();
                setState(() {

                });

              }
                  : null,
            );
          },
        ),

        IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: context.ytController.nextVideo,
        ),
      ],
    );
  }
}