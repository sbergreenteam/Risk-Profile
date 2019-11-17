//
//  ViewController.swift
//  Risk Profile
//
//  Created by Ikhtiyor Nurmatov on 16/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class RiskProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var questions = [Question]()

        let previousButton: UIButton = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            button.layer.cornerRadius = 15
            button.setTitle("ПРЕД", for: .normal)
            button.setTitleColor(.white, for: .normal)
//            button.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.6705882353, blue: 0.6823529412, alpha: 1)
            button.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.6156862745, blue: 0.3882352941, alpha: 1)
            button.addTarget(self, action: #selector(buttonTouchDownNormalPrev), for: .touchCancel)
            button.addTarget(self, action: #selector(handlePrev), for: .touchCancel)
            return button
        }()
    
//    private let previousButton = UIButton(title: "ПРЕД", titleColor: .gray, font: .boldSystemFont(ofSize: 14), target: self, action: #selector(handlePrev))
    
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    let nextButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.layer.cornerRadius = 15
        button.setTitle("СЛЕД", for: .normal)
        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.6705882353, blue: 0.6823529412, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.6156862745, blue: 0.3882352941, alpha: 1)
        button.addTarget(self, action: #selector(buttonTouchDownNormalNext), for: .touchCancel)
        button.addTarget(self, action: #selector(handleNext), for: .touchCancel)
        return button
    }()
    
//    private let nextButton = UIButton(title: "СЛЕД", titleColor: .rgb(red: 78, green: 228, blue: 78), font: .boldSystemFont(ofSize: 14), target: self, action: #selector(handleNext))
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, questions.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = self.questions.count
//        pc.currentPageIndicatorTintColor = UIColor.rgb(red: 78, green: 228, blue: 78)
        pc.currentPageIndicatorTintColor =  #colorLiteral(red: 0.1568627451, green: 0.6156862745, blue: 0.3882352941, alpha: 1)
        pc.pageIndicatorTintColor = UIColor.rgb(red: 249, green: 207, blue: 224)
        return pc
    }()
    
    private func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        downloadQuestions()
        
        setupBottomControls()
        
        collectionView?.backgroundColor = .white
        registerCells()
        
        collectionView?.isPagingEnabled = true
        
        
        let tapGestureRecognizerForPrev = UITapGestureRecognizer(target: self, action: #selector(addPulse(sender:)))
        tapGestureRecognizerForPrev.numberOfTapsRequired = 1
        previousButton.addGestureRecognizer(tapGestureRecognizerForPrev)
        
        let tapGestureRecognizerForNext = UITapGestureRecognizer(target: self, action: #selector(addPulse(sender:)))
        tapGestureRecognizerForNext.numberOfTapsRequired = 1
        nextButton.addGestureRecognizer(tapGestureRecognizerForNext)
        
        nextButton.pulsate()
        previousButton.pulsate()
    }
    
    private func downloadQuestions() {
        self.questions = Bundle.main.decode([Question].self, from: "questions.json")
    }
    
    private func registerCells() {
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(FinalCell.self, forCellWithReuseIdentifier: "finalCellId")
    }
    
     @objc
        func addPulse(sender: UITapGestureRecognizer){
            let position = sender.location(in: view)
            let pulse = Pulsing(numberOfPulses: 1, radius: 100, position: position)
            pulse.animationDuration = 0.5
            pulse.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.2666666667, blue: 0.5803921569, alpha: 1)
            self.view.layer.insertSublayer(pulse, below: nextButton.layer)
        }
    
    @objc
    func buttonTouchDownNormalNext() {
        nextButton.hiddenBtn()
    }
    
    @objc
    func buttonTouchDownNormalPrev() {
        previousButton.hiddenBtn()
    }

}

// MARK: - UICollectionView DataSource, Delegate, Flowlayout

extension RiskProfileViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == questions.count {
            let finalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "finalCellId", for: indexPath) as! FinalCell
            finalCell.imageView.image = UIImage(bundleName: "final")
            return finalCell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let question = questions[indexPath.item]
        cell.page = question
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}


extension RiskProfileViewController {

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
        
            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        
        }) { (_) in
        
        }
    }
    
}

extension UIButton {
    func pulsate() {
    let pulse = CASpringAnimation(keyPath: "transform.scale")
            pulse.duration = 0.6

            pulse.fromValue = 0.80
        pulse.toValue = 0.85
            pulse.autoreverses = true
            pulse.repeatCount = HUGE
            pulse.initialVelocity = 0.5
            pulse.damping = 1.0
            pulse.speed = 0.6
            layer.add(pulse, forKey: "pulse")
        }
    
    func flash() {
    let flash = CABasicAnimation(keyPath: "opacity")
            flash.duration = 0.5
            flash.fromValue = 1
            flash.toValue = 0.7
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            flash.autoreverses = true
            flash.repeatCount = HUGE
            layer.add(flash, forKey: nil)
        }
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
            shake.duration = 0.1
            shake.repeatCount = 2
            shake.autoreverses = true
        let fromPoint = CGPoint(x: center.x - 10, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 8, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        let fromPoint2 = CGPoint(x: center.x - 0, y: center.y)
        let fromValue2 = NSValue(cgPoint: fromPoint2)
        let toPoint2 = CGPoint(x: center.x + 15, y: center.y)
        let toValue2 = NSValue(cgPoint: toPoint2)
            shake.fromValue = fromValue
            shake.toValue = toValue
            shake.fromValue = fromValue2
            shake.toValue = toValue2
            layer.add(shake, forKey: "position")
        }
    
    func hiddenBtn() {
    let pulse = CASpringAnimation(keyPath: "transform.scale")
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.7
            flash.fromValue = 1
            flash.toValue = 0
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            flash.autoreverses = true
            flash.repeatCount = 1
            layer.add(flash, forKey: nil)
        }
}



