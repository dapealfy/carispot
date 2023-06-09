# CariSpot

Aplikasi pencari Rumah Sakit dan Restoran sekitar Jawa - Sumatera

## Deskripsi

CariSpot menggunakan library [flutter_map](https://pub.dev/packages/flutter_map) untuk menampilkan tampilan Maps. CariSpot juga menggunakan data restoran dan rumah sakit yang didapat dari: https://github.com/anak10thn/dishub-webgis-data/tree/master

# Tampilan Home

<img src="https://github.com/dapealfy/carispot/blob/main/screenshot/home.png" width="200px">
Berikut adalah tampilan Home dari aplikasi cari spot yang berisikan lokasi user (kota), dan prakiraan cuaca yang didapatkan dari https://open-meteo.com. Terdapat juga Tab Populer dan Terdekat, namun untuk saat ini pengerjaan hanya sampai di tab Terdekat.

# Tampilan Maps

<p float="left">
  <img src="https://github.com/dapealfy/carispot/blob/main/screenshot/maps.png" width="200px">
  <img src="https://github.com/dapealfy/carispot/blob/main/screenshot/search.png" width="200px">
  <img src="https://github.com/dapealfy/carispot/blob/main/screenshot/search_on_click.png" width="200px">
</p>
Berikut adalah tampilan Maps dari aplikasi cari spot yang berisikan tampilan peta dengan searchbar. Pada halaman ini terdapat beberapa fungsi yang dapat diakses diantaranya:

- Pencarian lokasi Restoran dan Rumah Sakit
- Petunjuk arah menuju tiitk lokasi (menggunakan library [url_launcher](https://pub.dev/packages/url_launcher))
- Save lokasi ke favorite (menggunakan [hive](https://pub.dev/packages/hive))

# Tampilan Favorite

<img src="https://github.com/dapealfy/carispot/blob/main/screenshot/favorite.png" width="200px">
Berikut adalah tampilan dari halaman Favorite, dimana terdapat 2 buah fitur yang dapat diakses yaitu Petunjuk arah dan hapus dari favorite.
