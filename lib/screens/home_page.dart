import 'package:flutter/material.dart';
import '../data/animal_data.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animal List"),
        centerTitle: true,
        // Tombol Logout
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              // Kembali ke halaman login
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      // Menggunakan ListView.builder untuk efisiensi
      body: ListView.builder(
        itemCount: dummyAnimals.length,
        itemBuilder: (context, index) {
          final animal = dummyAnimals[index];
          return GestureDetector(
            onTap: () {
              // Navigasi ke halaman detail saat item diklik
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(animal: animal),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  // Gambar Hewan
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: Image.network(
                      animal.image,
                      width: 135,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, stackTrace) =>
                          const Icon(Icons.error, size: 120),
                    ),
                  ),
                  // Informasi Teks
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            animal.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Tipe: ${animal.type}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Habitat: ${animal.habitat.join(', ')}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
