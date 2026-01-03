class Menu {
  final String nama;
  final String deskripsi;
  final String bahan;
  final String carabuat;
  final String imageAsset;
  final String tipe;
  bool isFavorite;

  Menu({
    required this.nama,
    required this.deskripsi,
    required this.bahan,
    required this.carabuat,
    required this.imageAsset,
    required this.tipe,
    this.isFavorite = false,
  });

}

