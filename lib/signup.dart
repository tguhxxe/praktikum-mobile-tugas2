import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  // Helper Widget untuk Form Field
  Widget _buildTextField({required IconData icon, required String hint, bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2E3B55), // Warna latar belakang form field
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: Icon(icon, color: Colors.white),
          suffixIcon: isPassword ? const Icon(Icons.remove_red_eye_outlined, color: Colors.white54) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
      ),
    );
  }

  // Helper Widget untuk Tombol Utama
  Widget _buildMainButton({required String text, required Color color, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: Text(text, style: const TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Bagian 1: Gambar Latar Belakang Kota/Bioskop (Atas)
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/teguh.jpg'), // **PASTIKAN PATH INI BENAR**
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          
          // Bagian 2: Konten Sign-up (Tengah ke Bawah)
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 150.0), // Atur posisi mulai konten
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF1A1A2E), // Warna latar belakang utama gelap
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      'Sign-up',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const Text(
                      'Let\'s get started',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    const SizedBox(height: 30),
                    
                    _buildTextField(icon: Icons.person, hint: 'Your Full Name'),
                    const SizedBox(height: 15),
                    _buildTextField(icon: Icons.email, hint: 'Email'),
                    const SizedBox(height: 15),
                    _buildTextField(icon: Icons.lock, hint: 'Password', isPassword: true),
                    const SizedBox(height: 15),
                    _buildTextField(icon: Icons.lock, hint: 'Confirm Password', isPassword: true),
                    
                    const SizedBox(height: 30),
                    
                    // Tombol Register
                    _buildMainButton(
                      text: 'Register', 
                      color: const Color(0xFF4C7FFF), 
                      onPressed: () {
                        // TODO: Implementasi logic registrasi
                      }
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Link Don't have an account? Register here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Don't have an account?", style: TextStyle(color: Colors.white70)),
                        GestureDetector(
                          onTap: () {
                            // TODO: Navigasi ke halaman Login
                            Navigator.pop(context); 
                          },
                          child: const Text(' Register here', style: TextStyle(color: Color(0xFF4C7FFF), fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50), // Ruang ekstra di bagian bawah
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}