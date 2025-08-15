class MediaModel {
  final String image;
  final String? audio;
  final String number;

  MediaModel({
    required this.image,
    this.audio,
    required this.number,
  });
}

class MediaData {
  static final List<MediaModel> mediaList = [
    MediaModel(image: 'assets/sifir.jpg', audio: 'sifir.mp3', number: '0'),
    MediaModel(image: 'assets/bir.jpg', audio: 'bir.mp3', number: '1'),
    MediaModel(image: 'assets/iki.jpg', audio: 'iki.mp3', number: '2'),
    MediaModel(image: 'assets/uc.jpg', audio: 'uc.mp3', number: '3'),
    MediaModel(image: 'assets/dort.jpg', audio: 'dort.mp3', number: '4'),
    MediaModel(image: 'assets/bes.jpg', audio: 'bes.mp3', number: '5'),
    MediaModel(image: 'assets/alti.jpg', audio: 'alti.mp3', number: '6'),
    MediaModel(image: 'assets/yedi.jpg', audio: 'yedi.mp3', number: '7'),
    MediaModel(image: 'assets/sekiz.jpg', audio: 'sekiz.mp3', number: '8'),
    MediaModel(image: 'assets/dokuz.jpg', audio: 'dokuz.mp3', number: '9'),
  ];

  static final List<MediaModel> mediaListWithoutAudio = [
    MediaModel(image: 'assets/sifir.jpg', number: '0'),
    MediaModel(image: 'assets/bir.jpg', number: '1'),
    MediaModel(image: 'assets/iki.jpg', number: '2'),
    MediaModel(image: 'assets/uc.jpg', number: '3'),
    MediaModel(image: 'assets/dort.jpg', number: '4'),
    MediaModel(image: 'assets/bes.jpg', number: '5'),
    MediaModel(image: 'assets/alti.jpg', number: '6'),
    MediaModel(image: 'assets/yedi.jpg', number: '7'),
    MediaModel(image: 'assets/sekiz.jpg', number: '8'),
    MediaModel(image: 'assets/dokuz.jpg', number: '9'),
  ];
}
