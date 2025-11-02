import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class TheaterSelectionPage extends StatefulWidget {
  const TheaterSelectionPage({Key? key}) : super(key: key);

  @override
  State<TheaterSelectionPage> createState() => _TheaterSelectionPageState();
}

class _TheaterSelectionPageState extends State<TheaterSelectionPage> {
  String _currentCity = 'MENDAPATKAN LOKASI...';
  final List<String> _theaters = const [
    'XI CINEMA',
    'PONDOK KELAPA 21',
    'CGV',
    'CINEPOLIS',
    'CP MALL',
    'HERMES'
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Fungsi untuk mendapatkan lokasi saat ini
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Cek Layanan Lokasi
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _currentCity = 'LOKASI NONAKTIF');
      return Future.error('Layanan lokasi tidak diaktifkan.');
    }

    // 2. Cek Izin
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.unableToDetermine) {
        setState(() => _currentCity = 'IZIN DITOLAK');
        return Future.error('Izin lokasi ditolak.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      setState(() => _currentCity = 'IZIN DITOLAK PERMANEN');
      return Future.error('Izin lokasi ditolak selamanya, tidak bisa diakses.');
    }

    // 3. Ambil Posisi
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      
      // 4. Konversi Koordinat ke Nama Kota
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      
      if (placemarks.isNotEmpty) {
        String? city = placemarks[0].locality ?? placemarks[0].subAdministrativeArea;
        setState(() {
          // Hanya menggunakan 'MEDAN' (untuk simulasi, jika lokasi sebenarnya bukan Medan)
          // Jika ingin menggunakan lokasi sebenarnya: _currentCity = (city ?? 'LOKASI TIDAK DIKETAHUI').toUpperCase();
          _currentCity = city?.toUpperCase() ?? 'MEDAN'; 
        });
      } else {
        setState(() => _currentCity = 'KOTA TIDAK DIKETAHUI');
      }
    } catch (e) {
      setState(() => _currentCity = 'ERROR: ${e.toString().substring(0, 10)}...');
    }
  }


  // Helper Widget untuk Tile Teater
  Widget _buildTheaterTile({required String theaterName}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent), // Hilangkan divider bawaan ExpansionTile
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
          title: Text(theaterName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          trailing: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          children: const <Widget>[
            // Konten di dalam ExpansionTile (Detail/Jam Tayang)
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
              child: Text(
                'Detail teater dan jam tayang akan muncul di sini ketika diklik. Contoh: 14:00 | 17:00 | 20:00', 
                style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E), 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'THEATER',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          // Bar Lokasi
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A2E), // Sama dengan AppBar
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.location_on, color: Color(0xFF4C7FFF)),
                const SizedBox(width: 8),
                Text(
                  _currentCity, // Menampilkan nama kota yang didapat dari geolocator
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              ],
            ),
          ),
          
          // Daftar Teater
          Expanded(
            child: ListView.builder(
              itemCount: _theaters.length,
              itemBuilder: (context, index) {
                return _buildTheaterTile(theaterName: _theaters[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}