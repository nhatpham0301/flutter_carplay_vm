//
// FCPMapViewController.swift
// flutter_carplay
//
// Created by Oğuzhan Atalay on on 19/01/24.
// Copyright © 2024. All rights reserved.
//

import CarPlay
import MapKit
import UIKit
import VietMap

/// A custom CarPlay map view controller.
class FCPMapViewController: UIViewController, CLLocationManagerDelegate {
    /// The map view associated with the map view controller.
    var mapView: MGLMapView!
    
    var listViewMap: FCPMapListController?
    
    var coordinates: [CLLocationCoordinate2D] = []
    
    let _url = Bundle.main.object(forInfoDictionaryKey: "VietMapURL") as! String
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startMapView()
    }
    
    /// View did appear
    /// - Parameter animated: Animated
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { _,_ in
                DispatchQueue.main.async {
                    CLLocationManager().requestWhenInUseAuthorization()
                }
            }
        }
        
    }
    
    /// View safe area insets
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
    }
    
    func startMapView() {
        mapView = MGLMapView(frame: view.bounds, styleURL: URL(string: _url))
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.userTrackingMode = .follow
        mapView.compassView.compassVisibility = .hidden
        mapView.isRotateEnabled = true
        mapView.isScrollEnabled = true
        mapView.isZoomEnabled = true
        
        view.addSubview(mapView)
    }
    
    func addPoint(point: FCPMapPointModel) {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: point.getLat() ?? 0.0, longitude: point.getLng() ?? 0.0)
        annotation.title = point.getTitle() ?? ""
        annotation.subtitle = point.getSubTitle() ?? ""
        mapView.addAnnotation(annotation)
    }
    
    func addMarker(mapPoints: [FCPMapPointModel]) {
        for point in mapPoints {
            addPoint(point: point)
        }
    }
    
    func clearAnnotaion() {
        mapView.removeAnnotations(mapView.annotations ?? [])
    }
    
    func addPolyline(coordinates: [CLLocationCoordinate2D]) {
        let polyline = MGLPolyline(coordinates: coordinates, count: UInt(coordinates.count))
        mapView.addAnnotation(polyline)
    }
    
    func showSubviews() {
    }
    
    func hideSubviews() {
    }
    
    func zoomInMapView() {
        let currentZoomLevel = mapView.zoomLevel
        if currentZoomLevel > 15 {return}
        let newZoomLevel = currentZoomLevel + 1
        mapView.setZoomLevel(newZoomLevel, animated: true)
    }
    
    func zoomOutMapView() {
        let currentZoomLevel = mapView.zoomLevel
        if currentZoomLevel < 2 {return}
        let newZoomLevel = currentZoomLevel - 1
        mapView.setZoomLevel(newZoomLevel, animated: true)
    }
    
    func centerMap() {
        if let coordinate = mapView.userLocation?.coordinate {
            mapView.setCenter(coordinate, animated: true)
        }
    }
    
    func panInDirection(_ direction: CPMapTemplate.PanDirection) {
        MemoryLogger.shared.appendEvent("Panning to \(direction).")
        
        var offset = view.center
        switch direction {
        case .down:
            offset.y += view.bounds.size.height / 2.0
        case .up:
            offset.y -= view.bounds.size.height / 2.0
        case .left:
            offset.x -= view.bounds.size.width / 2.0
        case .right:
            offset.x += view.bounds.size.width / 2.0
        default:
            break
        }
        
        // Update the Map camera position
        let offsetCoordinate = mapView.convert(offset, toCoordinateFrom: mapView)
        let camera = MGLMapCamera(lookingAtCenter: offsetCoordinate, altitude: mapView.camera.altitude, pitch: mapView.camera.pitch, heading: mapView.camera.heading)
        mapView.setCamera(camera, animated: true)
    }
    
    func addMapList(data: [FCPMapListModel]) {
        mapView.frame = CGRect(x: 300, y: 0, width: view.frame.width - 300, height: view.frame.height)
        listViewMap = FCPMapListController(data: data)
        if let listViewMap = listViewMap {
            listViewMap.view.frame = CGRect(x: 0, y: 0, width: 300, height: view.frame.height)
            listViewMap.viewRespectsSystemMinimumLayoutMargins = false
            addChild(listViewMap)
            view.addSubview(listViewMap.view)
            listViewMap.didMove(toParent: self)
        }
    }
    
    func clearMapList() {
        if let listViewMap = listViewMap {
            listViewMap.view.removeFromSuperview()
            mapView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        }
    }
}


extension FCPMapViewController: MGLMapViewDelegate {}
