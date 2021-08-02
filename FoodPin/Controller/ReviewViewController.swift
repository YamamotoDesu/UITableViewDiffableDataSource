//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by 山本響 on 2021/08/02.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var rateButtons: [UIButton]!
    
    @IBOutlet var closeButton: UIButton!
    
    var resutaurant = Restaurant()
    
    @IBAction func close(seque: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.image = UIImage(named: resutaurant.image)
        
        // Applying the blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        let moveScaleTransform = getScaleAnimation()
        
        // Make the button invisible
        for rateButton in rateButtons {
            rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
        }
        
        closeButton.alpha = 0
    }
    
    // Slide-in Animation
    override func viewWillAppear(_ animated: Bool) {
        //setStandardAnimation()
        setSpringAnimation()
    }
    
    func getScaleAnimation() -> CGAffineTransform {
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        return scaleUpTransform.concatenating(moveRightTransform)
    }
    
    func setSpringAnimation() {
        
        var delay: TimeInterval = 0.1
        for rateButton in self.rateButtons {
            UIView.animate(withDuration: 0.8, delay: delay, usingSpringWithDamping: 0.2,
                           initialSpringVelocity: 0.3, options: [], animations
                            :{
                                rateButton.alpha = 1.0
                                rateButton.transform = .identity
                            }, completion: nil)
            
            delay += 0.1
        }
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations:
                        {
                            self.closeButton.alpha = 1.0
                        }, completion: nil)
    }
    
    func setStandardAnimation() {
        var delay: TimeInterval = 0.1
        for rateButton in self.rateButtons {
            UIView.animate(withDuration: 0.4, delay: delay, options: [], animations:
                            {
                                rateButton.alpha = 1.0
                                rateButton.transform = .identity
                            }, completion: nil)
            
            delay += 0.1
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations:
                        {
                            self.closeButton.alpha = 1.0
                        }, completion: nil)

    }

}
