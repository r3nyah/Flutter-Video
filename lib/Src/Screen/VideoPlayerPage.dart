import 'package:flutter/material.dart';
import '../Service/Model/Model.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  int _currentIndex = 0;

  void _playVideo({
    int index = 0,
    bool init = false,
}){
    if(index < 0 || index >= videos.length) return;
    if(!init){
      _controller.pause();
    }
    setState((){
      _currentIndex = index;
    });
    _controller = VideoPlayerController.network(videos[_currentIndex].url)
      ..addListener(() => setState((){}))
      ..setLooping(true)
      ..initialize().then((value) => _controller.play());
}
  @override
  void initState(){
    super.initState();
    _playVideo(init: true);
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player',style: TextStyle(color: Colors.purpleAccent),)
      ),
      body: Column(
        children: [
          Container(
            color: Colors.deepPurple,
            height: 300,
            child: _controller.value.isInitialized
              ? Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: VideoPlayer(_controller),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _controller,
                        builder: (context, VideoPlayerValue value, child){
                          return Text(
                            _videoDuration(value.position),
                            style: const TextStyle(color: Colors.purpleAccent),
                          );
                        }
                    ),
                    Expanded(
                      child: VideoProgressIndicator(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 10,
                        ),
                        _controller,
                        allowScrubbing: true,
                      ),
                    ),
                    Text(
                      _videoDuration(
                        _controller.value.duration,
                      ),
                      style: const TextStyle(color: Colors.purpleAccent),
                    )
                  ],
                ),
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                    color: Colors.purpleAccent,
                    size: 40,
                  ),
                  onPressed: (){
                    setState(() {
                      _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                    });
                  },
                )
              ],
            ):const Center(
              child: CircularProgressIndicator(color: Colors.purpleAccent,),
            ),
          ),
          Expanded(
            child: ListView.builder(itemBuilder: (context,index){
              return InkWell(
                onTap: ()=>_playVideo(index: index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          videos[index].thumbnailUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: videos.length,
            ),
          )
        ]
      )
    );
  }

  String _videoDuration(Duration duration){
    String twoDigits(int n)=>n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if(duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
