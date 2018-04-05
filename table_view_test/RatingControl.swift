//
//  RatingControl.swift
//  table_view_test
//
//  Created by nine on 05/04/18.
//  Copyright © 2018 nine. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //IBDesignable is added as it shows red border for the view which means there is some error in the view
    //MARK: PROPERTIES
    private var ratingButtons = [UIButton]() //list of buttons
    var  rating = 0{
        didSet{
            updateButtonSelectionStates()
        }
    }
    @IBInspectable var starsize : CGSize = CGSize(width: 44.0, height: 44.0){
        didSet{
            setupButtons()
        }
    } //insoectable lets you set properties to inspecter attribute
    @IBInspectable var starCount : Int = 5{
        didSet{
            setupButtons()
        }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Private Methods
    private func setupButtons(){
        //clear any existing buttons
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        //Load button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
            // "_" used when u dont need to know which iteration is executing for _ in 0..<5
            
            //create a red button
            let button = UIButton()
            
            //setting button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            
            //add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starsize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starsize.width).isActive = true
            
            //set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            //set up button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //add the button to the stack
            addArrangedSubview(button)
            
            //adding new button to the stack
            ratingButtons.append(button)
            
        }
        updateButtonSelectionStates()
    }
    
    //MARK: Add button action
    @objc func  ratingButtonTapped(button: UIButton) {
            guard let index = ratingButtons.index(of: button) else{
                fatalError("The button, \(button), is not in the ratingbuttons array: \(ratingButtons)")
        }
        
        //calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            //if the sekcted star represents the current rating, rest the rating to 0.
            rating = 0
        }else{
            //otherwise set the rating to the selected star
            rating  = selectedRating
        }
    }
    
    private func updateButtonSelectionStates()  {
        for(index, button) in ratingButtons.enumerated(){
            button.isSelected = index < rating
            
            //set the hint string for the currenlty selected star
            let hintString: String?
            if rating == index + 1{
                hintString = "Tap to reset the rating to zero"
            }else{
                hintString = nil
            }
            
            //calculate the value string
            let valueString: String
            switch(rating){
            case 0:
                valueString = "No rating set"
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set"
            
            }
            
            //assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}

