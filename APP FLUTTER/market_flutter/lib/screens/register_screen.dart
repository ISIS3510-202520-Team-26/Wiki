import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const Color kDarkGreen = Color(0xFF014D40);
  static const Color kBgLavender = Color(0xFFF1ECF2);

  final _emailCtrl = TextEditingController();
  final _userCtrl  = TextEditingController();
  final _passCtrl  = TextEditingController();
  final _confCtrl  = TextEditingController();

  bool _showPass = false;
  bool _showConf = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _userCtrl.dispose();
    _passCtrl.dispose();
    _confCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgLavender,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Título
                Text(
                  "Hello! Register to get\nstarted.",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ).copyWith(color: kDarkGreen),
                ),

                const SizedBox(height: 24),

                // Username
                _RoundedInput(
                  controller: _userCtrl,
                  hint: "Username",
                ),
                const SizedBox(height: 12),

                // Email
                _RoundedInput(
                  controller: _emailCtrl,
                  hint: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),

                // Password
                _RoundedInput(
                  controller: _passCtrl,
                  hint: "Password",
                  obscureText: !_showPass,
                  suffix: IconButton(
                    onPressed: () => setState(() => _showPass = !_showPass),
                    icon: Icon(_showPass ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                const SizedBox(height: 12),

                // Confirm password
                _RoundedInput(
                  controller: _confCtrl,
                  hint: "Confirm password",
                  obscureText: !_showConf,
                  suffix: IconButton(
                    onPressed: () => setState(() => _showConf = !_showConf),
                    icon: Icon(_showConf ? Icons.visibility : Icons.visibility_off),
                  ),
                ),

                const SizedBox(height: 16),

                // Botón Register
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: valida y registra
                      // Ejemplo de validación mínima:
                      // if (_passCtrl.text != _confCtrl.text) { ... }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kDarkGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: const Text("Register", style: TextStyle(fontSize: 16)),
                  ),
                ),

                const SizedBox(height: 24),

                // Divider "Or Register with"
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade400)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "Or Register with",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade400)),
                  ],
                ),

                const SizedBox(height: 16),

                // Social buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _SocialSquare(label: "f"), // Facebook
                    _SocialSquare(label: "G"), // Google
                    _SocialSquare(label: "A"), // Apple (como en tu captura)
                  ],
                ),

                const SizedBox(height: 24),

                // "Already have an account? Login Now"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context); // volver a Login si venimos desde allí
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: kDarkGreen,
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        "Login Now",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- Widgets auxiliares ----------

class _RoundedInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffix;

  const _RoundedInput({
    this.controller,
    required this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}

class _SocialSquare extends StatelessWidget {
  final String label;
  const _SocialSquare({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      ),
    );
  }
}
