import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // 1. Declare necessary variables
  bool isSignedIn = false;
  String fullName = '';
  String userName = "";
  int favoriteCandiCount = 0;
  late Color iconColor;

  // tambahan untuk foto profile
  String? _profilePhotoBase64;

  //5. implementasi fungsi signIn
  void signIn() {
    Navigator.pushNamed(context, "/signin");
  }

  //6. implementasi fungsi signOut
  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedIn', false);

    setState(() {
      isSignedIn = !isSignedIn;
      userName = '';
      fullName = '';
      _profilePhotoBase64 = null;
    });
  }

  void _checkSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSignedIn = prefs.getBool("isSignedIn") ?? false;
    });
  }

  Future<void> _loadPhoto() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _profilePhotoBase64 = prefs.getString("profilePhoto");
    });
  }

  void _identitas() async {
    final prefs = await SharedPreferences.getInstance();

    final encFull = prefs.getString("fullname") ?? "";
    final encUser = prefs.getString("username") ?? "";

    final keyString = prefs.getString('key') ?? '';
    final ivString = prefs.getString('iv') ?? '';

    String decFull = encFull;
    String decUser = encUser;

    if (keyString.isNotEmpty && ivString.isNotEmpty) {
      try {
        final encrypt.Key key = encrypt.Key.fromBase64(keyString);
        final iv = encrypt.IV.fromBase64(ivString);
        final encrypter = encrypt.Encrypter(encrypt.AES(key));

        if (encFull.isNotEmpty) decFull = encrypter.decrypt64(encFull, iv: iv);
        if (encUser.isNotEmpty) decUser = encrypter.decrypt64(encUser, iv: iv);
      } catch (_) {
      }
    }

    if (!mounted) return;
    setState(() {
      fullName = decFull;
      userName = decUser;
    });
  }

  Future<void> _changePhoto() async {
    if (!isSignedIn) return;

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Pilih dari Gallery"),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Ambil dari Camera"),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final picker = ImagePicker();
    final xFile = await picker.pickImage(
      source: source,
      imageQuality: 75,
      maxWidth: 900,
    );
    if (xFile == null) return;

    final bytes = await xFile.readAsBytes();
    final base64Str = base64Encode(bytes);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("profilePhoto", base64Str);

    if (!mounted) return;
    setState(() {
      _profilePhotoBase64 = base64Str;
    });
  }

  ImageProvider _avatarProvider() {
    try {
      if (_profilePhotoBase64 != null && _profilePhotoBase64!.isNotEmpty) {
        final Uint8List bytes = base64Decode(_profilePhotoBase64!);
        return MemoryImage(bytes);
      }
    } catch (_) {
    }
    return const AssetImage('images/placeholder_image.png');
  }

  Future<void> _editUsername() async {
    if (!isSignedIn) return;

    final controller = TextEditingController(text: userName);
    final newValue = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Ubah Nama Pengguna"),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Masukkan username baru",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              final v = controller.text.trim();
              Navigator.pop(ctx, v.isEmpty ? null : v);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );

    if (newValue == null) return;

    final prefs = await SharedPreferences.getInstance();
    final keyString = prefs.getString('key') ?? '';
    final ivString = prefs.getString('iv') ?? '';

    String toSave = newValue;
    if (keyString.isNotEmpty && ivString.isNotEmpty) {
      try {
        final key = encrypt.Key.fromBase64(keyString);
        final iv = encrypt.IV.fromBase64(ivString);
        final encrypter = encrypt.Encrypter(encrypt.AES(key));
        toSave = encrypter.encrypt(newValue, iv: iv).base64;
      } catch (_) {
        toSave = newValue;
      }
    }

    await prefs.setString("username", toSave);

    if (!mounted) return;
    setState(() {
      userName = newValue;
    });
  }

  @override
  void initState() {
    _checkSignInStatus();
    _identitas();
    _loadPhoto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF3F587E);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // HEADER + AVATAR OVERLAP
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 210,
                width: double.infinity,
                color: headerColor,
                child: SafeArea(
                  child: Stack(
                    children: [
                      Positioned(
                        left: 8,
                        top: 8,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 18),
                          child: Text(
                            "PROFILES",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Avatar
              Positioned(
                left: 0,
                right: 0,
                bottom: -55,
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.white,
                          backgroundImage: _avatarProvider(),
                        ),
                      ),

                      if (isSignedIn)
                        Container(
                          margin: const EdgeInsets.only(right: 6, bottom: 6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                          ),
                          child: IconButton(
                            iconSize: 18,
                            padding: const EdgeInsets.all(6),
                            constraints: const BoxConstraints(),
                            onPressed: _changePhoto,
                            icon: const Icon(Icons.camera_alt, color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 80),

          // CONTENT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                const Divider(color: Colors.black, thickness: 1.2),

                _infoRow(
                  icon: Icons.lock,
                  iconColor: Colors.black,
                  label: "Pengguna",
                  value: (userName.isEmpty) ? "-" : userName,
                  onEdit: isSignedIn ? _editUsername : null,
                ),
                const Divider(color: Colors.black, thickness: 1.2),

                _infoRow(
                  icon: Icons.person,
                  iconColor: Colors.black,
                  label: "Nama",
                  value: (fullName.isEmpty) ? "-" : fullName,
                  onEdit: null,
                ),
                const Divider(color: Colors.black, thickness: 1.2),

                _infoRow(
                  icon: Icons.favorite,
                  iconColor: Colors.red,
                  label: "Favorite",
                  value: (favoriteCandiCount <= 0)
                      ? "-"
                      : favoriteCandiCount.toString(),
                  onEdit: null,
                ),
                const Divider(color: Colors.black, thickness: 1.2),

                const SizedBox(height: 10),

              ],
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    VoidCallback? onEdit,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 10),

          SizedBox(
            width: 95,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),

          const Text(
            ":",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          if (onEdit != null)
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit, size: 18, color: Colors.black54),
              tooltip: "Edit",
            ),
        ],
      ),
    );
  }
}
