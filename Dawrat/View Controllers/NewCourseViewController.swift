//
//  NewCourseViewController.swift
//  Dawrat
//
//  Created by بدور on 22/05/2019.
//  Copyright © 2019 Bdour. All rights reserved.
//

import UIKit
import Eureka
import MapKit

class NewCourseViewController: FormViewController {
    
    var viewModel: ViewModel!
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy, h:mm a"
        return formatter
    }()
    
    // MARK: - Life Cycle
    convenience init(viewModel: ViewModel) {
        self.init()
        var course =  Course()
        self.viewModel = ViewModel(course : course)
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var course =  Course()
        self.viewModel = ViewModel(course : course)
        initialize()
        //1
        form
            +++ Section() { section in
                var header = HeaderFooterView<HeaderSection>(.nibFile(name: "HeaderSection", bundle: nil))
                
                // Will be called every time the header appears on screen
                header.onSetupView = { view, _ in
                    // Commonly used to setup texts inside the view
                    // Don't change the view hierarchy or size here!
                }
                section.header = header
            }
            
            <<< TextRow() { // 3
                $0.title = "Title" //4
                $0.placeholder = "Enter title here"
                $0.value = viewModel.title //5
                $0.onChange { [unowned self] row in //6
                    self.viewModel.title = row.value
                }
                $0.add(rule: RuleRequired()) //1
                $0.validationOptions = .validatesOnChange //2
                $0.cellUpdate { (cell, row) in //3
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            }
             +++ Section("GENERAL")    //2
            <<< SegmentedRow<String>() {
                $0.title = "Gender"
                $0.value = viewModel.gender
                $0.options = viewModel.genderOptions
                $0.onChange { [unowned self] row in
                    if let value = row.value {
                        self.viewModel.gender = value
                    }
                }
            }
            <<< IntRow(){
                $0.title = "Number Of Student"
                $0.value = 1
                let formatter = NumberFormatter()
                formatter.locale = .current
                
                $0.formatter = formatter
            }
            
            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Cost"
                $0.value = 0
                let formatter = CurrencyFormatter()
                formatter.locale = .current
                formatter.numberStyle = .currency
                $0.formatter = formatter
            }
            <<< PushRow<String>() { //1
                $0.title = "Category" //2
                $0.value = viewModel.category //3
                $0.options = viewModel.categoryOptions //4
                $0.onChange { [unowned self] row in //5
                    if let value = row.value {
                        self.viewModel.category = value
                    }
                }
            }
            
            
            +++ Section("DATE")    //2
            
            <<< DateTimeRow() {
                $0.dateFormatter = type(of: self).dateFormatter //1
                $0.title = "From" //2
                $0.value = viewModel.StartDate//3
                $0.minimumDate = Date() //4
                $0.onChange { [unowned self] row in //5
                    if let date = row.value {
                        self.viewModel.StartDate = date
                    }
                }
            }
            <<< DateTimeRow() {
                $0.dateFormatter = type(of: self).dateFormatter //1
                $0.title = "To" //2
                $0.value = viewModel.StartDate//3
                $0.minimumDate = Date() //4
                $0.onChange { [unowned self] row in //5
                    if let date = row.value {
                        self.viewModel.StartDate = date
                    }
                }
            }
            
            +++ Section("LOCATION")
            
            <<< LocationRow("location") {
                $0.title = "Location"
                $0.onChange { [unowned self] row in //5
                    if let value = row.value {
                        //  self.viewModel.location = value
                    }
                }
            }
            
            +++ Section("More Info")
//            <<< ActionSheetRow<String>() {
//                $0.title = "Gender"
//                //   $0.selectorTitle = "Choose "
//                $0.options = ["Male","Female","Both"]
//                $0.value = "Male"    // initially selected
//            }
            
        
            <<< TextRow() { // 3
                $0.title = "Hosted By :" //4
                $0.placeholder = "@Someone"
             //   $0.value = viewModel.title //5
                $0.onChange { [unowned self] row in //6
                  //  self.viewModel.title = row.value
                }
            }
            <<< TextAreaRow("Detaile") {
                $0.placeholder = "Notes"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 50)
        }
        
        
    }
    
    private func initialize() {
        let deleteButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: .deleteButtonPressed)
        navigationItem.leftBarButtonItem = deleteButton
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: .saveButtonPressed)
        navigationItem.rightBarButtonItem = saveButton
        
        view.backgroundColor = .white
    }
    
    
    // MARK: - Actions
    @objc fileprivate func saveButtonPressed(_ sender: UIBarButtonItem) {
        if form.validate().isEmpty {
            _ = navigationController?.popViewController(animated: true)
        }

    }
    
    @objc fileprivate func deleteButtonPressed(_ sender: UIBarButtonItem) {
        
        // Uncomment these lines
        //    let alert = UIAlertController(title: "Delete this item?", message: nil, preferredStyle: .alert)
        //    let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        //    let delete = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
        //      self?.viewModel.delete()
        //      _ = self?.navigationController?.popViewController(animated: true)
        //    }
        //
        //    alert.addAction(delete)
        //    alert.addAction(cancel)
        //
        //    navigationController?.present(alert, animated: true, completion: nil)
        
        // Delete this line
        _ = navigationController?.popViewController(animated: true)
    }
}

// MARK: - Selectors
extension Selector {
    fileprivate static let saveButtonPressed = #selector(NewCourseViewController.saveButtonPressed(_:))
    fileprivate static let deleteButtonPressed = #selector(NewCourseViewController.deleteButtonPressed(_:))
}

//MARK: LocationRow
public final class LocationRow: OptionsRow<PushSelectorCell<CLLocation>>, PresenterRowType, RowType {
    
    public typealias PresenterRow = MapViewController
    
    /// Defines how the view controller will be presented, pushed, etc.
    public var presentationMode: PresentationMode<PresenterRow>?
    
    /// Will be called before the presentation occurs.
    public var onPresentCallback: ((FormViewController, PresenterRow) -> Void)?
    
    
    
    public required init(tag: String?) {
        super.init(tag: tag)
        presentationMode = .show(controllerProvider: ControllerProvider.callback { return MapViewController(){ _ in } }, onDismiss: { vc in _ = vc.navigationController?.popViewController(animated: true) })
        
        displayValueFor = {
            guard let location = $0 else { return "" }
            let fmt = NumberFormatter()
            fmt.maximumFractionDigits = 4
            fmt.minimumFractionDigits = 4
            let latitude = fmt.string(from: NSNumber(value: location.coordinate.latitude))!
            let longitude = fmt.string(from: NSNumber(value: location.coordinate.longitude))!
            return  "\(latitude), \(longitude)"
        }
    }
    
    /**
     Extends `didSelect` method
     */
    public override func customDidSelect() {
        super.customDidSelect()
        guard let presentationMode = presentationMode, !isDisabled else { return }
        if let controller = presentationMode.makeController() {
            controller.row = self
            controller.title = selectorTitle ?? controller.title
            onPresentCallback?(cell.formViewController()!, controller)
            presentationMode.present(controller, row: self, presentingController: self.cell.formViewController()!)
        } else {
            presentationMode.present(nil, row: self, presentingController: self.cell.formViewController()!)
        }
    }
    
    /**
     Prepares the pushed row setting its title and completion callback.
     */
    public override func prepare(for segue: UIStoryboardSegue) {
        super.prepare(for: segue)
        guard let rowVC = segue.destination as? PresenterRow else { return }
        rowVC.title = selectorTitle ?? rowVC.title
        rowVC.onDismissCallback = presentationMode?.onDismissCallback ?? rowVC.onDismissCallback
        onPresentCallback?(cell.formViewController()!, rowVC)
        rowVC.row = self
    }
}

public class MapViewController : UIViewController, TypedRowControllerType, MKMapViewDelegate {
    
    public var row: RowOf<CLLocation>!
    public var onDismissCallback: ((UIViewController) -> ())?
    
    lazy var mapView : MKMapView = { [unowned self] in
        let v = MKMapView(frame: self.view.bounds)
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return v
        }()
    
    lazy var pinView: UIImageView = { [unowned self] in
        let v = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        v.image = UIImage(named: "map_pin", in: Bundle(for: MapViewController.self), compatibleWith: nil)
        v.image = v.image?.withRenderingMode(.alwaysTemplate)
        v.tintColor = self.view.tintColor
        v.backgroundColor = .clear
        v.clipsToBounds = true
        v.contentMode = .scaleAspectFit
        v.isUserInteractionEnabled = false
        return v
        }()
    
    let width: CGFloat = 10.0
    let height: CGFloat = 5.0
    
    lazy var ellipse: UIBezierPath = { [unowned self] in
        let ellipse = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        return ellipse
        }()
    
    
    lazy var ellipsisLayer: CAShapeLayer = { [unowned self] in
        let layer = CAShapeLayer()
        layer.bounds = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        layer.path = self.ellipse.cgPath
        layer.fillColor = UIColor.gray.cgColor
       
        layer.lineDashPattern = nil
        layer.lineDashPhase = 0.0
       
        layer.lineWidth = 1.0
        layer.miterLimit = 10.0
        layer.strokeColor = UIColor.gray.cgColor
        return layer
        }()
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience public init(_ callback: ((UIViewController) -> ())?){
        self.init(nibName: nil, bundle: nil)
        onDismissCallback = callback
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        
        mapView.delegate = self
        mapView.addSubview(pinView)
        mapView.layer.insertSublayer(ellipsisLayer, below: pinView.layer)
        
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(MapViewController.tappedDone(_:)))
        button.title = "Done"
        navigationItem.rightBarButtonItem = button
        
        if let value = row.value {
            let region = MKCoordinateRegionMakeWithDistance(value.coordinate, 400, 400)
            mapView.setRegion(region, animated: true)
        }
        else{
            mapView.showsUserLocation = true
        }
        updateTitle()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let center = mapView.convert(mapView.centerCoordinate, toPointTo: pinView)
        pinView.center = CGPoint(x: center.x, y: center.y - (pinView.bounds.height/2))
        ellipsisLayer.position = center
    }
    
    
    @objc func tappedDone(_ sender: UIBarButtonItem){
        let target = mapView.convert(ellipsisLayer.position, toCoordinateFrom: mapView)
        row.value = CLLocation(latitude: target.latitude, longitude: target.longitude)
        onDismissCallback?(self)
    }
    
    func updateTitle(){
        let fmt = NumberFormatter()
        fmt.maximumFractionDigits = 4
        fmt.minimumFractionDigits = 4
        let latitude = fmt.string(from: NSNumber(value: mapView.centerCoordinate.latitude))!
        let longitude = fmt.string(from: NSNumber(value: mapView.centerCoordinate.longitude))!
        title = "\(latitude), \(longitude)"
    }
    
    public func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        ellipsisLayer.transform = CATransform3DMakeScale(0.5, 0.5, 1)
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.pinView.center = CGPoint(x: self!.pinView.center.x, y: self!.pinView.center.y - 10)
        })
    }
    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        ellipsisLayer.transform = CATransform3DIdentity
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.pinView.center = CGPoint(x: self!.pinView.center.x, y: self!.pinView.center.y + 10)
        })
        updateTitle()
    }
}
class CurrencyFormatter : NumberFormatter, FormatterProtocol {
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, range rangep: UnsafeMutablePointer<NSRange>?) throws {
        guard obj != nil else { return }
        var str = string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        if !string.isEmpty, numberStyle == .currency && !string.contains(currencySymbol) {
            // Check if the currency symbol is at the last index
            if let formattedNumber = self.string(from: 1), String(formattedNumber[formattedNumber.index(before: formattedNumber.endIndex)...]) == currencySymbol {
                // This means the user has deleted the currency symbol. We cut the last number and then add the symbol automatically
                str = String(str[..<str.index(before: str.endIndex)])
                
            }
        }
        obj?.pointee = NSNumber(value: (Double(str) ?? 0.0)/Double(pow(10.0, Double(minimumFractionDigits))))
    }
    
    func getNewPosition(forPosition position: UITextPosition, inTextInput textInput: UITextInput, oldValue: String?, newValue: String?) -> UITextPosition {
        return textInput.position(from: position, offset:((newValue?.count ?? 0) - (oldValue?.count ?? 0))) ?? position
    }
}

