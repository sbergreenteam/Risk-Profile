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
    
    private let previousButton = UIButton(title: "ПРЕД", titleColor: .gray, font: .boldSystemFont(ofSize: 14), target: self, action: #selector(handlePrev))
    
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private let nextButton = UIButton(title: "СЛЕД", titleColor: .rgb(red: 78, green: 228, blue: 78), font: .boldSystemFont(ofSize: 14), target: self, action: #selector(handleNext))
    
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
        pc.currentPageIndicatorTintColor = UIColor.rgb(red: 78, green: 228, blue: 78)
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
        
        
        
    }
    
    private func downloadQuestions() {
        self.questions = Bundle.main.decode([Question].self, from: "questions.json")
        
    }
    
    private func registerCells() {
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(FinalCell.self, forCellWithReuseIdentifier: "finalCellId")
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




