//
//  TorchLight.swift
//  TorchLight
//
//  Created by Suh Fangmbeng on 5/3/20.
//  Copyright © 2020 Hourworth LLC. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit


public class Torch {
    
    public enum state {
        public static var (on, off) = (false, false)
    }
    
    public var captureDevice: AVCaptureDevice?
    
    public init() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video), device.hasTorch, device.hasFlash else {
            print("Could not initialize TorchLight framework because the device is not supported.")
            return
        }
        captureDevice = device
    }
    
    public func isOn() -> Bool {
        try? captureDevice?.lockForConfiguration()
        let result = captureDevice?.torchMode == AVCaptureDevice.TorchMode.on
        captureDevice?.unlockForConfiguration()
        return result
    }
    
    public func isOff() -> Bool {
        try? captureDevice?.lockForConfiguration()
        let result = captureDevice?.torchMode == AVCaptureDevice.TorchMode.off
        captureDevice?.unlockForConfiguration()
        return result
    }
    
    public func turnOn() {
        if isOff() {
            guard let device = captureDevice else {return}
            try? device.lockForConfiguration()
            try? device.setTorchModeOn(level: 1.0)
            device.unlockForConfiguration()
            state.on = true
        } else {
            print("Torch Light is already on")
        }
    }
    
    public func turnOff() {
        if isOn() {
            guard let device = captureDevice else {return}
            try? device.lockForConfiguration()
            device.torchMode = AVCaptureDevice.TorchMode.off
            device.unlockForConfiguration()
            state.on = false
        } else {
            print("Torch Light is already off")
        }
    }

    deinit {
        print("Memory allocated for Torchlight has been deallocated")
    }
}
