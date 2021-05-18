part of blemulator;

class SimulatedCharacteristic extends CharacteristicBase {
  final int id;
  SimulatedService service;
  Uint8List _value;
  final String convenienceName;
  bool isNotifying;
  final Map<int, SimulatedDescriptor> _descriptors;

  StreamController<Uint8List> _streamController;

  SimulatedCharacteristic({
    @required String uuid,
    @required Uint8List value,
    this.convenienceName,
    this.isNotifying = false,
    isReadable = true,
    isWritableWithResponse = true,
    isWritableWithoutResponse = true,
    isNotifiable = false,
    isIndicatable = false,
    List<SimulatedDescriptor> descriptors = const [],
  })  : id = IdGenerator().nextId(),
        _descriptors = {
          for (var descriptor in descriptors) descriptor.id: descriptor
        },
        super(
            uuid: uuid.toLowerCase(),
            isIndicatable: isIndicatable,
            isNotifiable: isNotifiable,
            isReadable: isReadable,
            isWritableWithResponse: isWritableWithResponse,
            isWritableWithoutResponse: isWritableWithoutResponse) {
    _value = value;
    _descriptors.values
        .forEach((descriptor) => descriptor.attachToCharacteristic(this));
  }

  void attachToService(SimulatedService service) => this.service = service;

  @override
  Future<Uint8List> read() async => _value;

  @override
  Future<void> write(Uint8List value, {bool sendNotification = true}) async {
    _value = value;
    if (sendNotification && _streamController?.hasListener == true) {
      _streamController.sink.add(value);
    }
  }

  @override
  Stream<Uint8List> monitor() {
    _streamController ??= StreamController.broadcast(
      onListen: () {
        isNotifying = true;
      },
      onCancel: () {
        isNotifying = false;
        _streamController.close();
        _streamController = null;
      },
    );
    return _streamController.stream;
  }

  List<SimulatedDescriptor> descriptors() => _descriptors.values.toList();

  SimulatedDescriptor descriptor(int id) => _descriptors[id];

  SimulatedDescriptor descriptorByUuid(String uuid) =>
      _descriptors.values.firstWhere(
        (descriptor) => descriptor.uuid.toLowerCase() == uuid.toLowerCase(),
        orElse: () => null,
      );
}
