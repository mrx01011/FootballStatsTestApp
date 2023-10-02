//
//  OnboardingViewController.swift
//  FootballStatsTestApp
//
//  Created by MacBook on 28.09.2023.
//

import UIKit
import SnapKit

protocol OnboardingViewControlerDelegate: AnyObject {
    func nextButtonTapped(on onboardingController: OnboardingViewController)
    func skipButtonTapped()
}

final class OnboardingViewController: UIViewController {
    weak var delegate: OnboardingViewControlerDelegate?
    //MARK: UI elements
    private let backgroundImageView = UIImageView()
    private let mainInfoLabel: UILabel = {
        let label = UILabel()
        label.font = GlobalConstants.Fonts.bold34
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = GlobalConstants.Colors.onboardingGreen
        return label
    }()
    private let secondaryInfoLabel: UILabel = {
        let label = UILabel()
        label.font = GlobalConstants.Fonts.regular16
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = GlobalConstants.Colors.blackTransparent
        return label
    }()
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = GlobalConstants.Colors.black
        button.titleLabel?.font = GlobalConstants.Fonts.semibold17
        button.layer.cornerRadius = 20
        return button
    }()
    private let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = GlobalConstants.Fonts.semibold17
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = GlobalConstants.Colors.black.cgColor
        return button
    }()
    //MARK: Initialization
    init(titleText: String, subtitleText: String, backgroundImage: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        mainInfoLabel.text = titleText
        secondaryInfoLabel.text = subtitleText
        backgroundImageView.image = backgroundImage
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTargets()
    }
    //MARK: Methods
    private func setupUI() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundImageView.addSubview(mainInfoLabel)
        mainInfoLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        backgroundImageView.addSubview(secondaryInfoLabel)
        secondaryInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(mainInfoLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(secondaryInfoLabel.snp.bottom).offset(42)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.Offsets.buttonWidth)
            make.height.equalTo(Constants.Offsets.buttonHeight)
        }
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.Offsets.buttonWidth)
            make.height.equalTo(Constants.Offsets.buttonHeight)
            make.bottom.equalToSuperview().inset(44)
        }
    }
    
    private func addTargets() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }
    
    @objc private func nextButtonTapped() {
        self.delegate?.nextButtonTapped(on: self)
    }
    
    @objc private func skipButtonTapped() {
        self.delegate?.skipButtonTapped()
    }
}

extension OnboardingViewController {
    enum Constants {
        enum Offsets {
            static let buttonWidth: CGFloat = 257
            static let buttonHeight: CGFloat = 41
        }
    }
}
