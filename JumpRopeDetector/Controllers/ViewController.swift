//
//  ViewController.swift
//  JumpRopeDetector
//
//  Created by Ege Hurturk on 11.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var previewView: UIView!

    private var videoCapture: VideoCapture? = nil
    private let ropeDetectionController = RopeDetectionController()

    override func viewDidLoad() {
        super.viewDidLoad()
        videoCapture = VideoCapture(previewView: self.previewView, captureHandler: { [self] (pixelBuffer: CVPixelBuffer) in
           ropeDetectionController.countJumps(pixelBuffer: pixelBuffer)
           
       })
       if !(videoCapture?.setupAVCapture())! {
           showAlert(title: "Error", message: "Device must contain a video device.")
           return
       }
       
       ropeDetectionController.setBufferSize(bufferSize: videoCapture!.bufferSize)
       ropeDetectionController.setRootLayer(rootLayer: videoCapture!.getRootLayer())
       ropeDetectionController.setupLayers()
       
       videoCapture?.startCaptureSession()
    }


    private func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            self.present(ac, animated: true, completion: nil)
        }
    }
}

