//
//  UIScrollView+Infinity.swift
//  InfinitySample
//
//  Created by Danis on 15/12/21.
//  Copyright © 2015年 danis. All rights reserved.
//

import UIKit

private var associatedPullToRefresherKey:UInt8  = 1
private var associatedInfinityScrollerKey:UInt8 = 2

// MARK: - PullToRefresh
extension UIScrollView {

    public func addPullToRefresh(height: CGFloat = 60.0, animator: CustomPullToRefreshAnimator, action:(()->Void)?) {
        
        bindPullToRefresh(height, toAnimator: animator, action: action)
        
        if let animatorView = animator as? UIView {
            self.pullToRefresher?.containerView.addSubview(animatorView)
        }
        
    }
    public func bindPullToRefresh(height: CGFloat = 60.0, toAnimator: CustomPullToRefreshAnimator, action:(()->Void)?) {
        removePullToRefresh()
        
        self.pullToRefresher = PullToRefresher(height: height, animator: toAnimator)
        self.pullToRefresher?.scrollView = self
        self.pullToRefresher?.action = action
    }
    public func removePullToRefresh() {
        self.pullToRefresher?.scrollView = nil
        self.pullToRefresher = nil
    }
    public func beginRefreshing() {
        self.pullToRefresher?.beginRefreshing()
    }
    public func endRefreshing() {
        self.pullToRefresher?.endRefreshing()
    }
    
    //MARK: - Properties
    var pullToRefresher: PullToRefresher? {
        get {
            return objc_getAssociatedObject(self, &associatedPullToRefresherKey) as? PullToRefresher
        }
        set {
            objc_setAssociatedObject(self, &associatedPullToRefresherKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// MARK: - InfinityScroll
extension UIScrollView {
    
    public func addInfinityScroll(height: CGFloat = 60.0, animator: CustomInfinityScrollAnimator, action: (() -> Void)?) {
        
        bindInfinityScroll(height, toAnimator: animator, action: action)
        
        if let animatorView = animator as? UIView {
            self.infinityScroller?.containerView.addSubview(animatorView)
        }
    }
    public func bindInfinityScroll(height: CGFloat = 60.0, toAnimator: CustomInfinityScrollAnimator, action: (() -> Void)?) {
        removeInfinityScroll()
        
        self.infinityScroller = InfinityScroller(height: height, animator: toAnimator)
        self.infinityScroller?.scrollView = self
        self.infinityScroller?.action = action
    }
    public func removeInfinityScroll() {
        self.infinityScroller?.scrollView = nil
        self.infinityScroller = nil
    }
    public func beginInfinityScrolling() {
        self.infinityScroller?.beginInfinityScrolling()
    }
    public func endInfinityScrolling() {
        self.infinityScroller?.endInfinityScrolling()
    }
    
    //MARK: - Properties
    var infinityScroller: InfinityScroller? {
        get {
            return objc_getAssociatedObject(self, &associatedInfinityScrollerKey) as? InfinityScroller
        }
        set {
            objc_setAssociatedObject(self, &associatedInfinityScrollerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}