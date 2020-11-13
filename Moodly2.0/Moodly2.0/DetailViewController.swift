import UIKit

class DetailViewController: UIViewController {
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  
  var service: Services? {
    didSet {
      configureView()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  func configureView() {
    if let service = service,
      let detailDescriptionLabel = detailDescriptionLabel{
        detailDescriptionLabel.text = service.name
      title = service.phoneNumber.rawValue
    }
  }
}
