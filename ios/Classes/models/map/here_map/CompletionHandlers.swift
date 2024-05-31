//
//  CompletionHandlers.swift
//  flutter_carplay
//
//  Created by Bhavik Dodia on 29/03/24.
//

//import heresdk
import VietMap

/// Completion handler for primary maneuver actions.
var primaryManeuverActionTextHandler: ((String) -> Void)?

/// Completion handler for secondary maneuver actions.
var secondaryManeuverActionTextHandler: ((String) -> Void)?

/// Completion handler for toggle offline mode.
var toggleOfflineModeHandler: ((Bool) -> Void)?

/// Completion handler for toggle voice instructions.
var toggleVoiceInstructionsHandler: ((Bool) -> Void)?

/// Completion handler for toggle satellite view.
var toggleSatelliteViewHandler: ((Bool) -> Void)?

/// Completion handler for recenter map view.
var recenterMapViewHandler: ((String) -> Void)?
