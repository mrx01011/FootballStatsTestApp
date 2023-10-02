//
//  ViewController.swift
//  FootballStatsTestApp
//
//  Created by MacBook on 28.09.2023.
//

import UIKit
import SnapKit

final class PreloadViewController: UIViewController {
    private var slides = [OnboardingViewController]()
    //MARK: UI elements
    let firstVC = OnboardingViewController(titleText: "All football events in one place",
                                           subtitleText: "Stay up to date with the latest results of your favorite matches.",
                                           backgroundImage: UIImage(named: GlobalConstants.Images.firstOnboardingBackground))
    let secondVC = OnboardingViewController(titleText: "Learn more about your favorite team",
                                            subtitleText: "Stay up to date with the latest results of your favorite matches.",
                                            backgroundImage: UIImage(named: GlobalConstants.Images.secondOnboardingBackground))
    let thirdVC = OnboardingViewController(titleText: "Search football\nevents by map",
                                           subtitleText: "Stay up to date with the latest\nresults of your favorite matches.",
                                           backgroundImage: UIImage(named: GlobalConstants.Images.thirdOnboardingBackground))
    private let backgroundImageView = UIImageView(image: UIImage(named: GlobalConstants.Images.preloaderBackground))
    private let loadingSpiralImageView = UIImageView(image: UIImage(named: GlobalConstants.Images.loading))
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animateLoadingSpiral()
        setupDelegates()
        setupPageController()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else { return }
            self.present(self.pageViewController, animated: true)
        }
    }
    //MARK: Methods
    private func setupUI() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundImageView.addSubview(loadingSpiralImageView)
        loadingSpiralImageView.snp.makeConstraints { make in
            make.width.height.equalTo(66)
            make.center.equalToSuperview()
        }
    }
    
    private func setupDelegates() {
        pageViewController.dataSource = self
        firstVC.delegate = self
        secondVC.delegate = self
        thirdVC.delegate = self
    }
    
    private func animateLoadingSpiral() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
        rotationAnimation.duration = 2.5
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = 2
        
        loadingSpiralImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    private func setupPageController() {
        slides = [firstVC, secondVC, thirdVC]
        pageViewController.modalPresentationStyle = .fullScreen
        pageViewController.setViewControllers([slides[0]], direction: .forward, animated: true)
    }
}
//MARK: UIPageViewControllerDataSource
extension PreloadViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = viewController as? OnboardingViewController,
              let currentIndex = slides.firstIndex(of: currentViewController), currentIndex > 0 else {
            return nil
        }
        return slides[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = viewController as? OnboardingViewController,
              let currentIndex = slides.firstIndex(of: currentViewController), currentIndex < slides.count - 1 else {
            return nil
        }
        return slides[currentIndex + 1]
    }
}
//MARK: OnboardingViewControllerDelegate
extension PreloadViewController: OnboardingViewControlerDelegate {
    func nextButtonTapped(on onboardingController: OnboardingViewController) {
        if let currentViewController = pageViewController.viewControllers?.first as? OnboardingViewController,
           let currentIndex = slides.firstIndex(of: currentViewController),
           currentIndex < slides.count - 1 {
            let nextIndex = currentIndex + 1
            let nextViewController = slides[nextIndex]
            pageViewController.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        } else {
            let vc = MainViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            pageViewController.show(vc, sender: self)
        }
    }
    
    func skipButtonTapped() {
        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        pageViewController.show(vc, sender: self)
    }
}
