//
//  PermissionsManager.swift
//  BookShelf
//
//  Created by Endo on 25/05/25.
//

import Foundation
import AVFoundation
import UIKit

class PermissionsManager {
    
    init() {}
    
    func hasCameraPermission() -> Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        return authStatus == .authorized
        #endif
    }
    
    func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}
