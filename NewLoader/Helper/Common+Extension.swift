

import Foundation
import UIKit

 extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }

    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }

    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    func isValidPhone(phone: String) -> Bool {
        
        let phoneRegex = "^((0091)|(\\+91)|0?)[6789]{1}\\d{9}$";
        let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
        return valid
    }
 
    var isAlphabetsOnly: Bool {
        return !isEmpty && range(of: "[^a-zA-Z\(" ")]", options: .regularExpression) == nil
    }
    
    func trimmingString() -> String  {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedString
    }
    
    func isContainsWhiteSpace() -> Bool {
        return self.contains(" ")
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }

}

//MARK: - 'asyncImagesCashArray' is a global varible cashed UIImage

class AyncImageView: UIImageView {

//MARK: - Variables
private var currentURL: NSString?

//MARK: - Public Methods

func loadAsyncFrom(url: String, placeholder: UIImage?) {
    var asyncImagesCashArray = NSCache<NSString, UIImage>()

    let imageURL = url as NSString
    if let cashedImage = asyncImagesCashArray.object(forKey: imageURL) {
        image = cashedImage
        return
    }
    image = placeholder
    currentURL = imageURL
    guard let requestURL = URL(string: url) else { image = placeholder; return }
    URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
        DispatchQueue.main.async { [weak self] in
            if error == nil {
                if let imageData = data {
                    if self?.currentURL == imageURL {
                        if let imageToPresent = UIImage(data: imageData) {
                            asyncImagesCashArray.setObject(imageToPresent, forKey: imageURL)
                            self?.image = imageToPresent
                        } else {
                            self?.image = placeholder
                        }
                    }
                } else {
                    self?.image = placeholder
                }
            } else {
                self?.image = placeholder
            }
        }
    }.resume()
}
}

extension UITableView {
    
    func reloadWithAnimation() {
        self.reloadData()
        let tableViewHeight = self.bounds.size.height
        let cells = self.visibleCells
        var delayCounter = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        for cell in cells {
                UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.7, initialSpringVelocity: 0,         options: .allowAnimatedContent, animations: {
                    cell.transform = CGAffineTransform.identity
                }, completion: nil)
            delayCounter += 1
        }
    }
}

    @IBDesignable
        class DesignableView: UIView {
    }

    @IBDesignable
        class DesignableButton: UIButton {
    }

    @IBDesignable
        class DesignableTextField: UITextField {
    }

    @IBDesignable
        class DesignableLabel: UILabel {
    }

    @IBDesignable

        class DesignableViewCustomCorner: UIView {

            @IBInspectable var cornerRadious: CGFloat = 0 {
                    didSet {
                            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: cornerRadious, height: cornerRadious))
                            let mask = CAShapeLayer()
                            mask.path = path.cgPath
                            self.layer.mask = mask
                    }
                }
        }

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}


