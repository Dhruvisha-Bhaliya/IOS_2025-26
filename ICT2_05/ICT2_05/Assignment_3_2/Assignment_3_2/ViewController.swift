//
//  ViewController.swift
//  Assignment_3_2
//
//  Created by ict2batch1 on 23/02/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var lblinfo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enable user interaction
        imgview.isUserInteractionEnabled = true
        lblinfo.isUserInteractionEnabled = true
        
        // 1️⃣ Pinch Gesture (Zoom image)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        imgview.addGestureRecognizer(pinchGesture)
        
        // 2️⃣ Rotate Gesture (Rotate image)
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(_:)))
        imgview.addGestureRecognizer(rotateGesture)
        
        // 3️⃣ Pan Gesture (Drag label)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        lblinfo.addGestureRecognizer(panGesture)
    }

    // Pinch to zoom
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let view = gesture.view else { return }
        view.transform = view.transform.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1
    }

    @IBAction func handleRotate(_ sender: UIRotationGestureRecognizer) {
        
    }

    // Drag
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        guard let view = gesture.view else { return }
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        gesture.setTranslation(.zero, in: self.view)
    }
}

