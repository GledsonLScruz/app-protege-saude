import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/complaint_models.dart';

class DraftRepository {
  DraftRepository({FlutterSecureStorage? secureStorage})
    : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  static const _keyName = 'protege_saude_hive_key';
  static const _draftBoxName = 'complaint_drafts';
  static const _confirmationBoxName = 'confirmation';
  static const _confirmationKey = 'last_confirmation';

  final FlutterSecureStorage _secureStorage;
  late final Box<dynamic> _drafts;
  late final Box<dynamic> _confirmation;

  Future<void> init() async {
    await Hive.initFlutter();
    final key = await _loadOrCreateEncryptionKey();
    final cipher = HiveAesCipher(key);
    _drafts = await Hive.openBox<dynamic>(
      _draftBoxName,
      encryptionCipher: cipher,
    );
    _confirmation = await Hive.openBox<dynamic>(
      _confirmationBoxName,
      encryptionCipher: cipher,
    );
  }

  Future<ComplaintDraft?> loadDraft(int professionId) async {
    final value = _drafts.get(_draftKey(professionId));
    if (value == null) {
      return null;
    }
    return ComplaintDraft.fromJson(_deepStringMap(value));
  }

  Future<void> saveDraft(ComplaintDraft draft) async {
    await _drafts.put(_draftKey(draft.professionId), draft.toJson());
  }

  Future<void> deleteDraft(int professionId) async {
    await _drafts.delete(_draftKey(professionId));
  }

  Future<void> saveConfirmation(ConfirmationRecord record) async {
    await _confirmation.put(_confirmationKey, record.toJson());
  }

  Future<ConfirmationRecord?> loadConfirmation() async {
    final value = _confirmation.get(_confirmationKey);
    if (value == null) {
      return null;
    }
    return ConfirmationRecord.fromJson(_deepStringMap(value));
  }

  String _draftKey(int professionId) => 'profession_$professionId';

  Future<List<int>> _loadOrCreateEncryptionKey() async {
    final stored = await _secureStorage.read(key: _keyName);
    if (stored != null) {
      return base64Url.decode(stored);
    }
    final random = Random.secure();
    final key = List<int>.generate(32, (_) => random.nextInt(256));
    await _secureStorage.write(key: _keyName, value: base64Url.encode(key));
    return key;
  }
}

Map<String, dynamic> _deepStringMap(Object? value) {
  if (value is Map<String, dynamic>) {
    return value.map((key, val) => MapEntry(key, _normalizeHiveValue(val)));
  }
  if (value is Map) {
    return value.map(
      (key, val) => MapEntry(key.toString(), _normalizeHiveValue(val)),
    );
  }
  return <String, dynamic>{};
}

Object? _normalizeHiveValue(Object? value) {
  if (value is Map) {
    return _deepStringMap(value);
  }
  if (value is List) {
    return value.map(_normalizeHiveValue).toList();
  }
  return value;
}
