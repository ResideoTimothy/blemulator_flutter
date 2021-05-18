part of blemulator;

abstract class CharacteristicBase {
  final String uuid;
  final bool isIndicatable;
  final bool isNotifiable;
  final bool isReadable;
  final bool isWritableWithResponse;
  final bool isWritableWithoutResponse;

  CharacteristicBase({
    @required uuid,
    isIndicatable = false,
    isNotifiable = false,
    isReadable = true,
    isWritableWithResponse = true,
    isWritableWithoutResponse = true,
  })  : uuid = uuid,
        isIndicatable = isIndicatable,
        isNotifiable = isNotifiable,
        isReadable = isReadable,
        isWritableWithResponse = isWritableWithResponse,
        isWritableWithoutResponse = isWritableWithoutResponse;
}
