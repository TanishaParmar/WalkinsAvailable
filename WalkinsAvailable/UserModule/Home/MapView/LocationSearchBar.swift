//
//  LocationSearchBar.swift
//  WalkinsAvailable
//
//  Created by apple on 28/04/22.
//


import UIKit
import MapKit


struct SearchBarProperties {
    static var showsCancelButton : Bool = true
    static var searchBarStyle : UISearchBar.Style = .default
    static var placeholder : String = "Search Place"
    static var tintColor : UIColor = .blue
    static var barTintColor : UIColor = .blue
    static var backgroundColor : UIColor = .white
}

@IBDesignable
class LocationSearchBar: UISearchBar {
    var searchTimer: Timer!
    var interval:TimeInterval = 1.0
    var searchBeginEditing: (()->Void)?
    var searchEndEditing: (()->Void)?
    var searchButtonClicked: (()->Void)?
    var clearList: (()->Void)?
    var cancelButtonClicked: (()->Void)?
    var searchResults:(([Location])->Void)?
    var isSearching:((Bool) -> ())?
    
    public func setViewLayout() {
        print("search bar runs")
        delegate = self
        showsCancelButton = SearchBarProperties.showsCancelButton
        searchBarStyle = SearchBarProperties.searchBarStyle
        placeholder = SearchBarProperties.placeholder
        tintColor = SearchBarProperties.tintColor
        barTintColor = SearchBarProperties.barTintColor
        backgroundImage = UIImage()
        backgroundColor = SearchBarProperties.backgroundColor
    }
    
    func setActions(clearList: (()->Void)?,
                    searchResults:(([Location])->Void)?,
                    isSearching:((Bool) -> ())?,
                    cancelButtonClicked:(()->Void)? = nil,
                    searchButtonClicked:(()->Void)? = nil,
                    searchBeginEditing: (()->Void)? = nil,
                    searchEndEditing: (()->Void)? = nil) {
        self.searchButtonClicked = searchButtonClicked
        self.clearList = clearList
        self.cancelButtonClicked = cancelButtonClicked
        self.searchResults = searchResults
        self.isSearching = isSearching
        self.searchBeginEditing = searchBeginEditing
        self.searchEndEditing = searchEndEditing
        delegate = self
    }
    
    func setSearchBarBackground(color: UIColor) {
        self.compatibleSearchTextField.backgroundColor = color
        self.backgroundColor = color
    }
    
}

extension LocationSearchBar: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBeginEditing?()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchEndEditing?()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchButtonClicked?()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.cancelButtonClicked?()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchTimer != nil {
            searchTimer.invalidate()
            searchTimer = nil
        }
        guard searchText.count > 0 else {
            self.clearList?()
            return
        }
        self.searchTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(searchForTimer(_:)), userInfo: searchText, repeats: false)
    }
    
    @objc func searchForTimer(_ timer: Timer) {
        guard let key = timer.userInfo as? String else {return}
        print("key is ******** \(key)")
        guard key.count > 0 else {
            self.clearList?()
            return
        }
        self.isSearching?(true)
        SearchPlaces.searchFor(text: key) { items in
            DispatchQueue.main.async {
                self.isSearching?(false)
                print("items count **** \(items.count)")
                self.searchResults?(items)
            }
        }
    }
    
}

extension UISearchBar {

    // Due to searchTextField property who available iOS 13 only, extend this property for iOS 13 previous version compatibility
    var compatibleSearchTextField: UITextField {
        guard #available(iOS 13.0, *) else { return legacySearchField }
        return self.searchTextField
    }

    private var legacySearchField: UITextField {
        if let textField = self.subviews.first?.subviews.last as? UITextField {
            // Xcode 11 previous environment
            return textField
        } else if let textField = self.value(forKey: "searchField") as? UITextField {
            // Xcode 11 run in iOS 13 previous devices
            return textField
        } else {
            // exception condition or error handler in here
            return UITextField()
        }
    }
}
