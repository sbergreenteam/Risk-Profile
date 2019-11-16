//
//  ViewController.swift
//  Risk Profile
//
//  Created by Ikhtiyor Nurmatov on 16/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class RiskProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(imageName: "bear_first", headerText: "Когда вы инвестируете деньги, какова ваша главная цель?", bodyText: ""),
        Page(imageName: "heart_second", headerText: "Степень, с которой стоимость инвестиций увеличивается и уменьшается, называется волатильность (это одна из мер риска). Более волатильные инвестиции, как правило, на долгосрочном горизонте обеспечивают больший потенциал роста, чем менее волатильные инвестиции, но они могут привести к большим потерям. С какой волатильностью вам комфортно?", bodyText: ""),
        Page(imageName: "leaf_third", headerText: "Крайне консервативные инвестиции иногда зарабатывают меньше уровня инфляции. Это может привести к потере покупательной способности. В отношении ваших инвестиционных целей, что из нижеперечисленного является наиболее верным?", bodyText: ""),
        Page(imageName: "bear_first", headerText: "Вы понимаете, что стоимость инвестиций со временем будет колебаться, в зависимости от суммы принимаемого риска. С какой приблизительной потерей в течение одного года вы готовы смириться, прежде чем принять решение об изменении своих инвестиций?", bodyText: ""),
        Page(imageName: "heart_second", headerText: "Рассмотрим две различных инвестиции: Инвестиции A, которые обеспечивают среднегодовую доходность 5% с минимальным риском потери стоимости; и Инвестиции B, которые обеспечивают среднегодовую доходность 10% с возможностью потерь в размере –25% или более в любом году. Как бы вы распределили свой капитал для инвестиций?", bodyText: ""),
        Page(imageName: "leaf_third", headerText: "VЕсли бы вы могли выбрать только один из пяти гипотетических портфелей, представленных ниже, какой бы вы выбрали?", bodyText: "")
    ]
    
    private let previousButton = UIButton(title: "ПРЕД", titleColor: .gray, font: .boldSystemFont(ofSize: 14), target: self, action: #selector(handlePrev))
    
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private let nextButton = UIButton(title: "СЛЕД", titleColor: .mainPink, font: .boldSystemFont(ofSize: 14), target: self, action: #selector(handleNext))
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPink
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
        setupBottomControls()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.isPagingEnabled = true
    
        
    }
    
    private func downloadQuestions() {
        let questions = Bundle.main.decode([Question].self, from: "questions.json")
        for q in questions {
            print(q.question)
            print(q.answers)
        }
    }

}

// MARK: - UICollectionView DataSource, Delegate, Flowlayout

extension RiskProfileViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
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




