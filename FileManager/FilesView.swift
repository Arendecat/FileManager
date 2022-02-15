import Foundation
import UIKit

class FilesView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
        self.backgroundColor = .systemPink
        documentsTable.backgroundColor = .systemMint
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func viewSetup(){
        [documentsTable].forEach{self.addSubview($0)}
        NSLayoutConstraint.activate([
            documentsTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            documentsTable.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            documentsTable.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            documentsTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    lazy var documentsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
}
