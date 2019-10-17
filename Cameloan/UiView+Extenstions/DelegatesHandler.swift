//
//  DelegatesHandler.swift
//  Cameloan
//
//  Created by KARIM on 10/17/19.
//  Copyright © 2019 KARIM. All rights reserved.
//

import UIKit
import TinderSwipeView


extension ViewController : TinderSwipeViewDelegate{
    
    func dummyAnimationDone() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveLinear, animations: {
            self.viewNavigation.alpha = 1.0
        }, completion: nil)
        print(" card shaked")
    }
    
    func didSelectCard(model: Any) {
        print("Selected card")
    }
    
    func fallbackCard(model: Any) {
        let userModel = model as! UserModel
        print("Cancelling \(userModel.name!)")
    }
    
    func cardGoesLeft(model: Any) {
        let userModel = model as! UserModel
        print(" Left \(userModel.name!)")
    }
    
    func cardGoesRight(model : Any) {
        let userModel = model as! UserModel
        print(" Right \(userModel.name!)")
    }
    
    func undoCardsDone(model: Any) {
        let userModel = model as! UserModel
        print("Reverting  \(userModel.name!)")
    }
    
    func endOfCardsReached() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
            self.viewNavigation.alpha = 0.0
        }, completion: nil)
        print("End of all cards")
    }
    
    func currentCardStatus(card object: Any, distance: CGFloat) {
        if distance == 0 {
            
            print("current distance \(distance)")
        }else{
            let value = Float(min(abs(distance/100), 1.0) * 5)
            
        }
        print(distance)
    }
}

