//
//  DetailMatchViewController.swift
//  FootballStatsTestApp
//
//  Created by MacBook on 29.09.2023.
//

import UIKit
import SnapKit

final class DetailMatchViewController: UIViewController {
    private let mockEvents = [EventData(imageName: "yellowCard", event: "YELLOW CARD", minute: "89'", firstPlayer: "Ryan Botosh", secondPlayer: nil, team: 0),
                              EventData(imageName: "ball", event: "GOAL!!!", minute: "81'", firstPlayer: "Corey Westervelt", secondPlayer: nil, team: 1),
                              EventData(imageName: "redCard", event: "RED CARD", minute: "76'", firstPlayer: "Jaylon Carder", secondPlayer: nil, team: 0),
                              EventData(imageName: "switch", event: "REPLACE", minute: "72'", firstPlayer: "Jaylon Carder", secondPlayer: "Scott Herwitz", team: 0),
                              EventData(imageName: "yellowCard", event: "YELLOW CARD", minute: "68'", firstPlayer: "Scott Herwitz", secondPlayer: nil, team: 1),
                              EventData(imageName: "yellowCard", event: "YELLOW CARD", minute: "66'", firstPlayer: "Corey Westervelt", secondPlayer: nil, team: 0)]
    private let mockH2H = [H2HData(date: "23.09", firstTeamImage: "ChelseaLogo", firstTeam: "Harbor City FC", firstTeamScore: "3", secondTeamImage: "ChelseaLogo", secondTeam: "Harbor City FC", secondTeamScore: "4"),
                           H2HData(date: "23.09", firstTeamImage: "ChelseaLogo", firstTeam: "Harbor City FC", firstTeamScore: "3", secondTeamImage: "ChelseaLogo", secondTeam: "Harbor City FC", secondTeamScore: "4"),
                           H2HData(date: "23.09", firstTeamImage: "ChelseaLogo", firstTeam: "Harbor City FC", firstTeamScore: "3", secondTeamImage: "ChelseaLogo", secondTeam: "Harbor City FC", secondTeamScore: "4"),
                           H2HData(date: "23.09", firstTeamImage: "ChelseaLogo", firstTeam: "Harbor City FC", firstTeamScore: "3", secondTeamImage: "ChelseaLogo", secondTeam: "Harbor City FC", secondTeamScore: "4")]
    private var state: TypeActivity = .events {
        didSet {
            infoCollectionView.reloadData()
        }
    }
    //MARK: UI elements
    private let headerImageView = UIImageView(image: UIImage(named: "DetailVCHeader"))
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        return button
    }()
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "dots"), for: .normal)
        return button
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1)
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1).cgColor
        return view
    }()
    private let leagueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        return label
    }()
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
        label.text = "Royal Phoenix FC"
        label.textColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        return label
    }()
    private let secondTeamLabel: UILabel = {
        let label = UILabel()
        label.text = "Royal Phoenix FC"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
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
        label.text = "59'"
        label.textColor = UIColor(red: 0.211, green: 0.667, blue: 0.482, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Bold", size: 17)
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "18:00"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "29.09"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        return label
    }()
    private let eventsButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16)
        let button = UIButton()
        button.setTitle("Events", for: .normal)
        button.layer.cornerRadius = 16
        button.isHighlighted = false
        button.configuration = configuration
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 17)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.211, green: 0.667, blue: 0.482, alpha: 1)
        return button
    }()
    private let h2hButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16)
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 16
        button.configuration = configuration
        button.setTitle("H2H", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 17)
        button.setTitleColor(UIColor(red: 0.211, green: 0.667, blue: 0.482, alpha: 1), for: .normal)
        button.backgroundColor = UIColor(red: 0.211, green: 0.667, blue: 0.482, alpha: 0.1)
        return button
    }()
    private let infoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: "EventsCell")
        collectionView.register(h2hCollectionViewCell.self, forCellWithReuseIdentifier: "H2HCell")
        return collectionView
    }()
    lazy private var activityButtons = [eventsButton, h2hButton]
    //MARK: Initialization
    init(matchData: MatchData) {
        super.init(nibName: nil, bundle: nil)
        leagueLabel.attributedText = configureLeagueLabelTextColor(labelText: matchData.league)
        firstTeamImageView.image = UIImage(named: matchData.firstTeamImage)
        firstTeamLabel.text = matchData.firstTeamName
        secondTeamLabel.text = matchData.secondTeamName
        secondTeamImageView.image = UIImage(named: matchData.secondTeamImage)
        scoreLabel.attributedText = configureScoreLabelTextColor(labelText: matchData.score) 
        timeFromStartLabel.text = matchData.minuteMatch
        timeLabel.text = matchData.time
        dateLabel.text = matchData.date
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigurations()
        setupUI()
        addTargets()
        setupDelegates()
    }
    //MARK: Methods
    private func defaultConfigurations() {
        view.backgroundColor = UIColor(red: 0.141, green: 0.141, blue: 0.141, alpha: 1)
    }
    
    private func configureScoreLabelTextColor(labelText: String) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: labelText)
        attributedText.addAttribute(.foregroundColor, value: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5), range: NSRange(location: 0, length: 1))
 
        return attributedText
    }
    
    private func configureLeagueLabelTextColor(labelText: String) -> NSMutableAttributedString {
        let newLabelText = "League: " + labelText
        let attributedText = NSMutableAttributedString(string: newLabelText)
        attributedText.addAttribute(.foregroundColor, value: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5), range: NSRange(location: 0, length: 7))
        attributedText.addAttribute(.foregroundColor, value: UIColor(red: 0.216, green: 0.654, blue: 0.207, alpha: 1), range: NSRange(location: 6, length: newLabelText.count - 6))
        return attributedText
    }
    
    private func addTargets() {
        eventsButton.addTarget(self, action: #selector(activitySelected(_:)), for: .touchUpInside)
        h2hButton.addTarget(self, action: #selector(activitySelected(_:)), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setupDelegates() {
        infoCollectionView.delegate = self
        infoCollectionView.dataSource = self
    }
    
    private func setupUI() {
        view.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(38)
        }
        headerImageView.addSubview(moreButton)
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(backButton)
        }
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(90)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(164)
        }
        containerView.addSubview(leagueLabel)
        leagueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }
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
        
        containerView.addSubview(horizontalStackView)
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(leagueLabel)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        containerView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalStackView.snp.bottom)
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().inset(12)
        }
        containerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(timeLabel)
            make.trailing.equalToSuperview().inset(24)
        }
        view.addSubview(eventsButton)
        view.addSubview(h2hButton)
        eventsButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        h2hButton.snp.makeConstraints { make in
            make.leading.equalTo(eventsButton.snp.trailing).offset(10)
            make.centerY.equalTo(eventsButton)
        }
        view.addSubview(infoCollectionView)
        infoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(eventsButton.snp.bottom).offset(22)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    private func getSelectedActivity() -> TypeActivity {
        for (index, button) in activityButtons.enumerated() {
            if button.backgroundColor == UIColor(red: 0.211, green: 0.667, blue: 0.482, alpha: 1) {
                return TypeActivity(rawValue: index) ?? .events
            }
        }
        return .events
    }
    
    @objc private func activitySelected(_ sender: UIButton) {
        activityButtons.forEach({
            $0.titleLabel?.textColor = UIColor(red: 0.211, green: 0.667, blue: 0.482, alpha: 1)
            $0.backgroundColor = UIColor(red: 0.211, green: 0.667, blue: 0.482, alpha: 0.1)
        })
        
        sender.backgroundColor = UIColor(red: 0.211, green: 0.667, blue: 0.482, alpha: 1)
        sender.setTitleColor(.white, for: .normal)
        
        state = getSelectedActivity()
    }
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true)
    }
}

extension DetailMatchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch state {
        case .events:
            return mockEvents.count
        case .h2h:
            return mockH2H.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch state {
        case .events:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsCell", for: indexPath) as? EventCollectionViewCell else { return UICollectionViewCell() }
            cell.setData(eventImageName: mockEvents[indexPath.row].imageName,
                         event: mockEvents[indexPath.row].event,
                         eventMinute: mockEvents[indexPath.row].minute,
                         firstPlayer: mockEvents[indexPath.row].firstPlayer,
                         secondPlayer: mockEvents[indexPath.row].secondPlayer,
                         team: mockEvents[indexPath.row].team)
            return cell
        case .h2h:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "H2HCell", for: indexPath) as? h2hCollectionViewCell else { return UICollectionViewCell() }
            cell.setData(date: mockH2H[indexPath.row].date,
                         firstTeamImage: mockH2H[indexPath.row].firstTeamImage,
                         firstTeam: mockH2H[indexPath.row].firstTeam,
                         firstTeamScore: mockH2H[indexPath.row].firstTeamScore,
                         secondTeamImage: mockH2H[indexPath.row].secondTeamImage,
                         secondTeam: mockH2H[indexPath.row].secondTeam,
                         secondTeamScore: mockH2H[indexPath.row].secondTeamScore)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch state {
        case .events:
            let eventData = mockEvents[indexPath.row]
            
            let cell = EventCollectionViewCell(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 0))
            cell.setData(eventImageName: eventData.imageName,
                         event: eventData.event,
                         eventMinute: eventData.minute,
                         firstPlayer: eventData.firstPlayer,
                         secondPlayer: eventData.secondPlayer,
                         team: eventData.team)
            
            let size = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            return CGSize(width: collectionView.bounds.width, height: size.height)
        case .h2h:
            return CGSize(width: collectionView.bounds.width, height: 76)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension DetailMatchViewController {
    enum TypeActivity: Int {
        case events
        case h2h
    }
}
