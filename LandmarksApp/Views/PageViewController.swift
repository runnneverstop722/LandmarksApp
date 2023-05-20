//
//  PageViewController.swift
//  LandmarksApp
//
//  Created by Teff on 2023/05/20.
//

import SwiftUI
import UIKit

// The page view controller stores an array of Page instances, which must be a type of View. These are the pages you use to scroll between landmarks.
struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    
    // Make the coordinator
    // SwiftUI calls this makeCoordinator() method before makeUIViewController(context:), so that you have access to the coordinator object when configuring your view controller.
    //Tip: You can use this coordinator to implement common Cocoa patterns, such as delegates, data sources, and responding to user events via target-action.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator // Add the coordinator as the data source of the UIPageViewController.
        
        return pageViewController
    }
    
    // Add an updateUIViewController(_:context:) method that calls setViewControllers(_:direction:animated:) to provide a view controller for display.
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [context.coordinator.controllers[0]], direction: .forward, animated: true) // Initialize an array of controllers in the coordinator using the pages array of views. The coordinator is a good place to store these controllers, because the system initializes them only once, and before you need them to update the view controller.
    }
    // Add UIPageViewControllerDataSource conformance to the Coordinator type, and implement the two required methods.
    class Coordinator: NSObject, UIPageViewControllerDataSource {
        var parent: PageViewController
        var controllers = [UIViewController]() // Initialize an array of controllers in the coordinator using the pages array of views. The coordinator is a good place to store these controllers, because the system initializes them only once, and before you need them to update the view controller.
        
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0) } // Initialize an array of controllers in the coordinator using the pages array of views. The coordinator is a good place to store these controllers, because the system initializes them only once, and before you need them to update the view controller.
        }
        
        // These two methods establish the relationships between view controllers, so that you can swipe back and forth between them.
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }
    }
}
