//
//  ViewController.swift
//  ScrollViewProject
//
//  Created by Gamid Gapizov on 19.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let lowerView = UIView()
    private let imageView = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        addScrollView()
        createView()
        createImageView()
        createConstraintsPriority()
    }
    
    
    func addScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = .init(width: view.frame.width, height: view.frame.height + 250)
        scrollView.backgroundColor = .white
        scrollView.delegate = self
        scrollView.scrollIndicatorInsets = .init(top: -1, left: 0, bottom: 0, right: 0)
        scrollView.contentInsetAdjustmentBehavior = .never
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
    }
    
    func createView() {
        scrollView.addSubview(lowerView)
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        lowerView.backgroundColor = .white
        
        let viewConstraints = [
            lowerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            lowerView.heightAnchor.constraint(equalToConstant: 250),
            lowerView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(viewConstraints)
    }
    
    
    func createImageView() {
        lowerView.addSubview(imageView)
        imageView.image = UIImage(named: "before")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        let imageConstraints = [
            imageView.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(imageConstraints)
    }

    
    func createConstraintsPriority() {
        let ivTopAnchor = imageView.topAnchor.constraint(equalTo: view.topAnchor)
        ivTopAnchor.priority = .defaultHigh
        ivTopAnchor.isActive = true
        
        let ivHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 250)
        ivHeightConstraint.priority = .defaultLow
        ivHeightConstraint.isActive = true
    }
}


extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let scroll = scrollView.contentOffset.y
        
        scrollView.scrollIndicatorInsets = .init(top: imageView.frame.height - view.layoutMargins.top, left: 0, bottom: 0, right: 0)
        
        if scroll < -150 {
            imageView.image = UIImage(named: "after")
            imageView.contentMode = .scaleAspectFill
        } else if scroll > -150 {
            imageView.image = UIImage(named: "before")
            imageView.contentMode = .scaleAspectFit
        }
    }
}
