//
//  TorchLight.swift
//  TorchLight
//
//  Created by Suh Fangmbeng on 5/3/20.
//  Copyright © 2020 Hourworth LLC. All rights reserved.
//

import Foundation
import AVFoundation


class TorchLight {
    
    class var isOn: Bool {
        
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("Could not check for torch light because this device is unsupported")
            return false
        }
        
        do {
            try device.lockForConfiguration()
            let result = device.torchMode == AVCaptureDevice.TorchMode.on
            device.unlockForConfiguration()
            return result
        } catch {
            print(error)
        }
        return false
    }
}
