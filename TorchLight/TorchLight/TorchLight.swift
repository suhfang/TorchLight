//
//  TorchLight.swift
//  TorchLight
//
//  Created by Suh Fangmbeng on 5/3/20.
//  Copyright © 2020 Hourworth LLC. All rights reserved.
//

import Foundation
import AVFoundation


public enum BlinkStyle {
    public static var (on, off) = (false, false)
}

public class Torch {
    
    public var captureDevice: AVCaptureDevice?
    public var timer: Timer?
    public var blinkStyle: BlinkStyle = .default
    
    public enum BlinkStyle {
        case `default`, trafficate, airplane
    }
    
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
        } else {
            print("Torch Light is already off")
        }
    }
    
    
    private func trafficate() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] (_) in
            self?.turnOn()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[weak self] in
                self?.turnOff()
            }
        })
    }
    
    private func startDefaultBlinking() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {[weak self] (_) in
            self?.turnOn()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {[weak self] in
                self?.turnOff()
            }
        })
    }
    
    func startBlinking() {
        switch blinkStyle {
        case .trafficate: trafficate()
        case .airplane: airplane()
        default: startDefaultBlinking()
        }
    }
    
    private func airplane() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] (_) in
            self?.turnOn()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[weak self] in
                self?.turnOff()
            }
        })
    }

    deinit {
        print("Memory allocated for Torchlight has been deallocated")
    }
}
