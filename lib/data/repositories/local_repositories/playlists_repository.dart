import 'package:muzzone/data/data.dart';
import 'package:muzzone/ui/controllers/controllers.dart';

class LocalPlaylistsRepository {
  static List<MyPlaylist> localPlaylists = [
    MyPlaylist(
        id: 878,
        title: 'Узбекские',
        audios: [
          MainController().audios[0],
          MainController().audios[1],
          MainController().audios[2]
        ],
        image: '111',
        isGenre: false,
        isAlbum: false,
        isLanguage: true),
    MyPlaylist(
        id: 878,
        title: 'Русские',
        audios: [
          MainController().audios[0],
          MainController().audios[1],
          MainController().audios[2]
        ],
        image: '111',
        isGenre: false,
        isAlbum: false,
        isLanguage: true),
    MyPlaylist(
        id: 878,
        title: 'Английские',
        audios: [
          MainController().audios[0],
          MainController().audios[1],
          MainController().audios[2]
        ],
        image: '111',
        isGenre: false,
        isAlbum: false,
        isLanguage: true),
    MyPlaylist(
        isLanguage: false,
        isGenre: true,
        isAlbum: false,
        id: 9929,
        title: 'По жанру',
        audios: [
          MainController().audios[0],
          MainController().audios[1],
          MainController().audios[2]
        ],
        image: '111'),
    MyPlaylist(
      isLanguage: false,
      isGenre: false,
      isAlbum: false,
      id: 2432,
      title: 'Популярные',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
      image: '222',
    ),
    MyPlaylist(
      isLanguage: false,
      isGenre: false,
      isAlbum: false,
      id: 234,
      title: 'Мой плейлист',
      audios: [
        MainController().audios[0],
        MainController().audios[3],
        MainController().audios[1],
        MainController().audios[0],
        MainController().audios[3],
        MainController().audios[2],
      ],
      image: '333',
    ),
    MyPlaylist(
      isLanguage: false,
      isGenre: false,
      isAlbum: false,
      id: 756,
      title: 'Новинки',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
      image: '444',
    ),
    MyPlaylist(
        isLanguage: false,
        isGenre: false,
        isAlbum: false,
        id: 333,
        title: 'Русские',
        audios: [
          MainController().audios[0],
          MainController().audios[1],
          MainController().audios[2]
        ],
        image: '111'),
    MyPlaylist(
      isLanguage: false,
      isGenre: false,
      isAlbum: false,
      id: 76,
      title: 'Плейлист дня',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
      image: '222',
    ),
    MyPlaylist(
      isLanguage: false,
      isGenre: false,
      isAlbum: false,
      id: 34534,
      title: 'Танцевальная',
      audios: [
        MainController().audios[0],
        MainController().audios[3],
        MainController().audios[1],
        MainController().audios[0],
        MainController().audios[3],
        MainController().audios[2],
      ],
      image: '333',
    ),
    MyPlaylist(
      isLanguage: false,
      isGenre: false,
      isAlbum: false,
      id: 3214,
      title: 'Рэпчик',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
      image: '444',
    ),
    MyPlaylist(
      isLanguage: false,
      isGenre: true,
      isAlbum: true,
      title: '222',
      id: 343,
      image: 'Альтернатива',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2],
        MainController().audios[3],
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 24555,
      title: 'Блюз',
      isGenre: true,
      isAlbum: true,
      image: '222',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 4324,
      image: '222',
      title: 'Поп-Музыка',
      isGenre: true,
      isAlbum: true,
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 4545,
      image: '222',
      title: 'Дабстеп',
      isGenre: true,
      isAlbum: true,
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      image: '222',
      id: 876,
      title: 'Детская музыка',
      isGenre: true,
      isAlbum: true,
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 9584,
      image: '222',
      title: 'Все жанры',
      isGenre: true,
      isAlbum: true,
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 343,
      isGenre: true,
      isAlbum: true,
      image: '222',
      title: 'Альтернатива',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 24555,
      title: 'Блюз',
      isGenre: true,
      isAlbum: true,
      image: '222',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 4324,
      isGenre: true,
      isAlbum: true,
      image: '222',
      title: 'Поп-Музыка',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 4545,
      isGenre: true,
      isAlbum: true,
      image: '222',
      title: 'Дабстеп',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 876,
      isGenre: true,
      isAlbum: true,
      title: 'Детская музыка',
      image: '222',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 9584,
      title: 'Все жанры',
      isGenre: true,
      isAlbum: true,
      image: '222',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 343,
      isGenre: true,
      isAlbum: true,
      title: 'Альтернатива',
      image: '222',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      image: '222',
      id: 24555,
      isGenre: true,
      isAlbum: true,
      title: 'Блюз',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      isGenre: true,
      isAlbum: true,
      id: 4324,
      image: '222',
      title: 'Поп-Музыка',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 4545,
      image: '222',
      title: 'Дабстеп',
      isGenre: true,
      isAlbum: true,
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 876,
      isGenre: true,
      isAlbum: true,
      image: '222',
      title: 'Детская музыка',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 9584,
      isGenre: true,
      isAlbum: true,
      image: '222',
      title: 'Все жанры',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      isGenre: true,
      isAlbum: true,
      id: 343,
      image: '222',
      title: 'Альтернатива',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 24555,
      isGenre: true,
      isAlbum: true,
      title: 'Блюз',
      image: '222',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 4324,
      image: '222',
      title: 'Поп-Музыка',
      isGenre: true,
      isAlbum: true,
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 4545,
      image: '222',
      title: 'Дабстеп',
      isGenre: true,
      isAlbum: true,
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
    MyPlaylist(
      isLanguage: false,
      id: 876,
      isGenre: true,
      isAlbum: true,
      image: '222',
      title: 'Детская музыка',
      audios: [
        MainController().audios[0],
        MainController().audios[1],
        MainController().audios[2]
      ],
    ),
  ];
}
