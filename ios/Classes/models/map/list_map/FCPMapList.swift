import UIKit

class FCPMapListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Define your table view
    let tableView = UITableView(frame: .zero,style: .plain)
    
    let heightCell = 80.0
    
    // Định nghĩa nguồn dữ liệu cho table view
    var data: [FCPMapListModel]
    
    // Khởi tạo tùy chỉnh nhận dữ liệu
    init(data: [FCPMapListModel]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    // Khởi tạo bắt buộc từ `UIViewController`
    required init?(coder: NSCoder) {
        self.data = []
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register the custom cell
        tableView.register(FCPMapListCell.self, forCellReuseIdentifier: "FCPMapListCell")
        // Setup table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 42, width: 300, height: view.frame.height - 42) // Adjust height as needed
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 0.0
        tableView.sectionFooterHeight = 0.0
        tableView.backgroundView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
            UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
        }
        view.addSubview(tableView)
    }
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FCPMapListCell", for: indexPath) as? FCPMapListCell else {
            return UITableViewCell()
        }
        let model = data[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
        cell.layer.borderWidth = .zero
        cell.layer.cornerRadius = .zero
        cell.layer.masksToBounds = true
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 30, left: 0, bottom: 25, right: 0))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
}


class FCPMapListCell: UITableViewCell {
    let outerView = UIView()
    let firstSubview = UIView()
    let circleView = UIView()
    let secondSubview = UIView()
    let topLabel = UILabel()
    let bottomLabel = UILabel()
    let thirdSubview = UIView()
    let totalPick = UILabel()
    let totalDrop = UILabel()
    let confirmUserPickDrop = UILabel()
    let viewIconPick = UIImageView()
    let viewIconDrop = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layoutMargins = UIEdgeInsets.zero
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layoutMargins = UIEdgeInsets.zero
        setupViews()
    }

    func configure(with model: FCPMapListModel) {
        // circle view
        circleView.backgroundColor = model.getIsCheck() == true ? UIColor.systemGreen : UIColor.gray
        
        // time label
        topLabel.text = model.getTime() ?? "-"
        
        // address label
        bottomLabel.text = model.getAddress() ?? "-"
        
        // total pick
        totalPick.text = model.getUserPick() ?? "-"
        
        // total drop
        totalDrop.text = model.getUserDrop() ?? "-"
        
        // confrim user
        confirmUserPickDrop.text = model.getConfirmUser() ?? "-"
        confirmUserPickDrop.textColor = model.getIsConfirmUser() == true ? UIColor.systemGreen : UIColor.systemRed
        
        // Show/hide view
        if model.getIsShowUserPick() == false {
            totalPick.isHidden = true
            viewIconPick.isHidden = true
        }
        
        if model.getIsShowUserDrop() == false {
            totalDrop.isHidden = true
            viewIconDrop.isHidden = true
        }
        
        if model.getIsShowLabelUserConfirm() == false {
            confirmUserPickDrop.isHidden = true
        }
    }
    
    func setupViews() {
        // View parent
        outerView.backgroundColor = UIColor.white
        outerView.translatesAutoresizingMaskIntoConstraints = false

        // ================== View first ==================
        // View timeline
        firstSubview.backgroundColor = UIColor.blue
        firstSubview.translatesAutoresizingMaskIntoConstraints = false

        // View circle
        circleView.layer.cornerRadius = 5
        circleView.translatesAutoresizingMaskIntoConstraints = false
        firstSubview.addSubview(circleView)

        // ================== View second ==================
        // View title information
        secondSubview.backgroundColor = UIColor.white
        secondSubview.translatesAutoresizingMaskIntoConstraints = false

        // Label time
        topLabel.textColor = UIColor.systemGreen
        topLabel.font = UIFont.systemFont(ofSize: 16)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        secondSubview.addSubview(topLabel)

        // Label address
        bottomLabel.textColor = UIColor.black
        bottomLabel.font = UIFont.systemFont(ofSize: 15)
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.numberOfLines = 2
        secondSubview.addSubview(bottomLabel)

        // ================== View Pick-Drop ==================
        // View total User pick-drop

        thirdSubview.backgroundColor = UIColor.white
        thirdSubview.translatesAutoresizingMaskIntoConstraints = false

        let iconPick = UIImage(named: "ic_pick_svg")
        viewIconPick.image = iconPick
        viewIconPick.translatesAutoresizingMaskIntoConstraints = false
        thirdSubview.addSubview(viewIconPick)

        totalPick.textColor = UIColor.black
        totalPick.font = UIFont.systemFont(ofSize: 13)
        totalPick.translatesAutoresizingMaskIntoConstraints = false
        thirdSubview.addSubview(totalPick)
        
        let iconDrop = UIImage(named: "ic_drop_svg")
        viewIconDrop.image = iconDrop
        viewIconDrop.translatesAutoresizingMaskIntoConstraints = false
        thirdSubview.addSubview(viewIconDrop)

        
        totalDrop.textColor = UIColor.black
        totalDrop.font = UIFont.systemFont(ofSize: 13)
        totalDrop.translatesAutoresizingMaskIntoConstraints = false
        thirdSubview.addSubview(totalDrop)

        confirmUserPickDrop.font = UIFont.systemFont(ofSize: 13)
        confirmUserPickDrop.translatesAutoresizingMaskIntoConstraints = false
        thirdSubview.addSubview(confirmUserPickDrop)

        // Add subviews to outerView
        outerView.addSubview(firstSubview)
        outerView.addSubview(secondSubview)
        outerView.addSubview(thirdSubview)

        // Add outerView to cell's contentView
        self.contentView.addSubview(outerView)

        // Add constraints
        NSLayoutConstraint.activate([
            // Outer view constraints
            outerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            outerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            outerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            outerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

            // First subview constraints
            firstSubview.leadingAnchor.constraint(equalTo: outerView.leadingAnchor),
            firstSubview.topAnchor.constraint(equalTo: outerView.topAnchor),
            firstSubview.bottomAnchor.constraint(equalTo: outerView.bottomAnchor),
            firstSubview.widthAnchor.constraint(equalToConstant: 12),

            // Circle view constraints
            circleView.centerXAnchor.constraint(equalTo: firstSubview.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: firstSubview.centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 10),
            circleView.heightAnchor.constraint(equalToConstant: 10),

            // Second subview constraints
            secondSubview.leadingAnchor.constraint(equalTo: firstSubview.trailingAnchor, constant: 8),
            secondSubview.topAnchor.constraint(equalTo: outerView.topAnchor),
            secondSubview.bottomAnchor.constraint(equalTo: outerView.bottomAnchor),

            // Top label constraints
            topLabel.leadingAnchor.constraint(equalTo: secondSubview.leadingAnchor, constant: 5),
            topLabel.topAnchor.constraint(equalTo: secondSubview.topAnchor, constant: 10),
            topLabel.trailingAnchor.constraint(equalTo: secondSubview.trailingAnchor),

            // Bottom label constraints
            bottomLabel.leadingAnchor.constraint(equalTo: secondSubview.leadingAnchor, constant: 5),
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 10),
            bottomLabel.trailingAnchor.constraint(equalTo: secondSubview.trailingAnchor),

            // Third subview constraints
            thirdSubview.trailingAnchor.constraint(equalTo: outerView.trailingAnchor),
            thirdSubview.topAnchor.constraint(equalTo: outerView.topAnchor),
            thirdSubview.bottomAnchor.constraint(equalTo: outerView.bottomAnchor),
            thirdSubview.leadingAnchor.constraint(greaterThanOrEqualTo: secondSubview.trailingAnchor, constant: 5),

            // Icon pick constraints
            viewIconPick.leadingAnchor.constraint(equalTo: thirdSubview.leadingAnchor, constant: 5),
            viewIconPick.topAnchor.constraint(equalTo: thirdSubview.topAnchor, constant: 10),
            viewIconPick.widthAnchor.constraint(equalToConstant: 20),
            viewIconPick.heightAnchor.constraint(equalToConstant: 20),

            // Total pick label constraints
            totalPick.leadingAnchor.constraint(equalTo: viewIconPick.trailingAnchor, constant: 5),
            totalPick.centerYAnchor.constraint(equalTo: viewIconPick.centerYAnchor),
            totalPick.trailingAnchor.constraint(equalTo: thirdSubview.trailingAnchor, constant: 0),
            
            // Icon drop constraints
            viewIconDrop.leadingAnchor.constraint(equalTo: thirdSubview.leadingAnchor, constant: 5),
            viewIconDrop.topAnchor.constraint(equalTo: totalPick.bottomAnchor, constant: 10),
            viewIconDrop.widthAnchor.constraint(equalToConstant: 20),
            viewIconDrop.heightAnchor.constraint(equalToConstant: 20),

            // Total drop label constraints
            totalDrop.leadingAnchor.constraint(equalTo: viewIconDrop.trailingAnchor, constant: 5),
            totalDrop.centerYAnchor.constraint(equalTo: viewIconDrop.centerYAnchor),
            totalDrop.trailingAnchor.constraint(equalTo: thirdSubview.trailingAnchor, constant: 0),
            
            // Confirm User pick-drop label constraints
            confirmUserPickDrop.topAnchor.constraint(equalTo: viewIconDrop.bottomAnchor, constant: 5),
            confirmUserPickDrop.trailingAnchor.constraint(equalTo: thirdSubview.trailingAnchor, constant: 0),
        ])
    }
}
