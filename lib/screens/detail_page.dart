import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/animal_model.dart';
import '../services/like_service.dart';

class DetailPage extends StatefulWidget {
  final Animal animal;
  const DetailPage({super.key, required this.animal});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // Mengambil instance dari LikeService
  final LikeService _likeService = LikeService();

  /// Fungsi untuk membuka URL Wikipedia
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tidak bisa membuka URL: $urlString')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.animal.name),
        // Tombol like di AppBar, yang statusnya akan berubah secara reaktif
        actions: [
          ValueListenableBuilder(
            valueListenable: _likeService.likedAnimalsNotifier,
            builder: (context, Set<String> likedAnimals, _) {
              final isLiked = likedAnimals.contains(widget.animal.name);
              return IconButton(
                onPressed: () {
                  _likeService.toggleLike(widget.animal.name);
                },
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.white,
                ),
                tooltip: isLiked ? 'Unlike' : 'Like',
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Utama
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  widget.animal.image,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 250),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Nama Hewan
            Text(
              widget.animal.name,
              style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),

            // Informasi Detail (Tipe, Berat, Tinggi)
            _buildInfoRow(Icons.category, "Tipe", widget.animal.type),
            _buildInfoRow(
              Icons.monitor_weight,
              "Berat",
              "${widget.animal.weight} kg",
            ),
            _buildInfoRow(Icons.height, "Tinggi", "${widget.animal.height} cm"),
            const Divider(height: 32.0),

            // Habitat
            _buildDetailChips("Habitat", widget.animal.habitat),
            const SizedBox(height: 16.0),

            // Aktivitas
            _buildDetailChips("Aktivitas", widget.animal.activities),
            const SizedBox(height: 24.0),

            // Tombol Wikipedia
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.public),
                label: const Text("Buka Wikipedia"),
                onPressed: () {
                  _launchURL(widget.animal.wikipedia);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk menampilkan baris informasi
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600]),
          const SizedBox(width: 16),
          Text(
            "$label:",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  // Widget helper untuk menampilkan daftar sebagai Chips
  Widget _buildDetailChips(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: items
              .map(
                (item) =>
                    Chip(label: Text(item), backgroundColor: Colors.green[100]),
              )
              .toList(),
        ),
      ],
    );
  }
}
