//
//  PageCell.swift
//  Risk Profile
//
//  Created by Ikhtiyor Nurmatov on 16/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    
    var page: Question? {
        didSet {
            guard let unwrappedPage = page else { return }
            guard let unwrappedAnswer = page?.answers else {return}
            localImageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.question, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)])
            let buttonAText = NSMutableAttributedString(string: unwrappedAnswer.a, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            let buttonBText = NSMutableAttributedString(string: unwrappedAnswer.b, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            let buttonCText = NSMutableAttributedString(string: unwrappedAnswer.c ?? "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            let buttonDText = NSMutableAttributedString(string: unwrappedAnswer.d ?? "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            let buttonEText = NSMutableAttributedString(string: unwrappedAnswer.e ?? "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
            button1.titleLabel?.attributedText = buttonAText
            button2.titleLabel?.attributedText = buttonBText
            button3.titleLabel?.attributedText = buttonCText
            button4.titleLabel?.attributedText = buttonDText
        }
    }
    
    
    let button1 = UIButton()
      let button2 = UIButton()
      let button3 = UIButton()
      let button4 = UIButton()
      let button5 = UIButton()
    
    
    private let localImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(bundleName: "example"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        
        button1.titleLabel?.numberOfLines = 0
        button2.titleLabel?.numberOfLines = 0
        button3.titleLabel?.numberOfLines = 0
        button4.titleLabel?.numberOfLines = 0
        button5.titleLabel?.numberOfLines = 0
        
        button1.titleLabel?.text = page?.answers.a
        button2.titleLabel?.text = page?.answers.b
        button3.titleLabel?.text = page?.answers.c
        button4.titleLabel?.text = page?.answers.d
        
//        button1.titleLabel?.adjustsFontSizeToFitWidth = true
//        button2.titleLabel?.adjustsFontSizeToFitWidth = true
//        button3.titleLabel?.adjustsFontSizeToFitWidth = true
//        button4.titleLabel?.adjustsFontSizeToFitWidth = true
//        button5.titleLabel?.adjustsFontSizeToFitWidth = true
   
        
        let topContainerView = UIView()
            addSubview(topContainerView)
            topContainerView.translatesAutoresizingMaskIntoConstraints = false

            topContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true

            topContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            topContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

            topContainerView.addSubview(localImageView)
            localImageView.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 100).isActive = true
            localImageView.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
            localImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.2).isActive = true
           
        topContainerView.addSubview(descriptionTextView)
            descriptionTextView.topAnchor.constraint(equalTo: localImageView.bottomAnchor).isActive = true
            descriptionTextView.leftAnchor.constraint(equalTo: topContainerView.leftAnchor, constant: 0).isActive = true
            descriptionTextView.rightAnchor.constraint(equalTo: topContainerView.rightAnchor, constant: 0).isActive = true
            topContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
            
            let radioButtonsContainerView = UIView()
            radioButtonsContainerView.translatesAutoresizingMaskIntoConstraints = false
            topContainerView.addSubview(radioButtonsContainerView)
            
            radioButtonsContainerView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor).isActive = true
            radioButtonsContainerView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
            radioButtonsContainerView.leftAnchor.constraint(equalTo: topContainerView.leftAnchor, constant: 0).isActive = true
            radioButtonsContainerView.rightAnchor.constraint(equalTo: topContainerView.rightAnchor, constant: 0).isActive = true
            radioButtonsContainerView.heightAnchor.constraint(equalTo: descriptionTextView.heightAnchor, multiplier: 0.5).isActive = true
            [button1, button2, button3, button4, button5].forEach { (button) in
                button.backgroundColor = .green
                button.translatesAutoresizingMaskIntoConstraints = false
            }
            [button1, button2, button3, button4, button5].forEach { radioButtonsContainerView.addSubview($0)
            }
            
            button2.widthAnchor.constraint(equalTo: button1.widthAnchor).isActive = true
            button2.heightAnchor.constraint(equalTo: button1.heightAnchor).isActive = true
            button3.widthAnchor.constraint(equalTo: button1.widthAnchor).isActive = true
            button3.heightAnchor.constraint(equalTo: button1.heightAnchor).isActive = true
            button4.widthAnchor.constraint(equalTo: button1.widthAnchor).isActive = true
            button4.heightAnchor.constraint(equalTo: button1.heightAnchor).isActive = true
            button5.widthAnchor.constraint(equalTo: button1.widthAnchor).isActive = true
            button5.heightAnchor.constraint(equalTo: button1.heightAnchor).isActive = true
            button1.leadingAnchor.constraint(equalTo: radioButtonsContainerView.leadingAnchor).isActive = true
            button1.trailingAnchor.constraint(equalTo: radioButtonsContainerView.trailingAnchor).isActive = true
            button2.centerYAnchor.constraint(equalTo: button1.centerYAnchor).isActive = true
            button3.centerYAnchor.constraint(equalTo: button1.centerYAnchor).isActive = true
            button4.centerYAnchor.constraint(equalTo: button1.centerYAnchor).isActive = true
            button5.centerYAnchor.constraint(equalTo: button1.centerYAnchor).isActive = true
            
            button1.topAnchor.constraint(equalTo: radioButtonsContainerView.topAnchor, constant: 2).isActive = true
            button1.bottomAnchor.constraint(equalTo: button2.topAnchor, constant: 2).isActive = true
            button2.bottomAnchor.constraint(equalTo: button3.topAnchor, constant: 2).isActive = true
            button3.bottomAnchor.constraint(equalTo: button4.topAnchor, constant: 2).isActive = true
            button4.bottomAnchor.constraint(equalTo: button5.topAnchor, constant: 2).isActive = true
            button5.bottomAnchor.constraint(equalTo: radioButtonsContainerView.bottomAnchor, constant: -2).isActive = true
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
