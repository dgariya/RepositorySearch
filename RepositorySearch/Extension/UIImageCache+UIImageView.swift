import UIKit

let cache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func downloadImageWithUrl(imagePath: String) {
        if let image = cache.object(forKey: imagePath as NSString) {
            self.image = image
        } else {
            let placeholder = UIImage(systemName: "applelogo")!
            self.image = placeholder
        }
        let url: URL! = URL(string: imagePath)
        let task = URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) in
            if let data = try? Data(contentsOf: url) {
                let img: UIImage! = UIImage(data: data)
                cache.setObject(img, forKey: imagePath as NSString)
                DispatchQueue.main.async {
                    self.image = img
                }
            }
        })
        task.resume()
    }
}

