class Video{
  final String name;
  final String url;
  final String thumbnailUrl;

  const Video({
    required this.name,
    required this.thumbnailUrl,
    required this.url,
});
}

const videos =[
  Video(
    name: 'Palette',
    url: 'https://www.youtube.com/watch?v=Ud73fm4Uoq0',
    thumbnailUrl: 'https://pbs.twimg.com/media/EwwgtSvVgAAgo6r?format=jpg&name=large',
    //thumbnailUrl: 'https://img.youtube.com/vi/Ud73fm4Uoq0/maxresdefault.jpg',
  ),
  Video(
    name: 'Error',
    url: 'https://www.youtube.com/watch?v=3UV8OZj2olg',
    thumbnailUrl: 'https://pbs.twimg.com/media/EdxkfgvU4AAd_hF?format=jpg&name=4096x4096',
    //humbnailUrl: 'https://img.youtube.com/vi/3UV8OZj2olg/maxresdefault.jpg',
  )
];