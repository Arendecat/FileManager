
import UIKit

class FilesViewController: UIViewController {

    @objc func addFile(){
        let imagePicker = UIImagePickerController()
        self.present(imagePicker, animated: true, completion: nil)
    }
    
                                        //перенести в отдельный класс модели?
    var arrayOfPhotos: [UIImage] = []
    var documentsUrl: URL?
    
    
    private func fetchPhotos() -> [UIImage] {
        var imagesArray: [UIImage] = []
        
        var contents: [URL] = []
        do {
            documentsUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            contents = try FileManager.default.contentsOfDirectory(at: documentsUrl!, includingPropertiesForKeys: nil, options: [])
        } catch {print(error)}
        contents.forEach { imageURL in
            var imageData: Data = Data()
            do {try imageData = Data(contentsOf: imageURL)} catch {print(error)}
            imagesArray.append(UIImage.init(data: imageData)!) //unsafe
        }
        print(contents)
        return imagesArray
    }
    
    
    override func loadView() {
        self.view = FilesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfPhotos = fetchPhotos()
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFile)), animated: true)
        
        print(arrayOfPhotos)
        
        
        //перенести в класс таббара?
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        //----
        
    }
}

extension FilesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(describing: arrayOfPhotos[indexPath.row]) //(placeholder)
        //надо сделать кастомную ячейку
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Photos"
    }
}
extension FilesViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { //unsafe
        print("aaa")
        guard let imageData = info[.editedImage] as? Data else {return} //можно ли так?
        print("ddddd", imageData)
        let fileName = "photo" + String(arrayOfPhotos.count + 1)
        let filePath = documentsUrl!.appendingPathComponent(fileName)
        FileManager.default.createFile(atPath: filePath.path, contents: imageData, attributes: nil)
        arrayOfPhotos = fetchPhotos()
        let filesView = self.view as! FilesView
        filesView.documentsTable.reloadData()
    }
}

