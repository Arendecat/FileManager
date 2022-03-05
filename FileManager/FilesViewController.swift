
import UIKit

class FilesViewController: UIViewController {

    private var arrayOfPhotos: [UIImage] = []
    private var documentsUrl: URL?
    private let filesView = FilesView()
    private let userDefaults = UserDefaults.standard
    private var isAlphabetSort: Bool = true
    
    @objc func addFile(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    
    private func fetchPhotos() -> [UIImage] {
        var imagesArray: [UIImage] = []
        var contents: [URL] = []
        
        do {
            documentsUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            contents = try FileManager.default.contentsOfDirectory(at: documentsUrl!, includingPropertiesForKeys: nil, options: [])
        } catch {print(error)}
        
        contents.forEach { imageURL in
            var imageData: Data?
            do {try imageData = Data(contentsOf: imageURL)} catch {print(error)}
            var image: UIImage?
            if (imageData != nil) { image = UIImage.init(data: imageData!) }
            if (image != nil) { imagesArray.append(image!) }
        }
        return imagesArray
    }
    
    override func loadView() {
        self.view = filesView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isAlphabetSort = userDefaults.bool(forKey: "isAlphabetSort")
        filesView.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (userDefaults.string(forKey: "isAlphabetSort") == nil) {
            userDefaults.setValue(true, forKey: "isAlphabetSort")
        }
        arrayOfPhotos = fetchPhotos()
        filesView.collectionView.dataSource = self
        filesView.collectionView.delegate = self
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFile)), animated: true)

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

extension FilesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayOfPhotos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        if(isAlphabetSort) {
            cell.imageView.image = arrayOfPhotos[indexPath.item] //алфавитный порядок
        } else {
            cell.imageView.image = arrayOfPhotos[arrayOfPhotos.count - indexPath.item - 1] //обратный порядок
        }
        return cell
    }
}

extension FilesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3 - 16, height: collectionView.frame.width/3 - 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

extension FilesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image: UIImage = info[.originalImage] as? UIImage else {print ("ошибка получения данных"); return}
        let fileName = "photo" + String(arrayOfPhotos.count + 1)
        let filePath = documentsUrl!.appendingPathComponent(fileName)
        FileManager.default.createFile(atPath: filePath.path, contents: image.pngData()!, attributes: nil)
        arrayOfPhotos = fetchPhotos()
        filesView.collectionView.reloadData()
        picker.dismiss(animated: true)
    }
}

