//
//  TorchLight.swift
//  TorchLight
//
//  Created by Suh Fangmbeng on 5/3/20.
//  Copyright © 2020 Hourworth LLC. All rights reserved.
//

import Foundation
import AVFoundation


class Torch {
    
    static let shared = Torch()
    private var captureDevice: AVCaptureDevice?
    private var timer: Timer?
    
    init() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video), device.hasTorch, device.hasFlash else {
            print("Could not initialize TorchLight framework because the device is not supported.")
            return
        }
        captureDevice = device
    }
    
    func isOn() -> Bool {
        try? captureDevice?.lockForConfiguration()
        let result = captureDevice?.torchMode == AVCaptureDevice.TorchMode.on
        captureDevice?.unlockForConfiguration()
        return result
    }
    
    func isOff() -> Bool {
        try? captureDevice?.lockForConfiguration()
        let result = captureDevice?.torchMode == AVCaptureDevice.TorchMode.off
        captureDevice?.unlockForConfiguration()
        return result
    }
    
    func turnOn() {
        if isOff() {
            guard let device = captureDevice else {return}
            try? device.lockForConfiguration()
            try? device.setTorchModeOn(level: 1.0)
            device.unlockForConfiguration()
        } else {
            print("Torch Light is already on")
        }
    }
    
    func turnOff() {
        if isOff() {
            guard let device = captureDevice else {return}
            try? device.lockForConfiguration()
            device.torchMode = AVCaptureDevice.TorchMode.off
            device.unlockForConfiguration()
        } else {
            print("Torch Light is already on")
        }
    }
    
    func toggleTorch() {
        if isOff() {
            turnOn()
        } else {
            turnOff()
        }
    }
    
    func makeFlash(every: Double) {
        timer = Timer.scheduledTimer(withTimeInterval: every, repeats: true, block: {[weak self] (timer) in
            self?.toggleTorch()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[weak self] in
                self?.toggleTorch()
            }
        })
    }
    
    deinit {
        print("Memory allocated for Torchlight has been deallocated")
    }
}
