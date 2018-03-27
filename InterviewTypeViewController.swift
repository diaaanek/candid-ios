//
//  InterviewTypeViewController.swift
//  Candid
//
//  Created by Diane Korongy on 3/24/18.
//  Copyright © 2018 Developers Academy. All rights reserved.
//

import UIKit
import expanding_collection

class InterviewTypeViewController: ExpandingViewController {

    
    typealias ItemInfo = (imageName: String, title: String)
    fileprivate var cellsIsOpen = [Bool]()
    fileprivate let items: [ItemInfo] = [
        ("pic2", "Telephone Interview"),
        ("pic5", "Face to Face Interview"),
        ("pic5", "Behavioral Interview"),
        ("pic5", "Technical Interview"),
        ("pic5", "Face to Face Interview"),
        
        ]
    
    @IBOutlet var pageLabel: UILabel!
}

// MARK: - Lifecycle 🌎

extension InterviewTypeViewController {
    
    override func viewDidLoad() {
        itemSize = CGSize(width: 256, height: 460)
        super.viewDidLoad()
        
        registerCell()
        fillCellIsOpenArray()
        addGesture(to: collectionView!)
        configureNavBar()
    }
}

// MARK: Helpers

extension InterviewTypeViewController {
    
    fileprivate func registerCell() {
        
        let nib = UINib(nibName: String(describing: InterviewTypeCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: InterviewTypeCollectionViewCell.self))
    }
    
    fileprivate func fillCellIsOpenArray() {
        cellsIsOpen = Array(repeating: false, count: items.count)
    }
    
    fileprivate func getViewController() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let toViewController: InterviewTypeTableViewController = storyboard.instantiateViewController(withIdentifier: "InterviewTypeTableViewController") as! InterviewTypeTableViewController
        return toViewController
    }
    
    fileprivate func configureNavBar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
}

/// MARK: Gesture
extension InterviewTypeViewController {
    
    fileprivate func addGesture(to view: UIView) {
        let upGesture = UISwipeGestureRecognizer(target: self, action: #selector(InterviewTypeViewController.swipeHandler(_:)))
        upGesture.direction = .up
        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(InterviewTypeViewController.swipeHandler(_:)))
        downGesture.direction = .down
        view.addGestureRecognizer(upGesture)
        view.addGestureRecognizer(downGesture)
    }
    
    @objc func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        guard let cell = collectionView?.cellForItem(at: indexPath) as? InterviewTypeCollectionViewCell else { return }
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            pushToViewController(getViewController())
            cell.cellIsOpen(false)
//            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
//                rightButton.animationSelected(true)
//            }
        } else {
            let open = sender.direction == .up ? true : false
            cell.cellIsOpen(open)
            cellsIsOpen[indexPath.row] = cell.isOpened
        }
    }
}

// MARK: UIScrollViewDelegate

extension InterviewTypeViewController {
    
    func scrollViewDidScroll(_: UIScrollView) {
        pageLabel.text = "\(currentIndex + 1)/\(items.count)"
    }
}

// MARK: UICollectionViewDataSource

extension InterviewTypeViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        guard let cell = cell as? InterviewTypeCollectionViewCell else { return }
        
        let index = indexPath.row % items.count
        let info = items[index]
//        cell.backgroundView?.image = UIImage(named: pic5)
       cell.customTitle.text = info.title
        cell.cellIsOpen(cellsIsOpen[index], animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? InterviewTypeCollectionViewCell
            , currentIndex == indexPath.row else { return }
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
        } else {
            pushToViewController(getViewController())
            cell.cellIsOpen(false)
            
//            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
//                rightButton.animationSelected(true)
//            }
        }
    }
    

}



// MARK: UICollectionViewDataSource

extension InterviewTypeViewController {
    
    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: InterviewTypeCollectionViewCell.self), for: indexPath)
    }
}




