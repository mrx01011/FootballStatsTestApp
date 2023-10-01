//
//  EventCollectionViewCell.swift
//  FootballStatsTestApp
//
//  Created by MacBook on 30.09.2023.
//

import UIKit
import SnapKit

final class EventCollectionViewCell: UICollectionViewCell {
    private var imageLeadingConstraint: Constraint?
    private var imageTrailingConstraint: Constraint?
    private var eventLeadingConstraint: Constraint?
    private var eventTrailingConstraint: Constraint?
    private var minuteLeadingConstraint: Constraint?
    private var minuteTrailingConstraint: Constraint?
    //MARK: UIElements
    private let eventImageView = UIImageView(image: UIImage(named: "ball"))
    private let eventTextLabel: UILabel = {
        let label = UILabel()
        label.text = "GOAL!!!"
        label.textColor = UIColor(red: 0.211, green: 0.667, blue: 0.482, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
        return label
    }()
    private let eventMinuteLabel: UILabel = {
        let label = UILabel()
        label.text = "89'"
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
        return label
    }()
    private let outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = -1
        return stackView
    }()
    private let firstPlayerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    private let secondPlayerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    private let firstPlayerLabel: UILabel = {
        let label = UILabel()
        label.text = "Vladyslav Nhuien"
        label.textColor = .white
        label.font = UIFont(name: "SFProText-Regular", size: 14)
        return label
    }()
    private let secondPlayerLabel: UILabel = {
        let label = UILabel()
        label.text = "Vladyslav Nhuien"
        label.textColor = .white
        label.font = UIFont(name: "SFProText-Regular", size: 14)
        return label
    }()
    private let replaceInLabel: UILabel = {
        let label = UILabel()
        label.text = "IN"
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.211, green: 0.667, blue: 0.482, alpha: 1)
        label.font = UIFont(name: "SFProText-Regular", size: 14)
        return label
    }()
    private let replaceOutLabel: UILabel = {
        let label = UILabel()
        label.text = "OUT"
        label.textColor = UIColor(red: 0.93, green: 0.21, blue: 0.21, alpha: 1)
        label.font = UIFont(name: "SFProText-Regular", size: 14)
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
    func setData(eventImageName: String, event: String, eventMinute: String, firstPlayer: String, secondPlayer: String?, team: Int) {
        eventImageView.image = UIImage(named: eventImageName)
        eventTextLabel.text = event
        eventMinuteLabel.text = eventMinute
        firstPlayerLabel.text = firstPlayer
        updateConstraints(with: Team(rawValue: team) ?? .first)
        if let secondPlayer = secondPlayer {
            secondPlayerLabel.text = secondPlayer
        } else {
            secondPlayerStackView.removeArrangedSubview(replaceInLabel)
            secondPlayerStackView.removeArrangedSubview(replaceOutLabel)
            firstPlayerStackView.removeArrangedSubview(secondPlayerLabel)
 
            replaceInLabel.removeFromSuperview()
            replaceOutLabel.removeFromSuperview()
            secondPlayerLabel.removeFromSuperview()
        }
        outerStackView.setNeedsUpdateConstraints()
        outerStackView.layoutIfNeeded()
    }
    
    private func setupUI() {
        contentView.addSubview(eventImageView)
        eventImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            imageLeadingConstraint = make.leading.equalToSuperview().offset(12).priority(.high).constraint
            imageTrailingConstraint = make.trailing.equalToSuperview().inset(12).priority(.low).constraint
            make.width.height.equalTo(20)
        }
        contentView.addSubview(eventTextLabel)
        eventTextLabel.snp.makeConstraints { make in
            make.centerY.equalTo(eventImageView)
            eventLeadingConstraint = make.leading.equalTo(eventImageView.snp.trailing).offset(8).priority(.high).constraint
            eventTrailingConstraint = make.trailing.equalTo(eventImageView.snp.leading).inset(-8).priority(.low).constraint
        }
        contentView.addSubview(eventMinuteLabel)
        eventMinuteLabel.snp.makeConstraints { make in
            make.centerY.equalTo(eventTextLabel)
            minuteTrailingConstraint = make.trailing.equalToSuperview().inset(12).priority(.high).constraint
            minuteLeadingConstraint = make.leading.equalToSuperview().offset(12).priority(.low).constraint
        }
        firstPlayerStackView.addArrangedSubview(replaceInLabel)
        firstPlayerStackView.addArrangedSubview(firstPlayerLabel)
        secondPlayerStackView.addArrangedSubview(replaceOutLabel)
        secondPlayerStackView.addArrangedSubview(secondPlayerLabel)
        outerStackView.addArrangedSubview(firstPlayerStackView)
        outerStackView.addArrangedSubview(secondPlayerStackView)
        contentView.addSubview(outerStackView)
        outerStackView.snp.makeConstraints { make in
            make.top.equalTo(eventImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func updateConstraints(with team: Team) {
        switch team {
        case .first:
            outerStackView.alignment = .leading
            eventTrailingConstraint?.update(priority: .low)
            imageTrailingConstraint?.update(priority: .low)
            minuteLeadingConstraint?.update(priority: .low)
            eventLeadingConstraint?.update(priority: .high)
            imageLeadingConstraint?.update(priority: .high)
            minuteTrailingConstraint?.update(priority: .high)
        case .second:
            outerStackView.alignment = .trailing
            eventLeadingConstraint?.update(priority: .low)
            imageLeadingConstraint?.update(priority: .low)
            minuteTrailingConstraint?.update(priority: .low)
            eventTrailingConstraint?.update(priority: .high)
            imageTrailingConstraint?.update(priority: .high)
            minuteLeadingConstraint?.update(priority: .high)
        }
    }
    
    private func defaultConfigurations() {
        backgroundColor = UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1)
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1).cgColor
    }
}
//MARK: - State
extension EventCollectionViewCell {
    enum Team: Int {
        case first
        case second
    }
}
