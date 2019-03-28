//
//  ViewController.swift
//  UIPageViewControllerOnlyCode
//
//  Created by Артем on 3/28/19.
//  Copyright © 2019 Артем. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var dots: UIPageControl!
    var pageContainer: UIPageViewController!
    var myVCs = [UIViewController] ()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createVCs()
        
        pageContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        pageContainer.setViewControllers([myVCs[0]], direction: .forward, animated: true, completion: nil)
        
        pageContainer.delegate = self
        pageContainer.dataSource = self
        
        self.view.addSubview(pageContainer.view)
        
        self.view.bringSubviewToFront(dots)
        dots.numberOfPages = myVCs.count
        dots.currentPage = 0
    }
    
    @IBAction func actionDots(_ sender: UIPageControl) {
        if index < sender.currentPage {
            pageContainer.setViewControllers([myVCs[sender.currentPage]], direction: .forward, animated: true, completion: nil)
            
        } else {
            pageContainer.setViewControllers([myVCs[sender.currentPage]], direction: .reverse, animated: true, completion: nil)
        }
        
        index = sender.currentPage
    }
        
        
        func createVCs() {
            for i in 5...10 {
                let myVC = MyViewController()
                
                let btn = UIButton()
                btn.backgroundColor = .rnd()
                btn.frame = CGRect(x: 110, y: 250, width: 100, height: 50)
                btn.setTitle(String(i), for: .normal)
                btn.setTitle(String(i + 1), for: .highlighted)
                btn.setTitleColor(.rnd(), for: .normal)
                btn.setTitleColor(.rnd(), for: .highlighted)
                btn.layer.borderWidth = 5
                btn.layer.borderColor = UIColor.rnd().cgColor
                btn.layer.cornerRadius = 10
                
                myVC.view.backgroundColor = .rnd()
                myVC.view.addSubview(btn)
                
                myVCs.append(myVC)
            }
        }
    }
    
    extension UIColor {
        
        class func rnd() -> UIColor {
            
            return UIColor(displayP3Red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: .random(in: 0.1...1))
            
        }
    }
    
    
    extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
            guard let currentIndex = myVCs.firstIndex(of: viewController) else { return nil }
            
            let previusIndex = currentIndex - 1
            
            guard previusIndex >= 0 else { return nil }
            guard myVCs.count > previusIndex else { return nil }
            dots.currentPage = previusIndex
            return myVCs[previusIndex]
            
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            
            guard let currentIndex = myVCs.firstIndex(of: viewController) else { return nil }
            
            let nextIndex = currentIndex + 1
            
            guard nextIndex >= 0 else { return nil }
            guard myVCs.count > nextIndex else { return nil }
            dots.currentPage = nextIndex
            return myVCs[nextIndex]
        }
        
        
}
