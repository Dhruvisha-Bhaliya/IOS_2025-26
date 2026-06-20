//
//  ViewController.swift
//  Assignment_3_4
//
//  Created by ict2batch1 on 02/03/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animateView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func Scale(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5){
            self.animateView.transform = self.animateView.transform.scaledBy(x: 1.5, y: 1.5)
        }
    }
    
    @IBAction func Move(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5){
            self.animateView.transform = self.animateView.transform.translatedBy(x: 100, y: 0)
        }
        
    }
    @IBAction func Reset(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
        self.animateView.transform = .identity
               self.animateView.alpha = 1.0
        }
    }
    @IBAction func Fade(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
             self.animateView.alpha = 0.2
         }
    }
    @IBAction func Rotate(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
              self.animateView.transform = self.animateView.transform.rotated(by: .pi)
          }
    }
}

