import UIKit

class RepositoryTableViewCell: UITableViewCell {
   
    var avatoreImageView = UIImageView()
    var repositoryTitleView = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(avatoreImageView)
        addSubview(repositoryTitleView)
        
        configureImageView()
        configureTitleLable()
        
        setImageConstraints()
        setTitleLableConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureImageView()  {
        avatoreImageView.layer.cornerRadius = 10
        avatoreImageView.clipsToBounds = true
    }
    
    func configureTitleLable()  {
        repositoryTitleView.numberOfLines = 0
        repositoryTitleView.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints() {
        avatoreImageView.translatesAutoresizingMaskIntoConstraints  = false
        avatoreImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        avatoreImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10 ).isActive = true
        avatoreImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        avatoreImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setTitleLableConstraints() {
        repositoryTitleView.translatesAutoresizingMaskIntoConstraints  = false
        repositoryTitleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        repositoryTitleView.leadingAnchor.constraint(equalTo: avatoreImageView.trailingAnchor, constant: 10 ).isActive = true
        repositoryTitleView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        repositoryTitleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-12).isActive = true
    }
}
