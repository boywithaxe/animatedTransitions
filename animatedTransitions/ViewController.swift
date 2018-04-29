//
//  ViewController.swift
//  animatedTransitions
//
//  Created by Greg Szydlo on 27/04/2018.
//  Copyright © 2018 Greg Szydlo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    var runningAnimators = [UIViewPropertyAnimator]()
    var state: State = .Collapsed

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Perform  all animations with animators id not already running
    func animateTransitionIfNeeded(state: State, duration: TimeInterval) {
        if runningAnimators.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .Expanded:
                    self.commentView.frame = CGRect(x: 0, y: 96, width: Int(self.commentView.frame.width), height: 300) // TODO figure out the coordiantes here
                case .Collapsed:
                    self.commentView.frame = CGRect(x: 0, y: 654, width: Int(self.commentView.frame.width), height: 82) // TODO figure out the coordiantes here
                    
                }
                
            }
            
            print (self.commentView.frame)
            frameAnimator.startAnimation()
            runningAnimators.append(frameAnimator)
        }
    }
    
    //Start transition if necessary, or reverse it on tap
    func animateOrReverseRunningTransition(state: State, duration: TimeInterval) {
        if runningAnimators.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        } else {
            for animator in runningAnimators {
                animator.isReversed = !animator.isReversed
            }
        }
    }
    
    func animateSizeChange(state: State, duration: TimeInterval) {
        switch state {
        case .Expanded:
            UIView.animate(withDuration: duration) {
                self.commentView.frame = CGRect(x: 0, y: 110, width: Int(self.commentView.frame.width), height: 636)
                print(self.commentView.frame)
            }
        case .Collapsed:
            UIView.animate(withDuration: duration) {
                self.commentView.frame = CGRect(x: 0, y: 654, width: Int(self.commentView.frame.width), height: 82)
                print(self.commentView.frame)
            }
        }
    }
    
    @IBAction func handleTap(recognizer: UITapGestureRecognizer) {
        print("Tapped")
        print(state)
        if state == .Collapsed {
            state = .Expanded
        } else {
            state = .Collapsed
        }
        //animateTransitionIfNeeded(state: state, duration: 5)
        //animateOrReverseRunningTransition(state: state, duration: 5)
        animateSizeChange(state: state, duration: 0.5)
        
    }
    
    
}

protocol StateProtocol {
    func toggle()
}

enum State: String {
    case Expanded
    case Collapsed
}

extension UIView: PropertyStoring {


    typealias T = State
    
    private struct CustomProperties {
        static var state = State.Collapsed
    }
    
    var state : State {
        get {
            return getAssociatedObject(&CustomProperties.state, defaultValue: CustomProperties.state)
        }
        set {
            return objc_setAssociatedObject(self, &CustomProperties.state, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
//    func toggle() {
//        state = state == .Expanded ? .Collapsed : .Expanded
//
//        if state == .Expanded {
//
//        }
//    }
    
    
   
    
    
}

