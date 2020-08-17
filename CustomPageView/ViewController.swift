//
//  ViewController.swift
//  CustomPageView
//
//  Created by Prapawit Patthasirivichot on 17/8/2563 BE.
//  Copyright © 2563 Prapawit Patthasirivichot. All rights reserved.
//

import UIKit

protocol TabViewDelegate {
    func tabViewDelegate(_ newIndex: Int)
}

class ViewController: UIViewController {
    
    
    private let viewControllers = [ViewControllersFactory.firstViewController(), ViewControllersFactory.secondViewController(), ViewControllersFactory.thirdViewController()]
    
    private var delegate: TabViewDelegate!
    private let pageViewController = ViewControllersFactory.pageViewController()
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    private func setupUI() {
        delegate = pageViewController as! PageViewController
        (pageViewController as! PageViewController).pageViewDelegate = self
        (pageViewController as! PageViewController).orderedViewControllers = viewControllers
        addChild(pageViewController)
        contentView.addSubview(pageViewController.view)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          pageViewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
          pageViewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
          pageViewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
          pageViewController.view.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        delegate.tabViewDelegate(indexPath.row)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cgWidth = view.frame.width / 2.5
        return CGSize(width: cgWidth, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

extension ViewController: PageViewControllerDelegate {
    func PageViewControllerDelegate(_ newIndex: Int) {
        collectionView.selectItem(at: IndexPath(row: newIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
}

