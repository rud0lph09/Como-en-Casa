class ProfileViewController: UIViewController {
    
    
    var userInfoInputView: personalInfoViewInputs!
    
    var OKbutton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        customInit()
    }
    
    func customInit(){
        self.view.backgroundColor = FancyOrange
        self.OKbutton = UIButton(type: .System)
        self.OKbutton.frame = CGRect(x: self.view.frame.width - 100, y: 30, width: 80, height: 40)
        self.OKbutton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.OKbutton.setTitle("OK", forState: .Normal)
        self.OKbutton.backgroundColor = UIColor.clearColor()
        self.OKbutton.titleLabel?.font = UIFont(name: "Avenir-Next", size: 50)
        self.OKbutton.addTarget(self, action: #selector(self.getBack(_:)), forControlEvents: .TouchUpInside)
        
        //INITIALIZATION
        self.userInfoInputView = personalInfoViewInputs(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        
        
        
        //ADDING STUFF TO VIEW
        self.view.addSubview(userInfoInputView)
        self.view.addSubview(OKbutton)
    }
    
    func getBack(sender: AnyObject){
        self.performSegueWithIdentifier("return", sender: nil)
    }
    
}

//======================//
//   PERSONAL INFO #1   //
//======================//

class personalInfoViewInputs: UIView {
    
    //VARIABLES AND INPUTS DECLARATIONS
    var photoButton: UIButton!
    var telephoneIcon: UIImageView!
    
    //First Section
    var nameField: UITextField!
    var apellidosField: UITextField!
    var phoneField: UITextField!
    var underName: UILabel!
    var underApellidos: UILabel!
    var underPhone: UILabel!
    
    //Second Section
    var passwordField: UITextField!
    var passwordVerification: UITextField!
    var email: UITextField!
    var emailVerification: UITextField!
    var passwordIcon: UIImageView!
    var emailIcon: UIImageView!
    var underEmail: UILabel!
    var underEmailV: UILabel!
    var underPass: UILabel!
    var underPassV: UILabel!
    
    
    
    //INITIALIZATION
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func customInit(frame: CGRect){
        
        //FORCING FRAME ONLY WIDTH AND HEIGHT MATTER
        self.frame = CGRect(x: 0, y: 50 + 15, width: frame.width, height: frame.height - (50 + 15))
        
        
        
        
        //INITIALIZE ITEMS AND IMPUTS - FIRST SECCTION
        self.photoButton = UIButton(frame: CGRect(x: 10, y: 15, width: 70, height: 70))
        self.nameField = UITextField(frame: CGRect(x: 90, y: 15, width: (frame.width - 120), height: 30))
        self.apellidosField = UITextField(frame: CGRect(x: 90, y: (15 + 30 + 10), width: (frame.width - 120), height: 30))
        self.phoneField = UITextField(frame: CGRect(x: 50, y: (15 + 80), width: (frame.width - (50 + 30)), height: 30))
        self.telephoneIcon = UIImageView(frame: CGRect(x: 10, y: (15 + 80), width: 25, height: 25))
        //INITIALIZE ITEMS AND INPUTS - SECOND SECTION
        self.emailIcon = UIImageView(frame: CGRect(x: 10, y: (15 + 120), width: 25, height: 25))
        self.email =  UITextField(frame: CGRect(x: 50, y: (15 + 120), width: (frame.width - (50 + 30)), height: 30))
        self.emailVerification = UITextField(frame: CGRect(x: 50, y: (15 + 160), width: (frame.width - (50 + 30)), height: 30))
        self.passwordIcon = UIImageView(frame: CGRect(x: 10, y: (15 + 200), width: 25, height: 25))
        self.passwordField = UITextField(frame: CGRect(x: 50, y: (15 + 200), width: (frame.width - (50 + 30)), height: 30))
        self.passwordVerification = UITextField(frame: CGRect(x: 50, y: (15 + 240), width: (frame.width - (50 + 30)), height: 30))
        
        //CUSTOMIZE FIELDS
        self.nameField.borderStyle = .None
        self.apellidosField.borderStyle = .None
        self.phoneField.borderStyle = .None
        self.nameField.attributedPlaceholder = NSAttributedString(string: "  Nombre(s)", attributes: attributedColorMildWhiteForPlaceHolders)
        self.nameField.text = "Rodolfo"
        self.apellidosField.attributedPlaceholder =  NSAttributedString(string: "  A. Paterno", attributes: attributedColorMildWhiteForPlaceHolders)
        self.apellidosField.text = "Castillo"
        self.phoneField.attributedPlaceholder = NSAttributedString(string: "  A. Materno", attributes: attributedColorMildWhiteForPlaceHolders)
        self.phoneField.text = "Vidrio"
        //SECOND SECTION
        self.email.borderStyle = .None
        self.emailVerification.borderStyle = .None
        self.passwordField.borderStyle = .None
        self.passwordVerification.borderStyle = .None
        self.email.attributedPlaceholder = NSAttributedString(string: "  Correo Electrónico", attributes: attributedColorMildWhiteForPlaceHolders)
        self.email.text = "raindeerdeveloper@gmail.com"
        self.email.keyboardType = .EmailAddress
        self.emailVerification.attributedPlaceholder = NSAttributedString(string: "  Teléfono", attributes: attributedColorMildWhiteForPlaceHolders)
        self.emailVerification.text = "(55-21061342)"
        self.emailVerification.keyboardType = .NumberPad
        self.passwordField.attributedPlaceholder = NSAttributedString(string: "  Contraseña", attributes: attributedColorMildWhiteForPlaceHolders)
        self.passwordVerification.attributedPlaceholder = NSAttributedString(string: "  Verifica tu Contraseña", attributes: attributedColorMildWhiteForPlaceHolders)
        
        //UNDERLINES
        self.underName = UILabel(frame: CGRect(x: 90, y: 45, width: self.nameField.frame.width, height: 1.5))
        self.underApellidos = UILabel(frame: CGRect(x: 90, y: self.apellidosField.frame.origin.y + 30, width: self.apellidosField.frame.width, height: 1.5))
        self.underPhone = UILabel(frame: CGRect(x: self.phoneField.frame.origin.x, y: self.phoneField.frame.origin.y + 30, width: self.phoneField.frame.width, height: 1.5))
        self.underEmail = UILabel(frame: CGRect(x: self.email.frame.origin.x, y: self.email.frame.origin.y + 30, width: self.email.frame.width, height: 1.5))
        self.underEmailV = UILabel(frame: CGRect(x: self.emailVerification.frame.origin.x, y: self.emailVerification.frame.origin.y + 30, width: self.emailVerification.frame.width, height: 1.5))
        self.underPass = UILabel(frame: CGRect(x: self.passwordField.frame.origin.x, y: self.passwordField.frame.origin.y + 30, width: self.passwordField.frame.width, height: 1.5))
        self.underPassV = UILabel(frame: CGRect(x: self.passwordVerification.frame.origin.x, y: self.passwordVerification.frame.origin.y + 30, width: self.passwordVerification.frame.width, height: 1.5))
        
        self.photoButton.setImage(UIImage(named: "profilepic"), forState: .Normal)
        
        //UNDERLINES COLORS
        self.underPhone.backgroundColor = mildWhiteColor
        self.underName.backgroundColor = mildWhiteColor
        self.underApellidos.backgroundColor = mildWhiteColor
        self.underPass.backgroundColor = mildWhiteColor
        self.underPassV.backgroundColor = mildWhiteColor
        self.underEmail.backgroundColor = mildWhiteColor
        self.underEmailV.backgroundColor = mildWhiteColor
        
        //CUSTOMIZE OTHER STUFF LIKE PHOTO BUTTONS AND STUFF
        self.photoButton.clipsToBounds = true
        self.photoButton.layer.cornerRadius = (self.photoButton.frame.width / 2)
        //        self.telephoneIcon.image = UIImage(named: "phoneIcon")
        self.emailIcon.image = UIImage(named: "mailIcon")
        self.passwordIcon.image = UIImage(named: "keyIcon")
        
        self.nameField.textColor = UIColor.whiteColor()
        self.apellidosField.textColor = UIColor.whiteColor()
        self.phoneField.textColor = UIColor.whiteColor()
        self.email.textColor = UIColor.whiteColor()
        self.emailVerification.textColor = UIColor.whiteColor()
        
        //DEBUGGING
        //        self.nameField.backgroundColor = UIColor.orangeColor()
        //        self.apellidosField.backgroundColor = UIColor.orangeColor()
        //        self.phoneField.backgroundColor = UIColor.orangeColor()
        //        self.telephoneIcon.backgroundColor = UIColor.orangeColor()
        self.photoButton.backgroundColor = UIColor.orangeColor()
        
        //ADDING ITEMS TO VIEW
        self.addSubview(nameField)
        self.addSubview(apellidosField)
        self.addSubview(photoButton)
        self.addSubview(phoneField)
        //        self.addSubview(telephoneIcon)
        self.addSubview(underName)
        self.addSubview(underApellidos)
        self.addSubview(underPhone)
        self.addSubview(email)
        self.addSubview(underEmail)
        self.addSubview(emailVerification)
        self.addSubview(underEmailV)
        self.addSubview(emailIcon)
        
    }
    
    
    
    
    
}