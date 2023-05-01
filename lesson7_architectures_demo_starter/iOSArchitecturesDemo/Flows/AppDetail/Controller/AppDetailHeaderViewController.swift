//Created by chizztectep on 22.04.2023 

import UIKit

class AppDetailHeaderViewController: UIViewController {
    // MARK: - Properties
    private let app: ITunesApp
    private let imageDownloader = ImageDownloader()
    
    private var appDetailHeaderView: AppDetailHeaderView {
        return self.view as! AppDetailHeaderView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        self.view = AppDetailHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
    }
    
    // MARK: - Private functions
    private func fillData() {
        downloadImage()
        appDetailHeaderView.titleLabel.text = app.appName
        appDetailHeaderView.subTitleLabel.text = app.company
        //appDetailHeaderView.ratingLabel.text = app.averageRating.flatMap{"\($0)"}
        
    }
    
    private func downloadImage() {
        guard let url = app.iconUrl else {return}
        
        imageDownloader.getImage(fromUrl: url){ [weak self] (image, _) in
            self?.appDetailHeaderView.imageView.image = image
        }
    }
    
    
}
