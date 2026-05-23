import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/complaint_models.dart';

class PhotoService {
  PhotoService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  static const _maxPhotoDimension = 1600.0;
  static const _imageQuality = 82;

  final ImagePicker _picker;

  Future<List<PhotoRef>> pickFromGallery({required int remainingSlots}) async {
    if (remainingSlots <= 0) {
      return const [];
    }
    try {
      final file = remainingSlots == 1
          ? await _picker.pickImage(
              source: ImageSource.gallery,
              maxWidth: _maxPhotoDimension,
              maxHeight: _maxPhotoDimension,
              imageQuality: _imageQuality,
            )
          : null;
      final files = remainingSlots == 1
          ? [?file]
          : await _picker.pickMultiImage(
              limit: remainingSlots,
              maxWidth: _maxPhotoDimension,
              maxHeight: _maxPhotoDimension,
              imageQuality: _imageQuality,
            );
      final limited = files.take(remainingSlots);
      final refs = <PhotoRef>[];
      for (final file in limited) {
        refs.add(await _copyToPrivateDirectory(file));
      }
      return refs;
    } on PlatformException catch (error) {
      throw PhotoSelectionException.fromPlatform(
        error,
        source: PhotoSource.gallery,
      );
    } on FileSystemException catch (_) {
      throw const PhotoSelectionException(
        'Não foi possível salvar a foto selecionada. Tente novamente.',
      );
    }
  }

  Future<PhotoRef?> captureFromCamera() async {
    try {
      final file = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: _maxPhotoDimension,
        maxHeight: _maxPhotoDimension,
        imageQuality: _imageQuality,
      );
      if (file == null) {
        return null;
      }
      return _copyToPrivateDirectory(file);
    } on PlatformException catch (error) {
      throw PhotoSelectionException.fromPlatform(
        error,
        source: PhotoSource.camera,
      );
    } on FileSystemException catch (_) {
      throw const PhotoSelectionException(
        'Não foi possível salvar a foto capturada. Tente novamente.',
      );
    }
  }

  Future<void> deletePhoto(PhotoRef photo) async {
    final file = File(photo.localPath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<void> deletePhotos(Iterable<PhotoRef> photos) async {
    for (final photo in photos) {
      await deletePhoto(photo);
    }
  }

  Future<PhotoRef> _copyToPrivateDirectory(XFile pickedFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final photosDirectory = Directory(
      p.join(directory.path, 'complaint_photos'),
    );
    if (!await photosDirectory.exists()) {
      await photosDirectory.create(recursive: true);
    }
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final extension = p.extension(pickedFile.path);
    final name = pickedFile.name.isNotEmpty
        ? pickedFile.name
        : 'foto_$id$extension';
    final destination = p.join(photosDirectory.path, '${id}_$name');
    await File(pickedFile.path).copy(destination);
    final copied = File(destination);
    final size = await copied.length();
    return PhotoRef(
      id: id,
      name: name,
      mimeType: lookupMimeType(destination) ?? 'image/jpeg',
      sizeBytes: size,
      localPath: destination,
      createdAt: DateTime.now(),
    );
  }
}

enum PhotoSource { camera, gallery }

class PhotoSelectionException implements Exception {
  const PhotoSelectionException(this.message);

  factory PhotoSelectionException.fromPlatform(
    PlatformException error, {
    required PhotoSource source,
  }) {
    final code = error.code.toLowerCase();
    final isPermissionDenied =
        code.contains('denied') || code.contains('permission');
    if (isPermissionDenied) {
      final target = source == PhotoSource.camera ? 'camera' : 'galeria';
      return PhotoSelectionException(
        'Permissão para acessar a $target foi negada. Autorize o acesso nas configurações do sistema e tente novamente.',
      );
    }
    final action = source == PhotoSource.camera
        ? 'capturar a foto'
        : 'selecionar fotos da galeria';
    return PhotoSelectionException(
      'Não foi possível $action. Tente novamente.',
    );
  }

  final String message;

  @override
  String toString() => message;
}
