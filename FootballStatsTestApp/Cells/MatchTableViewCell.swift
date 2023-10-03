//
//  MatchesCollectionViewCell.swift
//  FootballStatsTestApp
//
//  Created by MacBook on 29.09.2023.
//

import UIKit
import SnapKit

final class MatchTableViewCell: UITableViewCell {
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
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let secondTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let firstTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = GlobalConstants.Fonts.condensedMedium16
        return label
    }()
    private let secondTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = GlobalConstants.Fonts.condensedMedium16
        return label
    }()
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = GlobalConstants.Fonts.heavy32
        return label
    }()
    private let timeFromStartLabel: UILabel = {
        let label = UILabel()
        label.textColor = GlobalConstants.Colors.green
        label.font = GlobalConstants.Fonts.bold17
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = GlobalConstants.Colors.whiteTransparent05
        label.font = GlobalConstants.Fonts.regular12
        return label
    }()
    private let ellipseImageView = UIImageView(image: UIImage(named: GlobalConstants.Images.ellipse))
    private let arrowImageView = UIImageView(image: UIImage(named: GlobalConstants.Images.rightArrow))
    //MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        attributedText.addAttribute(.foregroundColor, value: GlobalConstants.Colors.whiteTransparent05, range: NSRange(location: 0, length: 1))
        
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
            make.top.equalTo(horizontalStackView.snp.bottom).offset(24)
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
        self.selectionStyle = .none
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 20
        self.layer.borderColor = GlobalConstants.Colors.border
        self.backgroundColor = GlobalConstants.Colors.dark
        self.clipsToBounds = true
    }
}
