import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:muzzone/data/data.dart';

class AlbumRepository {
  static List<MyPlaylist> localAlbumsPlaylists = [
    MyPlaylist(
        isLanguage: false,
        id: 656,
        title: '1 album',
        audios: [
          /*Audio.network(
            'https://cdn.pixabay.com/download/audio/2022/01/20/audio_f1b4f4c8b1.mp3?filename=welcome-to-the-games-15238.mp3',
            metas: Metas(
              id: '8432',
              title: 'Welcome Here',
              artist: 'Ansh Rathod',
              album: 'OnlineAlbum',
              extra: {
                'isPopular': true,
                'isNew': false,
              },
              image: const MetasImage.network(
                  'https://images.unsplash.com/photo-1611339555312-e607c8352fd7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[0].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[0].id.toString(),
              title: LocalSongsRepository.localSongs[0].name,
              artist: LocalSongsRepository.localSongs[0].artists,
              album: LocalSongsRepository.localSongs[0].album,
              extra: {
                'isPopular': false,
                'isNew': true,
              },
              image: const MetasImage.network(
                  'https://upl.uz/uploads/posts/2021-08/1630148255_1613926133_snimok-ekrana-2020-12-30-v-22_49_04-768x441-min.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[1].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[1].id.toString(),
              title: LocalSongsRepository.localSongs[1].name,
              artist: LocalSongsRepository.localSongs[1].artists,
              album: LocalSongsRepository.localSongs[1].album,
              extra: {
                'isPopular': false,
                'isNew': false,
              },
              image: const MetasImage.network(
                  'https://cdnn1.img.sputnik.tj/img/07e6/01/14/1044968308_0:0:478:478_1920x0_80_0_0_9d807daefb1e7b77d29d8f1a91349de5.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[2].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[2].id.toString(),
              title: LocalSongsRepository.localSongs[2].name,
              artist: LocalSongsRepository.localSongs[2].artists,
              album: LocalSongsRepository.localSongs[2].album,
              extra: {
                'isPopular': true,
                'isNew': true,
              },
              image: const MetasImage.network(
                  'https://tbld.uz/wp-content/uploads/2021/01/eshhshh.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[3].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[3].id.toString(),
              title: LocalSongsRepository.localSongs[3].name,
              artist: LocalSongsRepository.localSongs[3].artists,
              album: LocalSongsRepository.localSongs[3].album,
              image: const MetasImage.network(
                  'https://cdnn1.img.sputniknews-uz.com/img/1270/16/12701668_420:0:1500:1080_1920x0_80_0_0_62e847ef33ce3cac9b1356c30c00d643.png'),
            ),
          ),*/
        ],
        isAlbum: true,
        isGenre: true,
        image: 'rap'),
    MyPlaylist(
        isLanguage: false,
        id: 5546,
        title: '2 album',
        audios: [
          /*Audio.network(
            'https://cdn.pixabay.com/download/audio/2022/01/20/audio_f1b4f4c8b1.mp3?filename=welcome-to-the-games-15238.mp3',
            metas: Metas(
              id: '8432',
              title: 'Welcome Here',
              artist: 'Ansh Rathod',
              album: 'OnlineAlbum',
              extra: {
                'isPopular': true,
                'isNew': false,
              },
              image: const MetasImage.network(
                  'https://images.unsplash.com/photo-1611339555312-e607c8352fd7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[0].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[0].id.toString(),
              title: LocalSongsRepository.localSongs[0].name,
              artist: LocalSongsRepository.localSongs[0].artists,
              album: LocalSongsRepository.localSongs[0].album,
              extra: {
                'isPopular': false,
                'isNew': true,
              },
              image: const MetasImage.network(
                  'https://upl.uz/uploads/posts/2021-08/1630148255_1613926133_snimok-ekrana-2020-12-30-v-22_49_04-768x441-min.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[1].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[1].id.toString(),
              title: LocalSongsRepository.localSongs[1].name,
              artist: LocalSongsRepository.localSongs[1].artists,
              album: LocalSongsRepository.localSongs[1].album,
              extra: {
                'isPopular': false,
                'isNew': false,
              },
              image: const MetasImage.network(
                  'https://cdnn1.img.sputnik.tj/img/07e6/01/14/1044968308_0:0:478:478_1920x0_80_0_0_9d807daefb1e7b77d29d8f1a91349de5.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[2].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[2].id.toString(),
              title: LocalSongsRepository.localSongs[2].name,
              artist: LocalSongsRepository.localSongs[2].artists,
              album: LocalSongsRepository.localSongs[2].album,
              extra: {
                'isPopular': true,
                'isNew': true,
              },
              image: const MetasImage.network(
                  'https://tbld.uz/wp-content/uploads/2021/01/eshhshh.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[3].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[3].id.toString(),
              title: LocalSongsRepository.localSongs[3].name,
              artist: LocalSongsRepository.localSongs[3].artists,
              album: LocalSongsRepository.localSongs[3].album,
              image: const MetasImage.network(
                  'https://cdnn1.img.sputniknews-uz.com/img/1270/16/12701668_420:0:1500:1080_1920x0_80_0_0_62e847ef33ce3cac9b1356c30c00d643.png'),
            ),
          ),*/
        ],
        isAlbum: true,
        isGenre: true,
        image: 'rock'),
    MyPlaylist(
        isLanguage: false,
        id: 5546,
        title: '3 album',
        audios: [
          /*Audio.network(
            'https://cdn.pixabay.com/download/audio/2022/01/20/audio_f1b4f4c8b1.mp3?filename=welcome-to-the-games-15238.mp3',
            metas: Metas(
              id: '8432',
              title: 'Welcome Here',
              artist: 'Ansh Rathod',
              album: 'OnlineAlbum',
              extra: {
                'isPopular': true,
                'isNew': false,
              },
              image: const MetasImage.network(
                  'https://images.unsplash.com/photo-1611339555312-e607c8352fd7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[0].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[0].id.toString(),
              title: LocalSongsRepository.localSongs[0].name,
              artist: LocalSongsRepository.localSongs[0].artists,
              album: LocalSongsRepository.localSongs[0].album,
              extra: {
                'isPopular': false,
                'isNew': true,
              },
              image: const MetasImage.network(
                  'https://upl.uz/uploads/posts/2021-08/1630148255_1613926133_snimok-ekrana-2020-12-30-v-22_49_04-768x441-min.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[1].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[1].id.toString(),
              title: LocalSongsRepository.localSongs[1].name,
              artist: LocalSongsRepository.localSongs[1].artists,
              album: LocalSongsRepository.localSongs[1].album,
              extra: {
                'isPopular': false,
                'isNew': false,
              },
              image: const MetasImage.network(
                  'https://cdnn1.img.sputnik.tj/img/07e6/01/14/1044968308_0:0:478:478_1920x0_80_0_0_9d807daefb1e7b77d29d8f1a91349de5.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[2].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[2].id.toString(),
              title: LocalSongsRepository.localSongs[2].name,
              artist: LocalSongsRepository.localSongs[2].artists,
              album: LocalSongsRepository.localSongs[2].album,
              extra: {
                'isPopular': true,
                'isNew': true,
              },
              image: const MetasImage.network(
                  'https://tbld.uz/wp-content/uploads/2021/01/eshhshh.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[3].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[3].id.toString(),
              title: LocalSongsRepository.localSongs[3].name,
              artist: LocalSongsRepository.localSongs[3].artists,
              album: LocalSongsRepository.localSongs[3].album,
              image: const MetasImage.network(
                  'https://cdnn1.img.sputniknews-uz.com/img/1270/16/12701668_420:0:1500:1080_1920x0_80_0_0_62e847ef33ce3cac9b1356c30c00d643.png'),
            ),
          ),*/
        ],
        isAlbum: true,
        isGenre: true,
        image: 'rock'),
    MyPlaylist(
        isLanguage: false,
        id: 5546,
        title: '4 album',
        audios: [
          /*Audio.network(
            'https://cdn.pixabay.com/download/audio/2022/01/20/audio_f1b4f4c8b1.mp3?filename=welcome-to-the-games-15238.mp3',
            metas: Metas(
              id: '8432',
              title: 'Welcome Here',
              artist: 'Ansh Rathod',
              album: 'OnlineAlbum',
              extra: {
                'isPopular': true,
                'isNew': false,
              },
              image: const MetasImage.network(
                  'https://images.unsplash.com/photo-1611339555312-e607c8352fd7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[0].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[0].id.toString(),
              title: LocalSongsRepository.localSongs[0].name,
              artist: LocalSongsRepository.localSongs[0].artists,
              album: LocalSongsRepository.localSongs[0].album,
              extra: {
                'isPopular': false,
                'isNew': true,
              },
              image: const MetasImage.network(
                  'https://upl.uz/uploads/posts/2021-08/1630148255_1613926133_snimok-ekrana-2020-12-30-v-22_49_04-768x441-min.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[1].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[1].id.toString(),
              title: LocalSongsRepository.localSongs[1].name,
              artist: LocalSongsRepository.localSongs[1].artists,
              album: LocalSongsRepository.localSongs[1].album,
              extra: {
                'isPopular': false,
                'isNew': false,
              },
              image: const MetasImage.network(
                  'https://cdnn1.img.sputnik.tj/img/07e6/01/14/1044968308_0:0:478:478_1920x0_80_0_0_9d807daefb1e7b77d29d8f1a91349de5.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[2].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[2].id.toString(),
              title: LocalSongsRepository.localSongs[2].name,
              artist: LocalSongsRepository.localSongs[2].artists,
              album: LocalSongsRepository.localSongs[2].album,
              extra: {
                'isPopular': true,
                'isNew': true,
              },
              image: const MetasImage.network(
                  'https://tbld.uz/wp-content/uploads/2021/01/eshhshh.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[3].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[3].id.toString(),
              title: LocalSongsRepository.localSongs[3].name,
              artist: LocalSongsRepository.localSongs[3].artists,
              album: LocalSongsRepository.localSongs[3].album,
              image: const MetasImage.network(
                  'https://cdnn1.img.sputniknews-uz.com/img/1270/16/12701668_420:0:1500:1080_1920x0_80_0_0_62e847ef33ce3cac9b1356c30c00d643.png'),
            ),
          ),*/
        ],
        isAlbum: true,
        isGenre: true,
        image: 'rock'),
    MyPlaylist(
        isLanguage: false,
        id: 5546,
        title: '5 album',
        audios: [
          /*Audio.network(
            'https://cdn.pixabay.com/download/audio/2022/01/20/audio_f1b4f4c8b1.mp3?filename=welcome-to-the-games-15238.mp3',
            metas: Metas(
              id: '8432',
              title: 'Welcome Here',
              artist: 'Ansh Rathod',
              album: 'OnlineAlbum',
              extra: {
                'isPopular': true,
                'isNew': false,
              },
              image: const MetasImage.network(
                  'https://images.unsplash.com/photo-1611339555312-e607c8352fd7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[0].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[0].id.toString(),
              title: LocalSongsRepository.localSongs[0].name,
              artist: LocalSongsRepository.localSongs[0].artists,
              album: LocalSongsRepository.localSongs[0].album,
              extra: {
                'isPopular': false,
                'isNew': true,
              },
              image: const MetasImage.network(
                  'https://upl.uz/uploads/posts/2021-08/1630148255_1613926133_snimok-ekrana-2020-12-30-v-22_49_04-768x441-min.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[1].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[1].id.toString(),
              title: LocalSongsRepository.localSongs[1].name,
              artist: LocalSongsRepository.localSongs[1].artists,
              album: LocalSongsRepository.localSongs[1].album,
              extra: {
                'isPopular': false,
                'isNew': false,
              },
              image: const MetasImage.network(
                  'https://cdnn1.img.sputnik.tj/img/07e6/01/14/1044968308_0:0:478:478_1920x0_80_0_0_9d807daefb1e7b77d29d8f1a91349de5.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[2].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[2].id.toString(),
              title: LocalSongsRepository.localSongs[2].name,
              artist: LocalSongsRepository.localSongs[2].artists,
              album: LocalSongsRepository.localSongs[2].album,
              extra: {
                'isPopular': true,
                'isNew': true,
              },
              image: const MetasImage.network(
                  'https://tbld.uz/wp-content/uploads/2021/01/eshhshh.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[3].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[3].id.toString(),
              title: LocalSongsRepository.localSongs[3].name,
              artist: LocalSongsRepository.localSongs[3].artists,
              album: LocalSongsRepository.localSongs[3].album,
              image: const MetasImage.network(
                  'https://cdnn1.img.sputniknews-uz.com/img/1270/16/12701668_420:0:1500:1080_1920x0_80_0_0_62e847ef33ce3cac9b1356c30c00d643.png'),
            ),
          ),*/
        ],
        isAlbum: true,
        isGenre: true,
        image: 'rock'),
    MyPlaylist(
        isLanguage: false,
        id: 5546,
        title: '6 album',
        audios: [
          /*Audio.network(
            'https://cdn.pixabay.com/download/audio/2022/01/20/audio_f1b4f4c8b1.mp3?filename=welcome-to-the-games-15238.mp3',
            metas: Metas(
              id: '8432',
              title: 'Welcome Here',
              artist: 'Ansh Rathod',
              album: 'OnlineAlbum',
              extra: {
                'isPopular': true,
                'isNew': false,
              },
              image: const MetasImage.network(
                  'https://images.unsplash.com/photo-1611339555312-e607c8352fd7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[0].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[0].id.toString(),
              title: LocalSongsRepository.localSongs[0].name,
              artist: LocalSongsRepository.localSongs[0].artists,
              album: LocalSongsRepository.localSongs[0].album,
              extra: {
                'isPopular': false,
                'isNew': true,
              },
              image: const MetasImage.network(
                  'https://upl.uz/uploads/posts/2021-08/1630148255_1613926133_snimok-ekrana-2020-12-30-v-22_49_04-768x441-min.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[1].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[1].id.toString(),
              title: LocalSongsRepository.localSongs[1].name,
              artist: LocalSongsRepository.localSongs[1].artists,
              album: LocalSongsRepository.localSongs[1].album,
              extra: {
                'isPopular': false,
                'isNew': false,
              },
              image: const MetasImage.network(
                  'https://cdnn1.img.sputnik.tj/img/07e6/01/14/1044968308_0:0:478:478_1920x0_80_0_0_9d807daefb1e7b77d29d8f1a91349de5.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[2].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[2].id.toString(),
              title: LocalSongsRepository.localSongs[2].name,
              artist: LocalSongsRepository.localSongs[2].artists,
              album: LocalSongsRepository.localSongs[2].album,
              extra: {
                'isPopular': true,
                'isNew': true,
              },
              image: const MetasImage.network(
                  'https://tbld.uz/wp-content/uploads/2021/01/eshhshh.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[3].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[3].id.toString(),
              title: LocalSongsRepository.localSongs[3].name,
              artist: LocalSongsRepository.localSongs[3].artists,
              album: LocalSongsRepository.localSongs[3].album,
              image: const MetasImage.network(
                  'https://cdnn1.img.sputniknews-uz.com/img/1270/16/12701668_420:0:1500:1080_1920x0_80_0_0_62e847ef33ce3cac9b1356c30c00d643.png'),
            ),
          ),*/
        ],
        isAlbum: true,
        isGenre: true,
        image: 'rock'),
    MyPlaylist(
        isLanguage: false,
        id: 5546,
        title: '7 album',
        audios: [
          /*Audio.network(
            'https://cdn.pixabay.com/download/audio/2022/01/20/audio_f1b4f4c8b1.mp3?filename=welcome-to-the-games-15238.mp3',
            metas: Metas(
              id: '8432',
              title: 'Welcome Here',
              artist: 'Ansh Rathod',
              album: 'OnlineAlbum',
              extra: {
                'isPopular': true,
                'isNew': false,
              },
              image: const MetasImage.network(
                  'https://images.unsplash.com/photo-1611339555312-e607c8352fd7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[0].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[0].id.toString(),
              title: LocalSongsRepository.localSongs[0].name,
              artist: LocalSongsRepository.localSongs[0].artists,
              album: LocalSongsRepository.localSongs[0].album,
              extra: {
                'isPopular': false,
                'isNew': true,
              },
              image: const MetasImage.network(
                  'https://upl.uz/uploads/posts/2021-08/1630148255_1613926133_snimok-ekrana-2020-12-30-v-22_49_04-768x441-min.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[1].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[1].id.toString(),
              title: LocalSongsRepository.localSongs[1].name,
              artist: LocalSongsRepository.localSongs[1].artists,
              album: LocalSongsRepository.localSongs[1].album,
              extra: {
                'isPopular': false,
                'isNew': false,
              },
              image: const MetasImage.network(
                  'https://cdnn1.img.sputnik.tj/img/07e6/01/14/1044968308_0:0:478:478_1920x0_80_0_0_9d807daefb1e7b77d29d8f1a91349de5.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[2].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[2].id.toString(),
              title: LocalSongsRepository.localSongs[2].name,
              artist: LocalSongsRepository.localSongs[2].artists,
              album: LocalSongsRepository.localSongs[2].album,
              extra: {
                'isPopular': true,
                'isNew': true,
              },
              image: const MetasImage.network(
                  'https://tbld.uz/wp-content/uploads/2021/01/eshhshh.png'),
            ),
          ),
          Audio.network(
            LocalSongsRepository.localSongs[3].audio,
            metas: Metas(
              id: LocalSongsRepository.localSongs[3].id.toString(),
              title: LocalSongsRepository.localSongs[3].name,
              artist: LocalSongsRepository.localSongs[3].artists,
              album: LocalSongsRepository.localSongs[3].album,
              image: const MetasImage.network(
                  'https://cdnn1.img.sputniknews-uz.com/img/1270/16/12701668_420:0:1500:1080_1920x0_80_0_0_62e847ef33ce3cac9b1356c30c00d643.png'),
            ),
          ),*/
        ],
        isAlbum: true,
        isGenre: true,
        image: 'rock'),
  ];
}
