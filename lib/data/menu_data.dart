import 'package:Cook.in/models/menu.dart';

var menuList = [
  Menu(
    nama: 'Nasi Goreng Kampung',
    deskripsi:
    'Nasi goreng kampung adalah hidangan khas Indonesia yang sederhana namun kaya rasa. Dibuat dari nasi putih yang digoreng dengan bawang, cabai, dan bumbu tradisional, nasi goreng ini menghadirkan cita rasa gurih dan pedas yang autentik, sering disajikan dengan telur, ikan asin, atau lauk rumahan lainnya.',
    bahan: '1 piring nasi putih\n 1 butir telur\n  2 siung bawang putih\n 3 siung bawang merah\n 1 sdm kecap manis\n  1 sdm kecap manis\n Garam & minyak secukupnya',
    carabuat: '1. Kupas bawang putih dan bawang merah, lalu haluskan menggunakan ulekan atau blender.\n 2. Panaskan wajan di atas api sedang, tuangkan 2 sdm minyak goreng.\n 3. Masukkan bumbu halus, tumis sambil diaduk hingga harum dan berubah warna kekuningan.\n 4. Pecahkan telur ke dalam wajan, aduk cepat hingga telur matang dan berbutir.\n 5. Masukkan nasi putih, aduk dan tekan perlahan agar nasi terurai.\n 6. Tambahkan kecap manis dan garam, aduk hingga bumbu tercampur rata. \n 7. Masak selama 2–3 menit hingga nasi panas merata.\n 8. Angkat dan sajikan selagi hangat.',
    imageAsset: 'images/nasigorengkpg.jpg',
    tipe: 'Makanan Berat',
    imageUrls: [
      'images/sateayam.jpeg',
      'images/nasiuduk.jpg',
      'images/tempegorengtepung.jpg',
      'images/ikanbakarbumbukecap.jpg',
    ],
    isFavorite: false,
  ),
  Menu(
    nama: 'Ayam Goreng Lengkuas',
    deskripsi:
    'Ayam goreng lengkuas adalah hidangan khas Indonesia yang terbuat dari ayam berbumbu rempah, terutama lengkuas parut, bawang putih, dan ketumbar. Ayam dimasak hingga bumbu meresap lalu digoreng sampai kecokelatan, menghasilkan cita rasa gurih, aroma rempah yang harum, serta tekstur renyah di luar dan empuk di dalam.',
    bahan: '500 g ayam potong\n 2 batang lengkuas parut\n 3 siung bawang putih\n 1 sdt ketumbar\n Garam & air secukupnya',
    carabuat: '1. Haluskan bawang putih dan ketumbar. \n 2. Masukkan ayam ke dalam panci, tambahkan bumbu halus, lengkuas parut, garam, dan air hingga ayam terendam. \n 3. Rebus ayam dengan api sedang hingga air menyusut dan bumbu meresap.\n 4. Panaskan minyak goreng dalam jumlah banyak. \n 5. Goreng ayam hingga berwarna keemasan dan kulitnya kering.\n 6. Goreng sisa lengkuas hingga renyah sebagai taburan.\n 7. Sajikan ayam dengan taburan lengkuas goreng.',
    imageAsset: 'images/ayamgorenglks.jpg',
    tipe: 'Makanan Berat',
    imageUrls: [
      'images/sotoayam.jpeg',
      'images/sateayam.jpeg',
      'images/miegorengjawa.jpg',
      'images/ikanpepes.jpg',
    ],
    isFavorite: false,
  ),
  Menu(
    nama: 'Soto Ayam',
    deskripsi:
    'Soto ayam adalah sup khas Indonesia berbahan dasar kaldu ayam berbumbu rempah, disajikan hangat dengan suwiran ayam, bihun, dan pelengkap, menghadirkan rasa segar dan gurih yang nikmat.',
    bahan: '½ ekor ayam\n 2 siung bawang putih\n 3 siung bawang merah\n 1 batang serai\n Garam & merica',
    carabuat: '1. Rebus ayam hingga matang, angkat lalu suwir dagingnya.\n 2. Haluskan bawang putih dan bawang merah.\n 3. Tumis bumbu halus hingga harum, masukkan serai yang telah dimemarkan.\n 4. Masukkan tumisan bumbu ke dalam air rebusan ayam.\n 5. Masukkan ayam suwir, bumbui dengan garam dan merica.\n 6. Masak dengan api kecil selama 10 menit agar kuah gurih.\n 7. Sajikan soto selagi hangat.',
    imageAsset: 'images/sotoayam.jpeg',
    tipe: 'Makanan Berat',
    imageUrls: [
      'images/ikanpepes.jpg',
      'images/ayamgorenglks.jpg',
      'images/rawondaging.jpg',
      'images/ikanpepes.jpg',
    ],
    isFavorite: false,
  ),
  Menu(
    nama: 'Mie Goreng Jawa',
    deskripsi:
    'Mie goreng khas Jawa dengan cita rasa gurih manis, dimasak menggunakan bumbu tradisional, telur, sayuran segar, dan sentuhan kecap yang harum menggugah selera.',
    bahan: '1 porsi mie telur\n 1 butir telur\n 2 siung bawang putih\n Kecap manis\n Garam.',
    carabuat: '1. Rebus mie hingga setengah matang, tiriskan.\n 2. Haluskan bawang putih.\n 3. Panaskan minyak, tumis bawang hingga harum.\n 4. Masukkan telur, orak-arik hingga matang.\n 5. Masukkan mie, kecap manis, dan garam.\n 6. Aduk rata dan masak hingga mie matang sempurna.\n 7. Angkat dan sajikan.',
    imageAsset: 'images/miegorengjawa.jpg',
    tipe: 'Makanan Berat',
    imageUrls: [
      'images/sateayam.jpeg',
      'images/nasiuduk.jpg',
      'images/rawondaging.jpg',
      'images/ikanbakarbumbukecao.jpg',
    ],
    isFavorite: false,
  ),
  Menu(
    nama: 'Rawon Daging',
    deskripsi:
    'Rawon adalah sup daging khas Jawa Timur dengan kuah hitam dari kluwek dan rasa rempah yang kuat.',
    bahan: '500 g daging sapi\n 4 buah kluwek\n 3 siung bawang putih\n 5 siung bawang merah\n 1 batang serai\n Garam secukupnya.',
    carabuat: '1. Rebus daging hingga empuk, potong-potong.\n 2. Haluskan bawang putih, bawang merah, dan kluwek.\n 3. Tumis bumbu halus hingga harum.\n 4. Masukkan tumisan ke dalam air rebusan daging.\n 5. Masukkan serai dan garam.\n 6. Masak hingga kuah mendidih dan beraroma.\n 7. Sajikan rawon selagi hangat.',
    imageAsset: 'images/rawondaging.jpg',
    tipe: 'Makanan Berat',
    imageUrls: [
      'images/nasigorengkpg.jpg',
      'images/nasiuduk.jpg',
      'images/tempegorengtepung.jpg',
      'images/ikanpepes.jpg',
    ],
    isFavorite: false,
  ),
  Menu(
    nama: 'Tempe Goreng Tepung',
    deskripsi:
    'Tempe goreng tepung adalah camilan khas Indonesia yang dibuat dari irisan tempe yang dibalut adonan tepung berbumbu, lalu digoreng hingga renyah keemasan. Perpaduan tekstur luar yang crispy dan bagian dalam yang lembut membuatnya gurih dan cocok disantap kapan saja.',
    bahan: 'Tempe iris\n Tepung bumbu serbaguna\n Air dan Minyak Goreng.',
    carabuat: '1. Campurkan tepung bumbu dengan air hingga adonan tidak terlalu kental.\n 2. Masukkan irisan tempe ke dalam adonan.\n 3. Panaskan minyak dengan api sedang.\n 4. Goreng tempe hingga terendam minyak.\n 5. Angkat saat tempe berwarna keemasan dan renyah.\n 6. Tiriskan dan sajikan. ',
    imageAsset: 'images/tempegorengtepung.jpg',
    tipe: 'Makanan Ringan',
    imageUrls: [
      'images/sateayam.jpeg',
      'images/nasiuduk.jpg',
      'images/sotoayam.jpg',
      'images/ikanpepes.jpg',
    ],
    isFavorite: false,
  ),
  Menu(
    nama: 'Nasi Uduk',
    deskripsi:
    'Nasi uduk adalah nasi gurih khas Betawi yang dimasak dengan santan dan rempah, cocok disantap sebagai menu utama.',
    bahan: '500 g beras\n 2600 ml santan\n 2 lembar daun salam\n 1 batang serai, memarkan\n 1 sdt garam.',
    carabuat: '1. Cuci beras hingga bersih, tiriskan.\n 2. Masukkan beras, santan, daun salam, serai, dan garam ke dalam panci.\n 3. Masak dengan api sedang sambil diaduk hingga santan menyusut.\n 4. Kecilkan api, tutup panci dan masak hingga nasi matang.\n 5. Aduk nasi agar uap keluar, sajikan hangat.',
    imageAsset: 'images/nasiuduk.jpg',
    tipe: 'Makanan Berat',
    imageUrls: [
      'images/sateayam.jpeg',
      'images/ikanbakarbumbukecap.jpg',
      'images/miegorengjawa.jpg',
      'images/sateayam.jpg',
    ],
    isFavorite: false,
  ),
  Menu(
    nama: 'Ikan Bakan Bumbu Kecap',
    deskripsi:
    'Ikan bakar bumbu kecap adalah menu sederhana dengan cita rasa manis gurih dan aroma bakaran yang khas.',
    bahan: '1 ekor ikan (nila/gurame)\n 3 siung bawang putih\n 1 buah jeruk nipis\n Kecap manis secukupnya\n Garam secukupnya.',
    carabuat: '1. Bersihkan ikan, lumuri dengan jeruk nipis dan garam.\n 2. Haluskan bawang putih.\n 3. Campur bawang putih dengan kecap manis.\n 4. Lumuri ikan dengan bumbu, diamkan 15 menit.\n 5. Bakar ikan sambil diolesi sisa bumbu hingga matang.\n 6. Angkat dan sajikan hangat.',
    imageAsset: 'images/ikanbakarbumbukecap.jpg',
    tipe: 'Makanan Berat',
    imageUrls: [
      'images/sateayam.jpeg',
      'images/nasiuduk.jpg',
      'images/nasigorengkpg.jpg',
      'images/sotoayam.jpg',
    ],
    isFavorite: false,
  ),
  Menu(
    nama: 'Sate Ayam',
    deskripsi:
    'Sate ayam adalah potongan daging ayam yang ditusuk dan dibakar, disajikan dengan bumbu kacang yang gurih.',
    bahan: '500 g daging ayam, potong dadu\n Tusuk sate secukupnya\n Kecap manis secukupnya\n Minyak goreng secukupnya.',
    carabuat: '1. Tusuk potongan ayam ke tusuk sate.\n 2. Lumuri ayam dengan kecap manis dan sedikit minyak.\n 3. Panaskan alat pemanggang.\n 4. Bakar sate sambil dibolak-balik hingga matang dan kecokelatan.\n 5. Angkat dan sajikan dengan saus kacang.',
    imageAsset: 'images/sateayam.jpeg',
    tipe: 'Makanan Berat',
    imageUrls: [
      'images/miegorengjawa.jpg',
      'images/ayamgorenglks.jpg',
      'images/tempegorengtepung.jpg',
      'images/ikanpepes.jpg',
    ],
    isFavorite: false,
  ),
  Menu(
    nama: 'Ikan Pepes',
    deskripsi:
    'Pepes ikan adalah ikan berbumbu yang dibungkus daun pisang dan dikukus, menghasilkan aroma khas dan rasa gurih.',
    bahan: '500 g ikan (nila/patin)\n 3 siung bawang putih\n 4 siung bawang merah\n Cabai secukupnya\n Daun pisang secukupnya\n Garam secukupnya.',
    carabuat: '1. Haluskan bawang putih, bawang merah, dan cabai\n 2. Lumuri ikan dengan bumbu dan garam.\n 3. Bungkus ikan dengan daun pisang.\n 4. Kukus selama 30 menit hingga matang.\n 5. Angkat dan sajikan.',
    imageAsset: 'images/ikanpepes.jpg',
    tipe: 'Makanan Berat',
    imageUrls: [
      'images/sateayam.jpeg',
      'images/nasiuduk.jpg',
      'images/rawondaging.jpg',
      'images/tempegorengtepung.jpg',
    ],
    isFavorite: false,
  ),
];
