//
//  h2hCollectionViewCell.swift
//  FootballStatsTestApp
//
//  Created by MacBook on 01.10.2023.
//

import UIKit
import SnapKit

final class h2hCollectionViewCell: UICollectionViewCell {
    //MARK: UI elements
    private let firstTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = GlobalConstants.Fonts.regular14
        return label
    }()
    private let secondTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = GlobalConstants.Fonts.regular14
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = GlobalConstants.Colors.whiteTransparent05
        label.font = GlobalConstants.Fonts.medium14
        return label
    }()
    private let firstTeamImageView = UIImageView()
    private let secondTeamImageView = UIImageView()
    private let firstTeamScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = GlobalConstants.Fonts.medium14
        return label
    }()
    private let secondTeamScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = GlobalConstants.Fonts.medium14
        return label
    }()
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultConfigurations()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    func setData(_ data: H2HData) {
        dateLabel.text = data.date
        firstTeamImageView.image = UIImage(named: data.firstTeamImage)
        firstTeamLabel.text = data.firstTeam
        firstTeamScoreLabel.text = data.firstTeamScore
        secondTeamImageView.image = UIImage(named: data.secondTeamImage)
        secondTeamLabel.text = data.secondTeam
        secondTeamScoreLabel.text = data.secondTeamScore
    }
    
    private func defaultConfigurations() {
        backgroundColor = GlobalConstants.Colors.dark
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = GlobalConstants.Colors.border
    }
    
    private func setupUI() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(firstTeamImageView)
        contentView.addSubview(firstTeamLabel)
        contentView.addSubview(firstTeamScoreLabel)
        contentView.addSubview(secondTeamImageView)
        contentView.addSubview(secondTeamLabel)
        contentView.addSubview(secondTeamScoreLabel)
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
        firstTeamImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(dateLabel.snp.trailing).offset(12)
            make.width.height.equalTo(24)
        }
        secondTeamImageView.snp.makeConstraints { make in
            make.top.equalTo(firstTeamImageView.snp.bottom).offset(12)
            make.leading.equalTo(dateLabel.snp.trailing).offset(12)
            make.width.height.equalTo(24)
        }
        firstTeamLabel.snp.makeConstraints { make in
            make.centerY.equalTo(firstTeamImageView)
            make.leading.equalTo(firstTeamImageView.snp.trailing).offset(8)
        }
        secondTeamLabel.snp.makeConstraints { make in
            make.centerY.equalTo(secondTeamImageView)
            make.leading.equalTo(secondTeamImageView.snp.trailing).offset(8)
        }
        firstTeamScoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(firstTeamLabel)
            make.trailing.equalToSuperview().inset(12)
        }
        secondTeamScoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(secondTeamLabel)
            make.trailing.equalToSuperview().inset(12)
        }
    }
}
