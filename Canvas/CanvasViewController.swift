//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Sangwoo Nam on 4/12/17.
//  Copyright © 2017 Codepath. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    var trayOriginalCenter: CGPoint!
    
    @IBOutlet weak var trayView: UIView!
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    var placedFaceOriginalCenter: CGPoint!

    @IBOutlet weak var arrowView: UIImageView!

    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let trayState = sender.state
        if trayState == .began {
            trayOriginalCenter = trayView.center
        }
        
        if trayState == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            /*
            UIView.animate(withDuration: 0.3, animations: {
                self.arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            })
 */
        }
        if trayState == .ended {
            var velocity = sender.velocity(in: view)
            if (velocity.y > 0) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.trayView.center = self.trayDown
                })
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 200
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let state = sender.state
        let translation = sender.translation(in: view)
        if state == .began {
            
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            
            
        }
        if state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        if state == .ended {
            newlyCreatedFace.addGestureRecognizer(UIPanGestureRecognizer(target:self, action: #selector(didPanPlacedFace)))
            newlyCreatedFace.isUserInteractionEnabled = true
        }
    }
    
    func didPanPlacedFace(_ sender: UIPanGestureRecognizer) {
        let state = sender.state
        let translation = sender.translation(in: view)
        var placedFace = sender.view as! UIImageView
        if state == .began {
            placedFaceOriginalCenter = placedFace.center
        }
        if state == .changed {
            placedFace.center = CGPoint(x: placedFaceOriginalCenter.x + translation.x, y: placedFaceOriginalCenter.y + translation.y)     
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
