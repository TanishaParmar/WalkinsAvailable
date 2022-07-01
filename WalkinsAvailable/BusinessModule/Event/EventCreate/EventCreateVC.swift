//
//  EventCreateVC.swift
//  WalkinsAvailable
//
//  Created by apple on 04/05/22.
//

import UIKit
//import IQKeyboardManagerSwift

class EventCreateVC: UIViewController {

//    MARK: OUTLETS
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var eventUploadImgView: UIImageView!
    @IBOutlet weak var uploadImgViewBtn: UIButton!
    @IBOutlet weak var eventNameTF: UITextField!
    @IBOutlet weak var eventNameView: UIView!
    @IBOutlet weak var starttimeView: UIView!
    @IBOutlet weak var endTimeView: UIView!
    @IBOutlet weak var startTimeTF: UITextField!
    @IBOutlet weak var endTimeTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    
    var imagePicker: ImagePicker!
    var pickerData: PickerData?
    var coordi: (latitude: Double, longitude: Double)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    //MARK: FUNCTIONS
    func configureUI() {
        eventNameTF.delegate = self
        startTimeTF.delegate = self
        endTimeTF.delegate = self
        dateTF.delegate = self
        locationTF.delegate = self
        descriptionTextView.delegate = self
        eventUploadImgView.addCornerRadius(view: eventUploadImgView, cornerRadius: 10.0)
        eventNameView.addCornerBorderAndShadow(view: eventNameView, cornerRadius: 5, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        starttimeView.addCornerBorderAndShadow(view: starttimeView, cornerRadius: 5, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        endTimeView.addCornerBorderAndShadow(view: endTimeView, cornerRadius: 5, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        dateView.addCornerBorderAndShadow(view: dateView, cornerRadius: 5, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        locationView.addCornerBorderAndShadow(view: locationView, cornerRadius: 5, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        descriptionView.addCornerBorderAndShadow(view: descriptionView, cornerRadius: 5, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    func setPickerData(image: UIImage?) {
        let jpegData = image?.jpegData(compressionQuality: 0.5)
        self.pickerData = PickerData()
        self.pickerData?.image = image
        self.pickerData?.data = jpegData
    }
    
    func openStartTimePicker() {
        let timePicker = CustomDatePicker()
        timePicker.set(nil, self, 0, .time, "hh:mm", nil, nil)
        self.present(timePicker, animated: false, completion: nil)
    }
    
    func openEndTimePicker() {
        let timePicker = CustomDatePicker()
        timePicker.set(nil, self, 1, .time, "hh:mm", nil, nil)
        self.present(timePicker, animated: false, completion: nil)
    }
    
    func openDatePicker() {
        let datePicker = CustomDatePicker()
        datePicker.set(nil, self, 2, .date, "YYYY-mm-dd", nil, nil)
        self.present(datePicker, animated: false, completion: nil)
    }

    
    func openLocationPicker() {
        let locale = LocationPicker()
        locale.delegate = self
        self.present(locale, animated: true, completion: nil)
    }
    
    func generatingParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["eventName"] = eventNameTF.text
        params["eventDate"] = dateTF.text
        params["startTime"] = startTimeTF.text
        params["endTime"] = endTimeTF.text
        params["eventDescription"] = descriptionTextView.text
        params["eventLocation"] = locationTF.text
        params["latitude"] = coordi?.latitude
        params["longitude"] = coordi?.longitude
        params["deviceType"] = "1"
        print(params)
        return params
    }
    
    //MARK: Hit create event API
    func hitCreateEventApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.addEvent, params: generatingParameters(), profilePhoto: self.pickerData) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
//                UserDefaultsCustom.saveLogInData(data: data)
//                Singleton.setHomeScreenView()
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .success)
                }
                self.navigationController?.popViewController(animated: true)
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }

    
    
    func validate() {
        if ValidationManager.shared.isEmpty(text: eventNameTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterEventName, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: startTimeTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterStartTime, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: endTimeTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterEndTime, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: dateTF.text) == true{
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterDate, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: locationTF.text) == true{
            Singleton.shared.showErrorMessage(error: AppAlertMessage.chooseLocation, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: descriptionTextView.text) == true{
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterDescription, isError: .error)
        }else if self.pickerData == nil {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.chooseImage, isError: .error)
        }else {
            hitCreateEventApi()
        }
    }
    
    
    @IBAction func uploadImgViewBtn(_ sender: UIButton) {
        if self.imagePicker.checkCameraAccess() {
        self.imagePicker.present(from: sender)
        }
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        validate()
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


//      MARK: Image Picker DELEGATES
extension EventCreateVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let image = image {
            self.eventUploadImgView.image = image
            self.setPickerData(image: image)
        }
    }
    
}


//    MARK: Location Picker DELEGATES
extension EventCreateVC: LocationPickerDelegate {
    func locationDidSelect(locationItem: LocationItem) {
        print("location picked******** \(locationItem.formattedAddressString)")
        print("location picker coordinates ******** \(locationItem.coordinate?.latitude), \(locationItem.coordinate?.longitude)")
        self.locationTF.text = locationItem.formattedAddressString
        self.coordi = locationItem.coordinate
    }
}



//      MARK: TEXTFIELD DELEGATES
extension EventCreateVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        eventNameView.layer.borderColor = textField == eventNameTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        starttimeView.layer.borderColor = textField == startTimeTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        endTimeView.layer.borderColor = textField == endTimeTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        dateView.layer.borderColor = textField == dateTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        locationView.layer.borderColor = textField == locationTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        switch textField {
        case startTimeTF:
            self.view.endEditing(true)
            self.openStartTimePicker()
            return false
        case endTimeTF:
            self.view.endEditing(true)
            self.openEndTimePicker()
            return false
        case dateTF:
            self.view.endEditing(true)
            self.openDatePicker()
            return false
        case locationTF:
            self.view.endEditing(true)
            self.openLocationPicker()
            return false
        default:
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        eventNameView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        starttimeView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        endTimeView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        dateView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        locationView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//    MARK: TEXTVIEW DELEGATES
extension EventCreateVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.descriptionView.layer.borderColor = #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.descriptionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}


extension EventCreateVC: CustomDatePickerDelegate {
    func pickedDate(date: String, _ tag: Int, _ datePickerDate: Date?) {
        print("values are ***** \(date) *** \(datePickerDate) *** \(tag)")
        if tag == 0 {
            startTimeTF.text = date
        } else if tag == 1 {
            endTimeTF.text = date
        } else if tag == 2 {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            let dateConv = dateFormatter.string(from: datePickerDate!)
            dateTF.text = dateConv
        }
    }
    
    func cancelPicker(_ tag: Int) {
//        <#code#>
    }
    
    
}
