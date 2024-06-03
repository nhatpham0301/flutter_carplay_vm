import 'package:uuid/uuid.dart';

import '../../controllers/carplay_controller.dart';
import '../../flutter_carplay.dart';
import 'map_list.dart';
import 'map_point.dart';

/// A template object that displays map.
class CPMapTemplate {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// A title will be shown in the navigation bar.
  String title;

  /// The array of map buttons as [CPMapButton] displayed on the template.
  List<CPMapButton> mapButtons;

  /// An array of dashboard buttons as [CPDashboardButton] displayed on the template.
  List<CPDashboardButton> dashboardButtons;

  /// The array of map buttons as [CPMapButton] displayed on the template while panning.
  List<CPMapButton> mapButtonsWhilePanningMode;

  /// An array of bar buttons to be displayed on the navigation bar while panning.
  List<CPBarButton> barButtonsWhilePanningMode;

  /// An array of bar buttons to be displayed on the leading side of the navigation bar.
  List<CPBarButton> leadingNavigationBarButtons;

  /// An array of bar buttons to be displayed on the trailing side of the navigation bar.
  List<CPBarButton> trailingNavigationBarButtons;

  /// Automatically hides the navigation bar when the map template is visible.
  bool automaticallyHidesNavigationBar;

  /// Hides the buttons in the navigation bar when the map template is visible.
  bool hidesButtonsWithNavigationBar;

  /// Whether the map template is in panning mode.
  bool isPanningInterfaceVisible;

  /// Creates [CPMapTemplate]
  CPMapTemplate({
    this.title = '',
    this.mapButtons = const [],
    this.dashboardButtons = const [],
    this.mapButtonsWhilePanningMode = const [],
    this.barButtonsWhilePanningMode = const [],
    this.leadingNavigationBarButtons = const [],
    this.trailingNavigationBarButtons = const [],
    this.automaticallyHidesNavigationBar = false,
    this.hidesButtonsWithNavigationBar = false,
    this.isPanningInterfaceVisible = false,
  });

  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'title': title,
        'mapButtons': mapButtons.map((e) => e.toJson()).toList(),
        'dashboardButtons': dashboardButtons.map((e) => e.toJson()).toList(),
        'mapButtonsWhilePanningMode':
            mapButtonsWhilePanningMode.map((e) => e.toJson()).toList(),
        'barButtonsWhilePanningMode':
            barButtonsWhilePanningMode.map((e) => e.toJson()).toList(),
        'leadingNavigationBarButtons':
            leadingNavigationBarButtons.map((e) => e.toJson()).toList(),
        'trailingNavigationBarButtons':
            trailingNavigationBarButtons.map((e) => e.toJson()).toList(),
        'automaticallyHidesNavigationBar': automaticallyHidesNavigationBar,
        'hidesButtonsWithNavigationBar': hidesButtonsWithNavigationBar,
        'isPanningInterfaceVisible': isPanningInterfaceVisible,
      };

  /// Update the properties of the [CPMapTemplate]
  void update({
    String? title,
    List<CPMapButton>? mapButtons,
    List<CPBarButton>? leadingNavigationBarButtons,
    List<CPBarButton>? trailingNavigationBarButtons,
    bool? automaticallyHidesNavigationBar,
    bool? hidesButtonsWithNavigationBar,
    bool togglePanningInterface = false,
  }) {
    // update title
    if (title != null) this.title = title;

    // update mapButtons
    if (mapButtons != null) this.mapButtons = mapButtons;

    // update leadingNavigationBarButtons
    if (leadingNavigationBarButtons != null) {
      this.leadingNavigationBarButtons = leadingNavigationBarButtons;
    }

    // update trailingNavigationBarButtons
    if (trailingNavigationBarButtons != null) {
      this.trailingNavigationBarButtons = trailingNavigationBarButtons;
    }

    // update automaticallyHidesNavigationBar
    if (automaticallyHidesNavigationBar != null) {
      this.automaticallyHidesNavigationBar = automaticallyHidesNavigationBar;
    }

    // update hidesButtonsWithNavigationBar
    if (hidesButtonsWithNavigationBar != null) {
      this.hidesButtonsWithNavigationBar = hidesButtonsWithNavigationBar;
    }

    // update isPanningInterfaceVisible
    if (togglePanningInterface) {
      isPanningInterfaceVisible = !isPanningInterfaceVisible;
      if (isPanningInterfaceVisible) {
        showPanningInterface();
      } else {
        dismissPanningInterface();
      }
    }

    FlutterCarplayController.updateCPMapTemplate(this);
  }

  /// Displays a trip preview on [CPMapTemplate]
  void showTripPreviews({
    List<CPTrip> trips = const [],
    CPTrip? selectedTrip,
    CPTripPreviewTextConfiguration? textConfiguration,
  }) {
    FlutterCarplayController.showTripPreviews(
      uniqueId,
      trips,
      selectedTrip,
      textConfiguration,
    );
  }

  /// Hides the trip preview on [CPMapTemplate]
  void hideTripPreviews() {
    FlutterCarplayController.hideTripPreviews(uniqueId);
  }

  /// Displays a banner on [CPMapTemplate]
  void showBanner({required String message, required int color}) {
    FlutterCarplayController.showBanner(uniqueId, message, color);
  }

  /// Hides the banner on [CPMapTemplate]
  void hideBanner() {
    FlutterCarplayController.hideBanner(uniqueId);
  }

  /// Displays a banner on [CPMapTemplate]
  void showToast({
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    FlutterCarplayController.showToast(uniqueId, message, duration);
  }

  /// Displays an overlay card on [CPMapTemplate]
  void showOverlay({
    String? primaryTitle,
    String? secondaryTitle,
    String? subtitle,
  }) {
    FlutterCarplayController.showOverlay(
      uniqueId,
      primaryTitle,
      secondaryTitle,
      subtitle,
    );
  }

  /// Hides the overlay on [CPMapTemplate]
  void hideOverlay() {
    FlutterCarplayController.hideOverlay(uniqueId);
  }

  /// Starts a navigation.
  void startNavigation({required CPTrip trip}) {
    FlutterCarplayController.startNavigation(
      uniqueId,
      trip,
    );
  }

  /// Stops a navigation.
  void stopNavigation() {
    FlutterCarplayController.stopNavigation(uniqueId);
  }

  /// Show panning interface on the [CPMapTemplate]
  void showPanningInterface({bool animated = true}) {
    FlutterCarplayController.showPanningInterface(uniqueId, animated: animated);
  }

  /// Dismiss panning interface on the [CPMapTemplate]
  void dismissPanningInterface({bool animated = true}) {
    FlutterCarplayController.dismissPanningInterface(
      uniqueId,
      animated: animated,
    );
  }

  /// Zoom in on the [CPMapTemplate]
  void zoomInMapView() {
    FlutterCarplayController.zoomInMapView(uniqueId);
  }

  /// Zoom out on the [CPMapTemplate]
  void zoomOutMapView() {
    FlutterCarplayController.zoomOutMapView(uniqueId);
  }

  /// Center on the [CPMapTemplate]
  void centerMapView() {
    FlutterCarplayController.recenterMapView(uniqueId);
  }

  /// add list sub map on the [CPMapTemplate]
  void addMapList({required List<CPMapList> data}) {
    FlutterCarplayController.addMapList(uniqueId, data: data);
  }

  /// clear list sub map on the [CPMapTemplate]
  void clearMapList() {
    FlutterCarplayController.clearMapList(uniqueId);
  }

  /// scroll up list sub map on the [CPMapTemplate]
  void scrollUpMapList() {
    FlutterCarplayController.scrollUpMapList(uniqueId);
  }

  /// scroll down list sub map on the [CPMapTemplate]
  void scrollDownMapList() {
    FlutterCarplayController.scrollDownMapList(uniqueId);
  }

  /// add marker on the [CPMapTemplate]
  void addMarker({required List<CPMapPoint> data}) {
    FlutterCarplayController.addMarker(uniqueId, data: data);
  }

  /// add polyline on the [CPMapTemplate]
  void addPolyline({required List<CPMapPoint> data}) {
    FlutterCarplayController.addPolyline(uniqueId, data: data);
  }

  /// add polyline on the [CPMapTemplate]
  void clearAnnotation() {
    FlutterCarplayController.clearAnnotation(uniqueId);
  }

  String get uniqueId {
    return _elementId;
  }
}
