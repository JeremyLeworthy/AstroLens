//
//  ExploreCell.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-03-06.
//

import UIKit
import SDWebImage

class ExploreCell: UITableViewCell {
	
	private let container: UIView = {
		let view = UIView()
		view.backgroundColor = .systemGray6
		view.layer.cornerRadius = 12
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private let vStack: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 16
		stackView.backgroundColor = .systemGray6
		stackView.layer.cornerRadius = 12
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	private let row1: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 16
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		return stackView
	}()
	
	private lazy var row2: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		stackView.isHidden = true
		return stackView
	}()
	
	private lazy var col2: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 16
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	private let photoOfTheDay: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 12
		imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.isUserInteractionEnabled = false
		return imageView
	}()
	
	private let title: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 18)
		label.textAlignment = .left
		label.translatesAutoresizingMaskIntoConstraints = false
		label.isUserInteractionEnabled = false
		label.adjustsFontSizeToFitWidth = true
		return label
	}()
	
	private let like: UIButton = {
		let button = UIButton()
		button.imageView?.contentMode = .scaleAspectFit
		button.imageView?.tintColor = .label
		button.translatesAutoresizingMaskIntoConstraints = false
		let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular, scale: .large)
		button.setImage(UIImage(systemName: "heart", withConfiguration: largeConfig), for: .normal)
		button.setImage(UIImage(systemName: "heart.fill", withConfiguration: largeConfig), for: .selected)
		return button
	}()
	
	private lazy var date: UILabel = {
		let label = UILabel()
		label.font = .italicSystemFont(ofSize: 14)
		label.textAlignment = .left
		label.translatesAutoresizingMaskIntoConstraints = false
		label.isUserInteractionEnabled = false
		return label
	}()
	
	private lazy var explanation: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14)
		label.textAlignment = .left
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		label.isUserInteractionEnabled = false
		return label
	}()
	
	static let identifier = "ExploreCell"
	
	var viewModel: ExploreCellViewModel? {
		didSet {
			photoOfTheDay.sd_setImage(with: viewModel?.url)
			title.text = viewModel?.title
			date.text = viewModel?.date
			explanation.text = viewModel?.explanation
		}
	}
	
	var expanded: Bool = false {
		didSet {
			let options: AnimationOptions = expanded ? [.transitionCurlDown] : [.transitionCurlUp]
			UIView.animate(withDuration: 0.3, delay: 0, options: options) { [self] in
				row2.isHidden = !expanded
			}
		}
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		
		backgroundColor = .systemBackground
		contentView.backgroundColor = .systemBackground
		contentView.addSubview(container)
		container.addSubview(vStack)
		
		row1.addArrangedSubview(title)
		row1.addArrangedSubview(like)
		
		row2.addArrangedSubview(col2)
		
		col2.addArrangedSubview(date)
		col2.addArrangedSubview(explanation)
		
		vStack.addArrangedSubview(photoOfTheDay)
		vStack.addArrangedSubview(row1)
		vStack.addArrangedSubview(row2)
		
		NSLayoutConstraint.activate([
			container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
			container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
			container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			
			vStack.topAnchor.constraint(equalTo: container.topAnchor),
			vStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
			vStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
			vStack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
			
			photoOfTheDay.height(constant: 200, priority: UILayoutPriority(999)),
			row1.height(constant: 40),
			like.width(constant: 40),
			date.height(constant: 40)
		])
		
		
		like.addTarget(self, action: #selector(likeAPOD), for: .touchUpInside)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func likeAPOD() {
		like.isSelected.toggle()
	}
}
