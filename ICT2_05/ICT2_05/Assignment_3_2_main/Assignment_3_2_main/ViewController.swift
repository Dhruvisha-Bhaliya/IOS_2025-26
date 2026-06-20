//
//  ViewController.swift
//  Assignment_3_2_main
//
//  Created by ict2batch1 on 02/03/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func PinchGesture(_ sender: UIPinchGestureRecognizer) {
        guard let view = sender.view else { return }

        view.transform = view.transform.scaledBy(
        x: sender.scale,
        y: sender.scale
        )

        sender.scale = 1.0
    }
    
    @IBAction func RotateGesture(_ sender: UIRotationGestureRecognizer) {
        imgView.transform = imgView.transform.rotated(
        by: sender.rotation
        )
        sender.rotation = 0
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if let draggedView = sender.view {
            draggedView.center = CGPoint(
                x: draggedView.center.x + translation.x,
                y: draggedView.center.y + translation.y
            )
        }
        sender.setTranslation(.zero, in: view)
    }
}

