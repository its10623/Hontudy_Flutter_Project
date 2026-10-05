// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_detail_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NoteDetailViewModel)
final noteDetailViewModelProvider = NoteDetailViewModelFamily._();

final class NoteDetailViewModelProvider
    extends $AsyncNotifierProvider<NoteDetailViewModel, NoteDetail> {
  NoteDetailViewModelProvider._({
    required NoteDetailViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'noteDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$noteDetailViewModelHash();

  @override
  String toString() {
    return r'noteDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  NoteDetailViewModel create() => NoteDetailViewModel();

  @override
  bool operator ==(Object other) {
    return other is NoteDetailViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$noteDetailViewModelHash() =>
    r'95af9a1bc825fbf7962985a4702459e436b3530f';

final class NoteDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          NoteDetailViewModel,
          AsyncValue<NoteDetail>,
          NoteDetail,
          FutureOr<NoteDetail>,
          String
        > {
  NoteDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'noteDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NoteDetailViewModelProvider call(String main) =>
      NoteDetailViewModelProvider._(argument: main, from: this);

  @override
  String toString() => r'noteDetailViewModelProvider';
}

abstract class _$NoteDetailViewModel extends $AsyncNotifier<NoteDetail> {
  late final _$args = ref.$arg as String;
  String get main => _$args;

  FutureOr<NoteDetail> build(String main);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<NoteDetail>, NoteDetail>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NoteDetail>, NoteDetail>,
              AsyncValue<NoteDetail>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
