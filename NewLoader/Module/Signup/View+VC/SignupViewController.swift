

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var mobilenumberTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!

    var ViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextfield.text = "john.smith@mbrhe.ae"
        mobilenumberTextfield.text = "971556987002"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction func signupact_clicked(_ button: UIButton) {
        
        if nameTextfield.text ?? "" == "" {
            self.failureMessage(message: "Please enter name\n")
        } else if nameTextfield.text?.count ?? 0 < 3 {
            self.failureMessage(message: "name must be minimum 3 characters\n")
        } else if emailTextfield.text ?? "" == "" {
            self.failureMessage(message: "Please enter Email ID")
        } else if emailTextfield.text?.isEmail == false {
            self.failureMessage(message: "Please enter valid Email ID")
        } else if mobilenumberTextfield.text ?? "" == "" {
            self.failureMessage(message: "Please enter mobile number")
        } else if mobilenumberTextfield.text?.count ?? 0 < 10 {
            self.failureMessage(message: "Please enter valid mobile number\n")
        } else {
            self.ViewModel.delegate = self
            self.ViewModel.RegisterAPICall(name: nameTextfield.text ?? "", mobileno: mobilenumberTextfield.text ?? "", emailaddress: emailTextfield.text ?? "", unifiednumber: "123" , onSuccess: { status, msg in
                if status == true {
                    self.successMessage(message: msg)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "newsVC") as! NewsViewController
                    self.navigationController?.pushViewController(vc, animated: true)

                } else {
                    self.failureMessage(message: msg)
                }
            }, onFailure: { msg in
                self.failureMessage(message: msg)
            })
        }
    }
}

extension SignupViewController : LoginVCDelegate {
    
}
