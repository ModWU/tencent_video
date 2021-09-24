abstract class ARouteHandler {

  ARouteHandler({required this.fromId, required this.fromTagId, required this.toId});

  //routeId
  final String fromId;
  final Object fromTagId;
  final String toId;

  Object get parameter;
}
