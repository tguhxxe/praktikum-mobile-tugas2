import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // Tambahkan const constructor untuk performance yang lebih baik
  const LoginPage({super.key}); 

  // Fungsi Pembantu untuk TextField (Dibuat statis atau di luar build method)
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

  // Fungsi Pembantu untuk Tombol Utama (Dibuat statis atau di luar build method)
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

  // Fungsi Pembantu untuk Tombol Sosial (Dibuat statis atau di luar build method)
  Widget _buildSocialButton({required String text, required String icon, required Color backgroundColor, Color textColor = Colors.white}) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {
          // TODO: Implementasi login sosial media
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image.asset(icon, height: 24), // Ganti dengan Image.asset jika Anda punya logo
            Icon(text.contains('Google') ? Icons.g_mobiledata : Icons.facebook, color: Colors.white), 
            const SizedBox(width: 10),
            Text(text, style: TextStyle(fontSize: 16, color: textColor)),
          ],
        ),
      ),
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
                // Ganti dengan path gambar Anda, misal: 'assets/teguh.jpg'
                image: AssetImage('assets/theater.jpeg'), 
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          
          // Bagian 2: Konten Login (Tengah ke Bawah)
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF1A1A2E), // Latar belakang gelap
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      'Login',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const Text(
                      'Let\'s get started',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    const SizedBox(height: 30),
                    
                    // Form Email
                    _buildTextField(icon: Icons.email, hint: 'Email'),
                    const SizedBox(height: 15),
                    // Form Password
                    _buildTextField(icon: Icons.lock, hint: 'Password', isPassword: true),
                    
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password?', style: TextStyle(color: Color(0xFF4C7FFF))), // Biru terang
                      ),
                    ),
                    
                    // Tombol Login - IMPLEMENTASI NAVIGASI KE THEATER
                    _buildMainButton(
                      text: 'Login', 
                      color: const Color(0xFF4C7FFF), 
                      onPressed: () {
                        // Navigasi ke halaman pemilihan teater
                        Navigator.pushNamed(context, '/theater_selection');
                      }
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Divider 'Or'
                    const Row(
                      children: <Widget>[
                        Expanded(child: Divider(color: Colors.white54)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text('Or', style: TextStyle(color: Colors.white54)),
                        ),
                        Expanded(child: Divider(color: Colors.white54)),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Tombol Login with Google
                    _buildSocialButton(
                      text: 'Login With Google', 
                      icon: 'assets/google_logo.png', 
                      backgroundColor: const Color(0xFF2E3B55),
                    ),
                    const SizedBox(height: 10),

                    // Tombol Login with Facebook
                    _buildSocialButton(
                      text: 'Login with Facebook', 
                      icon: 'assets/facebook_logo.png',
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    ),

                    const SizedBox(height: 30),

                    // Link Don't have an account? (Navigasi ke Sign-up)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Don't have an account?", style: TextStyle(color: Colors.white70)),
                        GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman Sign-up (rute '/')
                            Navigator.pushNamed(context, '/');
                          },
                          child: const Text(' Register here', style: TextStyle(color: Color(0xFF4C7FFF), fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    
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