
//
//  ViewController.swift
//  Cameloan
//
//  Created by KARIM on 10/17/19.
//  Copyright © 2019 KARIM. All rights reserved.
//



let names = ["karim 1","karim 2","karim 3","karim 4","karim 5","karim 6"]

import UIKit
import TinderSwipeView

class ViewController: UIViewController {
    
    private var swipeView: TinderSwipeView<UserModel>!{
        didSet{
            self.swipeView.delegate = self
        }
    }
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewNavigation: UIView!{
        didSet{
            self.viewNavigation.alpha = 0.0
        }
    }
    //@IBOutlet weak var emojiView: EmojiRateView!
    
    let userModels : [UserModel] =  {
        var model : [UserModel] = []
        for n in 1...30 {
            model.append(UserModel(name: names[Int(arc4random_uniform(UInt32(names.count)))], num: "\(n)"))
        }
        return model
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dynamically create view for each tinder card
        let contentView: (Int, CGRect, UserModel) -> (UIView) = { (index: Int ,frame: CGRect , userModel: UserModel) -> (UIView) in
            
            // Programitcally creating content view
            if index % 2 != 0 {
                return self.programticViewForOverlay(frame: frame, userModel: userModel)
            }
            // loading contentview from nib 
            else{
                let customView = CustomView(frame: frame)
                customView.userModel = userModel
                return customView
            }
        }
                
        swipeView = TinderSwipeView<UserModel>(frame: viewContainer.bounds, contentView: contentView)
        viewContainer.addSubview(swipeView)
        swipeView.showTinderCards(with: userModels ,isDummyShow: true)
    }
    
    private func programticViewForOverlay(frame:CGRect, userModel:UserModel) -> UIView{
    
        let containerView = UIView(frame: frame)
        
        let backGroundImageView = UIImageView(frame:containerView.bounds)
        backGroundImageView.image = UIImage(named:String(Int(1 + arc4random() % (8 - 1))))
        backGroundImageView.contentMode = .scaleAspectFill
        backGroundImageView.clipsToBounds = true;
        containerView.addSubview(backGroundImageView)
        
        let profileImageView = UIImageView(frame:CGRect(x: 25, y: frame.size.height - 80, width: 60, height: 60))
        profileImageView.image =  #imageLiteral(resourceName: "profileimage")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        containerView.addSubview(profileImageView)
        
        let labelText = UILabel(frame:CGRect(x: 90, y: frame.size.height - 80, width: frame.size.width - 100, height: 60))
        labelText.attributedText = self.attributeStringForModel(userModel: userModel)
        labelText.numberOfLines = 2
        containerView.addSubview(labelText)
        
        return containerView
    }
    
 
    
    private func attributeStringForModel(userModel:UserModel) -> NSAttributedString{
        
        let attributedText = NSMutableAttributedString(string: userModel.name, attributes: [.foregroundColor: UIColor.white,.font:UIFont.boldSystemFont(ofSize: 25)])
        attributedText.append(NSAttributedString(string: "\nitem :\( userModel.num!) ", attributes: [.foregroundColor: UIColor.white,.font:UIFont.systemFont(ofSize: 18)]))
        return attributedText
    }
    

    @IBAction func leftSwipeAction(_ sender: Any) {
        if let swipeView = swipeView{
            swipeView.makeLeftSwipeAction()
        }
    }
    
    @IBAction func rightSwipeAction(_ sender: Any) {
        if let swipeView = swipeView{
            swipeView.makeRightSwipeAction()
        }
    }
    
    @IBAction func undoButtonPressed(_ sender: Any) {
        if let swipeView = swipeView{
            swipeView.undoCurrentTinderCard()
        }
    }
}


