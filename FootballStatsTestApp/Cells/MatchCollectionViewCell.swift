//
//  MatchesCollectionViewCell.swift
//  FootballStatsTestApp
//
//  Created by MacBook on 29.09.2023.
//

import UIKit
import SnapKit

final class MatchCollectionViewCell: UICollectionViewCell {
    //MARK: UI elements
    private let horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = -1
        return stack
    }()
    private let verticalFirstTeamStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 0
        return stack
    }()
    private let verticalStatsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 0
        return stack
    }()
    private let verticalSecondTeamStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 0
        return stack
    }()
    private let firstTeamImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ChelseaLogo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let secondTeamImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ChelseaLogo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let firstTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        return label
    }()
    private let secondTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        return label
    }()
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Heavy", size: 32)
        return label
    }()
    private let timeFromStartLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.211, green: 0.667, blue: 0.482, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Bold", size: 17)
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        return label
    }()
    private let ellipseImageView = UIImageView(image: UIImage(named: "Ellipse"))
    private let arrowImageView = UIImageView(image: UIImage(named: "arrow-right"))
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        defaultConfigurations()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    func setData(_ data: MatchData) {
        firstTeamImageView.image = UIImage(named: data.firstTeamImage)
        firstTeamLabel.text = data.firstTeamName
        secondTeamImageView.image = UIImage(named: data.secondTeamImage)
        secondTeamLabel.text = data.secondTeamName
        scoreLabel.attributedText = configureScoreLabelTextColor(labelText: data.score)
        timeLabel.text = data.time
        timeFromStartLabel.text = data.minuteMatch
    }
    
    private func configureScoreLabelTextColor(labelText: String) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: labelText)
        attributedText.addAttribute(.foregroundColor, value: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5), range: NSRange(location: 0, length: 1))
        
        return attributedText
    }
    
    private func setupUI() {
        //first team vertical stack
        verticalFirstTeamStackView.addArrangedSubview(firstTeamImageView)
        verticalFirstTeamStackView.addArrangedSubview(firstTeamLabel)
        //stats vertical stack
        verticalStatsStackView.addArrangedSubview(scoreLabel)
        verticalStatsStackView.addArrangedSubview(timeFromStartLabel)
        //second team vertical stack
        verticalSecondTeamStackView.addArrangedSubview(secondTeamImageView)
        verticalSecondTeamStackView.addArrangedSubview(secondTeamLabel)
        //horizontal stack
        horizontalStackView.addArrangedSubview(verticalFirstTeamStackView)
        horizontalStackView.addArrangedSubview(verticalStatsStackView)
        horizontalStackView.addArrangedSubview(verticalSecondTeamStackView)
        
        contentView.addSubview(horizontalStackView)
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalStackView.snp.bottom)
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().inset(12)
        }
        contentView.addSubview(ellipseImageView)
        ellipseImageView.snp.makeConstraints { make in
            make.top.equalTo(horizontalStackView.snp.bottom)
            make.trailing.bottom.equalToSuperview()
        }
        ellipseImageView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func defaultConfigurations() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1).cgColor
        self.backgroundColor = UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1)
        self.clipsToBounds = true
    }
}
