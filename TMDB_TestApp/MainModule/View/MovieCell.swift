import UIKit

class MovieCell: UITableViewCell {
    
    let activity =  UIActivityIndicatorView(style: .large)
    
    let cellView = UIView()
    
    let posterView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textAlignment = .left
        return label
    }()
    
    let popularityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        cellView.backgroundColor = .systemGray5
        contentView.addSubview(cellView)
        cellView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 15, left: 5, bottom: 15, right: 5))
        
        cellView.addSubview(posterView)
        cellView.addSubview(activity)
        cellView.addSubview(titleLabel)
        cellView.addSubview(popularityLabel)
        cellView.addSubview(ratingLabel)
        cellView.addSubview(overviewLabel)
        
        let smallStack = UIStackView(arrangedSubviews: [popularityLabel, ratingLabel])
        cellView.addSubview(smallStack)
        smallStack.axis = .horizontal
        smallStack.distribution = .fillEqually

        let vStack = UIStackView(arrangedSubviews: [titleLabel, overviewLabel, smallStack])
        cellView.addSubview(vStack)
        vStack.axis = .vertical
        vStack.distribution = .equalSpacing

        let stack = UIStackView(arrangedSubviews: [posterView, activity, vStack])
        stack.axis = .horizontal
        cellView.addSubview(stack)

        stack.anchor(top: cellView.topAnchor, leading: cellView.leadingAnchor, bottom: cellView.bottomAnchor, trailing: cellView.trailingAnchor)
        posterView.anchor(top: stack.topAnchor, leading: stack.leadingAnchor, bottom: stack.bottomAnchor, trailing: nil, size: .init(width: 110, height: 165))
        vStack.anchor(top: stack.topAnchor, leading: nil, bottom: stack.bottomAnchor, trailing: stack.trailingAnchor)
        stack.spacing = 5
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.center = posterView.center
        activity.hidesWhenStopped = true
        activity.startAnimating()

        
 
        cellView.layer.cornerRadius = 10
        cellView.layer.masksToBounds = false
        cellView.clipsToBounds = true
    
//        cellView.layer.shadowColor = UIColor.black.cgColor
//        cellView.layer.shadowRadius = 5
//        cellView.layer.shadowOpacity = 1
//        cellView.layer.shadowOffset = CGSize.zero
        

        
//        let shadowView = UIView()
//        contentView.addSubview(shadowView)
//        shadowView.anchor(top: cellView.topAnchor, leading: cellView.leadingAnchor, bottom: cellView.bottomAnchor, trailing: cellView.trailingAnchor)
//        shadowView.bounds = cellView.bounds
//        shadowView.layer.masksToBounds = false
//        shadowView.clipsToBounds = true
//        shadowView.layer.shadowPath = UIBezierPath(rect: stack.frame).cgPath
//        shadowView.layer.shadowColor = UIColor.black.cgColor
//        shadowView.layer.shadowRadius = 5
//        shadowView.layer.shadowOpacity = 1
//        shadowView.layer.shadowOffset = CGSize.zero
//        shadowView.layer.shouldRasterize = true
//        shadowView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
