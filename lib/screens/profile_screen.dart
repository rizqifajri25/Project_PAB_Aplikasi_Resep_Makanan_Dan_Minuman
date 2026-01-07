import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSignedIn = false;
  String fullName = '';
  String userName = '';
  int favoriteCandiCount = 0;

  String? _profilePhotoBase64;

  // ================= AUTH =================
  void signIn() {
    Navigator.pushNamed(context, "/signin");
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!mounted) return;
    setState(() {
      isSignedIn = false;
      fullName = '';
      userName = '';
      favoriteCandiCount = 0;
      _profilePhotoBase64 = null;
    });
  }

  Future<void> _checkSignInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      isSignedIn = prefs.getBool("isSignedIn") ?? false;
    });
  }

  // ================= IDENTITAS =================
  Future<void> _identitas() async {
    final prefs = await SharedPreferences.getInstance();

    final encFull = prefs.getString("fullname") ?? "";
    final encUser = prefs.getString("username") ?? "";
    final keyString = prefs.getString('key') ?? '';
    final ivString = prefs.getString('iv') ?? '';

    String decFull = encFull;
    String decUser = encUser;

    if (keyString.isNotEmpty && ivString.isNotEmpty) {
      try {
        final key = encrypt.Key.fromBase64(keyString);
        final iv = encrypt.IV.fromBase64(ivString);
        final encrypter = encrypt.Encrypter(encrypt.AES(key));

        if (encFull.isNotEmpty) {
          decFull = encrypter.decrypt64(encFull, iv: iv);
        }
        if (encUser.isNotEmpty) {
          decUser = encrypter.decrypt64(encUser, iv: iv);
        }
      } catch (_) {}
    }

    if (!mounted) return;
    setState(() {
      fullName = decFull;
      userName = decUser;
    });
  }

  // ================= FAVORITE =================
  Future<void> _loadFavoriteCount() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];

    if (!mounted) return;
    setState(() {
      favoriteCandiCount = favorites.length;
    });
  }

  // ================= PHOTO =================
  Future<void> _loadPhoto() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _profilePhotoBase64 = prefs.getString("profilePhoto");
    });
  }

  Future<void> _changePhoto() async {
    if (!isSignedIn) return;

    /// ===== WEB / DESKTOP =====
    if (kIsWeb ||
        Platform.isWindows ||
        Platform.isLinux ||
        Platform.isMacOS) {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );

      if (result == null || result.files.single.bytes == null) return;

      final base64Str = base64Encode(result.files.single.bytes!);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("profilePhoto", base64Str);

      if (!mounted) return;
      setState(() {
        _profilePhotoBase64 = base64Str;
      });
      return;
    }

    /// ===== ANDROID / IOS =====
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Pilih dari Galeri"),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Ambil dari Kamera"),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: source,
      imageQuality: 75,
      maxWidth: 900,
    );

    if (file == null) return;

    final bytes = await file.readAsBytes();
    final base64Str = base64Encode(bytes);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("profilePhoto", base64Str);

    if (!mounted) return;
    setState(() {
      _profilePhotoBase64 = base64Str;
    });
  }

  ImageProvider _avatarProvider() {
    if (_profilePhotoBase64 != null && _profilePhotoBase64!.isNotEmpty) {
      try {
        return MemoryImage(base64Decode(_profilePhotoBase64!));
      } catch (_) {}
    }
    return const AssetImage('images/placeholder_image.png');
  }

  // ================= INIT =================
  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
    _identitas();
    _loadPhoto();
    _loadFavoriteCount();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFavoriteCount();
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 210,
                  color: colorScheme.primary,
                  child: SafeArea(
                    child: Stack(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back,
                              color: colorScheme.onPrimary),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: Text(
                              "PROFILE",
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                        if (isSignedIn)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: IconButton(
                              icon: Icon(Icons.logout,
                                  color: colorScheme.onPrimary),
                              onPressed: signOut,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                /// ===== AVATAR =====
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -55,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor:
                          colorScheme.onBackground.withOpacity(.1),
                          child: CircleAvatar(
                            radius: 52,
                            backgroundImage: _avatarProvider(),
                          ),
                        ),

                        /// ===== FIX ICON CAMERA =====
                        if (isSignedIn)
                          GestureDetector(
                            onTap: _changePhoto,
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: colorScheme.onPrimary,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 80),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  const Divider(),
                  _infoRow(Icons.lock, "Pengguna",
                      userName.isEmpty ? "-" : userName),
                  const Divider(),
                  _infoRow(Icons.person, "Nama",
                      fullName.isEmpty ? "-" : fullName),
                  const Divider(),
                  _infoRow(
                    Icons.favorite,
                    "Favorite",
                    favoriteCandiCount == 0
                        ? "-"
                        : favoriteCandiCount.toString(),
                    iconColor: Colors.red,
                  ),
                  const Divider(),
                  const SizedBox(height: 30),
                  if (!isSignedIn)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: signIn,
                        icon: const Icon(Icons.login),
                        label: const Text("LOGIN"),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
      IconData icon,
      String label,
      String value, {
        Color? iconColor,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 10),
          SizedBox(width: 95, child: Text(label)),
          const Text(": "),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
