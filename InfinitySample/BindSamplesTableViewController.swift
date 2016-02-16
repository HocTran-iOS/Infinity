//
//  BindSamplesTableViewController.swift
//  InfinitySample
//
//  Created by Danis on 15/12/24.
//  Copyright © 2015年 danis. All rights reserved.
//

import UIKit
import Infinity

class BindSamplesTableViewController: UITableViewController {
    
    var type: BindAnimatorType = .Default
    var items = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        title = type.description
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SampleCell")
        tableView.supportSpringBounces = true
        
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.setInsetType(withTop: .NavigationBar , bottom: .TabBar)
        
        bindPullToRefresh(type)
        addInfinityScroll(type)
        
        tableView.infinityStickToContent = true // Default
    }
    
    deinit {
        tableView.removePullToRefresh()
        tableView.removeInfinityScroll()
    }
    
    // MARK: - Add PullToRefresh
    func bindPullToRefresh(type: BindAnimatorType) {
        switch type {
        case .Default:
            let animator = DefaultRefreshAnimator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: animator)
            bindPullToRefreshWithAnimator(animator)
        case .GIF:
            let animator = GIFRefreshAnimator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            // Add Images for Animator
            var refreshImages = [UIImage]()
            for var index = 0; index <= 21; index++ {
                let image = UIImage(named: "hud_\(index)")
                if let image = image {
                    refreshImages.append(image)
                }
            }
            var animatedImages = [UIImage]()
            for var index = 21; index <= 29; index++ {
                let image = UIImage(named: "hud_\(index)")
                if let image = image {
                    animatedImages.append(image)
                }
            }
            for var index = 0; index < 21; index++ {
                let image = UIImage(named: "hud_\(index)")
                if let image = image {
                    animatedImages.append(image)
                }
            }
            animator.refreshImages = refreshImages
            animator.animatedImages = animatedImages
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: animator)
            bindPullToRefreshWithAnimator(animator)
        case .Circle:
            let animator = CircleRefreshAnimator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: animator)
            bindPullToRefreshWithAnimator(animator)
        case .Arrow:
            let animator = ArrowRefreshAnimator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: animator)
            bindPullToRefreshWithAnimator(animator)
        default:
            break
        }
    }
    func bindPullToRefreshWithAnimator(animator: CustomPullToRefreshAnimator) {
        tableView.bindPullToRefresh(toAnimator: animator, action: { [weak self] () -> Void in
            let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(1.5 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self?.tableView?.endRefreshing()
            }
        })
    }
    // MARK: - Add InfinityScroll
    func addInfinityScroll(type: BindAnimatorType) {
        switch type {
        case .Default:
            let animator = DefaultInfinityAnimator(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            addInfinityScrollWithAnimator(animator)
        case .GIF:
            let animator = GIFInfinityAnimator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            var animatedImages = [UIImage]()
            for var index = 0; index <= 29; index++ {
                let image = UIImage(named: "hud_\(index)")
                if let image = image {
                    animatedImages.append(image)
                }
            }
            animator.animatedImages = animatedImages
            addInfinityScrollWithAnimator(animator)
        case .Circle:
            let animator = CircleInfinityAnimator(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            addInfinityScrollWithAnimator(animator)

        default:
            break
        }
    }
    func addInfinityScrollWithAnimator(animator: CustomInfinityScrollAnimator) {
        tableView.addInfinityScroll(animator: animator, action: { [weak self] () -> Void in
            let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(1.5 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self?.items += 15
                self?.tableView.reloadData()
                self?.tableView?.endInfinityScrolling()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SampleCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "Cell"
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let newVC = UIViewController()
        newVC.view.backgroundColor = UIColor.redColor()
        
        self.showViewController(newVC, sender: self)
    }

}
