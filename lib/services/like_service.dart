import 'package:flutter/foundation.dart';

/// Kelas [LikeService] berfungsi sebagai 'single source of truth' untuk
/// status 'like' pada setiap hewan.
/// Pola 'Singleton' digunakan di sini agar hanya ada satu instance dari kelas ini
/// di seluruh aplikasi, sehingga datanya konsisten.
class LikeService {
  // Singleton pattern setup
  static final LikeService _instance = LikeService._internal();
  factory LikeService() => _instance;
  LikeService._internal();

  /// Menggunakan Set untuk menyimpan nama hewan yang di-like.
  /// Set lebih efisien untuk operasi cek 'contains', tambah, dan hapus.
  final Set<String> _likedAnimals = {};

  /// ValueNotifier akan 'memberi tahu' widget yang mendengarkannya
  /// setiap kali ada perubahan pada daftar hewan yang di-like.
  final ValueNotifier<Set<String>> likedAnimalsNotifier = ValueNotifier({});

  /// Method untuk mengecek apakah seekor hewan sudah di-like berdasarkan namanya.
  bool isLiked(String animalName) {
    return _likedAnimals.contains(animalName);
  }

  /// Method untuk mengubah status like (like/unlike).
  void toggleLike(String animalName) {
    if (isLiked(animalName)) {
      _likedAnimals.remove(animalName);
    } else {
      _likedAnimals.add(animalName);
    }
    // Memberi tahu semua 'listener' bahwa ada data baru.
    // Kita membuat Set baru agar listener mendeteksi adanya perubahan objek.
    likedAnimalsNotifier.value = Set.from(_likedAnimals);
  }
}
