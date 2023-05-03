class DataKunjungan {
  final String user_id;
  final String nama;
  final String alamat;
  final int berat_badan;
  final int tinggi_badan;
  final String keluhan;

  DataKunjungan({
    required this.user_id,
    required this.nama,
    required this.alamat,
    required this.berat_badan,
    required this.tinggi_badan,
    required this.keluhan,
  });

  factory DataKunjungan.fromJson(Map<String, dynamic> json) {
    return DataKunjungan(
        user_id: json['user_id'],
        nama: json['nama'],
        alamat: json['alamat'],
        berat_badan: json['berat_badan']?.toDouble(),
        tinggi_badan: json['tinggi_badan']?.toDouble(),
        keluhan: json['keluhan']);
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'nama': nama,
      'alamat': alamat,
      'berat_badan': berat_badan,
      'tinggi_badan': tinggi_badan,
      'keluhan': keluhan,
    };
  }
}
