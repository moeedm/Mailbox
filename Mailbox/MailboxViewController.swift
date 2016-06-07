//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Moeed Mohammad on 6/5/16.
//  Copyright © 2016 Moeed Mohammad. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var laterImageView: UIImageView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var archiveImageView: UIImageView!
    @IBOutlet weak var deleteImageView: UIImageView!
    @IBOutlet weak var listMenuView: UIView!
    @IBOutlet weak var rescheduleView: UIView!
    
    var messageOriginalCenter: CGPoint!
    var laterOriginalCenter: CGPoint!
    var listOriginalCenter: CGPoint!
    var archiveOriginalCenter: CGPoint!
    var deleteOriginalCenter: CGPoint!
    
    var laterBreakpoint: CGFloat = -40
    var listBreakpoint: CGFloat = -197
    var archiveBreakpoint: CGFloat = 40
    var deleteBreakpoint: CGFloat = 197
    var firstIconOffset: CGFloat = 42
    var secondIconOffset: CGFloat = 204
    
    var yellowColor: UIColor = UIColor(red:1.00, green:0.82, blue:0.23, alpha:1.00)
    var brownColor: UIColor = UIColor(red:0.84, green:0.65, blue:0.47, alpha:1.00)
    var greenColor: UIColor = UIColor(red:0.45, green:0.84, blue:0.41, alpha:1.00)
    var redColor: UIColor = UIColor(red:0.91, green:0.33, blue:0.23, alpha:1.00)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the height of scrollView
        scrollView.contentSize = CGSize(width: 320, height: 1390)
        
        // Semitransparent Icons
        laterImageView.alpha = 0.5
        listImageView.alpha = 0
        archiveImageView.alpha = 0.5
        deleteImageView.alpha = 0
        listMenuView.alpha = 0
        rescheduleView.alpha = 0
        
        laterOriginalCenter = laterImageView.center
        listOriginalCenter = listImageView.center
        archiveOriginalCenter = archiveImageView.center
        deleteOriginalCenter = deleteImageView.center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        
        // Began Panning
        if sender.state == UIGestureRecognizerState.Began {

            // Store the original point in a variable
            messageOriginalCenter = messageImageView.center
            
        // Is Panning
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            print(translation.x)
            
            // Make the center whatever the center was before plus the translation of x
            messageImageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
            
            // Archive State
            if translation.x > archiveBreakpoint && translation.x < deleteBreakpoint {
                messageView.backgroundColor = greenColor
                deleteImageView.alpha = 0
                archiveImageView.alpha = 1
                archiveImageView.center = CGPoint(x:archiveOriginalCenter.x + translation.x - firstIconOffset, y: archiveOriginalCenter.y)
                
            // Delete State
            } else if translation.x > deleteBreakpoint {
                messageView.backgroundColor = redColor
                archiveImageView.alpha = 0
                deleteImageView.alpha = 1
                deleteImageView.center = CGPoint(x:deleteOriginalCenter.x + translation.x - secondIconOffset, y: deleteOriginalCenter.y)
            
            // Later State
            } else if translation.x < laterBreakpoint && translation.x > listBreakpoint  {
                messageView.backgroundColor = yellowColor
                listImageView.alpha = 0
                laterImageView.alpha = 1
                laterImageView.center = CGPoint(x: laterOriginalCenter.x + translation.x + firstIconOffset, y: laterOriginalCenter.y)
            
            // List State
            } else if translation.x < listBreakpoint {
                messageView.backgroundColor = brownColor
                laterImageView.alpha = 0
                listImageView.alpha = 1
                listImageView.center = CGPoint(x: listOriginalCenter.x + translation.x + secondIconOffset, y: listOriginalCenter.y)
            }
            
        // Stopped Panning
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if translation.x < -197 {
                UIView.animateWithDuration(0.4, animations: { 
                    self.listMenuView.alpha = 1
                })
                
            } else if translation.x < -100 && translation.x > -197 {
                UIView.animateWithDuration(0.4, animations: {
                    self.rescheduleView.alpha = 1
                })
            
            } else if translation.x > 197 {
                UIView.animateWithDuration(0.4, animations: { 
                    // code
                    }, completion: { (Bool) in
                        //code
                })
            
            } else {
                // Move message back to its original state
                UIView.animateWithDuration(0.4, animations: {
                    self.messageImageView.center = self.messageOriginalCenter
                    self.messageView.backgroundColor = UIColor.lightGrayColor()
                    
                    self.laterImageView.alpha = 0.5
                    self.listImageView.alpha = 0
                    self.archiveImageView.alpha = 0.5
                    self.deleteImageView.alpha = 0
                    
                    self.laterImageView.center = self.laterOriginalCenter
                    self.listImageView.center = self.listOriginalCenter
                    self.archiveImageView.center = self.archiveOriginalCenter
                    self.deleteImageView.center = self.deleteOriginalCenter
                    self.laterImageView.center = self.laterOriginalCenter
                })
            }
            
            
        }
    }
    
    @IBAction func dismissListMenu(sender: UIButton) {
        UIView.animateWithDuration(0.4) { 
            self.listMenuView.alpha = 0
        }
        
        messageImageView.center = messageOriginalCenter
        laterImageView.center = laterOriginalCenter
        listImageView.center = listOriginalCenter
        
        laterImageView.alpha = 0.5
        listImageView.alpha = 0
    }
    
    @IBAction func dismissRescheduleMenu(sender: AnyObject) {
        UIView.animateWithDuration(0.4) {
            self.rescheduleView.alpha = 0
        }
        
        messageImageView.center = messageOriginalCenter
        laterImageView.center = laterOriginalCenter
        listImageView.center = listOriginalCenter
        
        laterImageView.alpha = 0.5
        listImageView.alpha = 0
        
    
    }
}


// ==================================================================

// Stuff that didn't work

//            if velocity.x < 0 {
////                UIView.animateWithDuration(1, animations: {
////                    self.laterImageView.alpha = 1
////                    self.messageView.backgroundColor = UIColor(red:1.00, green:0.82, blue:0.23, alpha:1.00)
////                })
//                print("moved left")
//            } else if velocity.x > 0 {
////                UIView.animateWithDuration(1, animations: {
////                    self.messageView.backgroundColor = UIColor.lightGrayColor()
////                })
//                print("moved right")
//            }
//
//            if translation.x <= -60 {
//                messageView.backgroundColor = UIColor(red:1.00, green:0.82, blue:0.23, alpha:1.00)
//            }

//UIView.animateWithDuration(0.4, animations: {
//    self.messageView.backgroundColor = UIColor(red:1.00, green:0.82, blue:0.23, alpha:1.00)
//})


// ==================================================================


//                else if translation.x <= -97 {
//                    UIView.animateWithDuration(0.4, animations: {
//                        self.messageView.backgroundColor = self.brownColor
//                        self.laterImageView.alpha = 0
//                        self.listImageView.alpha = 1
//                        self.messageImageView.alpha = 0.3
//                        self.listImageView.center = CGPoint(x: self.listOriginalCenter.x + translation.x + 45, y: self.listOriginalCenter.y)
//                    }
//                )}



// ==================================================================

// While Panning left
//            if velocity.x < 0 {
//                print("Going left: \(translation)")
//
//
//            // While Panning Right
//            } else {
//                print("Going right")
//
//                // Change the background to green
//                UIView.animateWithDuration(0.4, animations: {
//                    self.messageView.backgroundColor = self.yellowColor
//                })
//
//            }
//

