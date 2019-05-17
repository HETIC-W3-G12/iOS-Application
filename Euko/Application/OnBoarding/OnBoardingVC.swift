//
//  OnBoardingVC.swift
//  Euko
//
//  Created by Victor Lucas on 23/04/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class OnBoardingVC: UIPageViewController, UIPageViewControllerDataSource {

    var vcArray:[UIViewController?] = []
    var actualVC:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.view.backgroundColor = UIColor(red: 59/255, green: 84/255, blue: 213/255, alpha: 1)
        
        self.setVcArray()
        self.setViewControllers([self.vcArray[0]!], direction: .forward, animated: true, completion: nil)
        self.actualVC = 0
    }
    
    func setVcArray(){
        self.vcArray.append(self.getStepOne())
        self.vcArray.append(self.getStepTwo())
        self.vcArray.append(self.getStepThree())
    }
    
    func getStepOne() -> UIViewController {
        return (self.storyboard?.instantiateViewController(withIdentifier: "FirstBoardingVC"))!
    }
   
    func getStepTwo() -> UIViewController {
        return (self.storyboard?.instantiateViewController(withIdentifier: "SecondBoardingVC"))!
    }
    
    func getStepThree() -> UIViewController {
        return (self.storyboard?.instantiateViewController(withIdentifier: "ThirdBoardingVC"))!
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.vcArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if (self.actualVC - 1 < 0){
            return nil
        } else {
            self.actualVC = self.actualVC - 1
            return self.vcArray[self.actualVC]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if (self.actualVC + 1 > self.vcArray.count - 1){
            return nil
        } else {
            self.actualVC = self.actualVC + 1
            return self.vcArray[self.actualVC]
        }
    }
}
