//
//  ViewController.swift
//  My Weather App
//
//  Created by Youssef Bhl on 09/02/2022.
//

import UIKit
import MapKit

class MainController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var weathers: [WeatherInfo] = []
    var redusedWeathers: [WeatherInfo] = []
    var closeWeathers : [WeatherInfo] = []
    var lat : CLLocationDegrees = CLLocationDegrees(UDHelper.shared.getLat())
    var lon : CLLocationDegrees = CLLocationDegrees(UDHelper.shared.getLon())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        UDHelper.shared.initialize()
        waitingUntilDataLoad()
        self.weatherRecived(self.lat, self.lon)
    }
    
    func weatherRecived(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees) {
        let CurrentLocation = UDHelper.shared.getLocation()
        getCoordsFromAdress(CurrentLocation)
        APIHelper.shared.performRequest(lat, lon) { weathers in
            DispatchQueue.main.async {
                self.weathers = weathers
            }
        }
    }
    
    func getCoordsFromAdress(_ adress: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(adress) { placemarks, error in
            if let placemark = placemarks?.first {
                let location = placemark.location
                guard location != nil else { return }
                self.lat = location!.coordinate.latitude
                self.lon = location!.coordinate.longitude
            }
        }
    }
    
    func reduseWeathers() {
        if !weathers.isEmpty {
            var index = 0
            for _ in 0...10 {
                redusedWeathers.append(weathers[index])
                index += 3
            }
            for i in 1...10 {
                closeWeathers.append(self.weathers[i])
            }
            tableView.reloadData()
        }
    }
    
    func waitingUntilDataLoad() {
            
        if weathers.isEmpty {
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.startAnimating()
            view.addSubview(spinner)
            spinner.color = .label
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            var time = 0
            let alertController = UIAlertController(title: "Erreur", message: "Il semble que vous êtes hors ligne, veuillez vous connecter a un réseaux pour accéder a l'application", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Quiter", style: .destructive, handler: nil))
            alertController.addAction(UIAlertAction(title: "Ressayer", style: .default, handler: {action in
                self.tableView.reloadData()
                self.tableView.isHidden = false
                time = 0
            }))
            let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if !self.weathers.isEmpty {
                    self.reduseWeathers()
                    self.tableView.reloadData()
                    spinner.stopAnimating()
                    spinner.isHidden = true
                    timer.invalidate()
                }
                time += 1
                if time>6 && self.weathers.isEmpty  {
                    self.present(alertController, animated: true, completion: nil)
                    spinner.stopAnimating()
                    spinner.isHidden = true
                }
            }
        }
    }
    
    @IBAction func changeLocation(_ sender: Any) {
        let alert = UIAlertController()
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let locations = UDHelper.shared.getArray()
        locations.forEach { location in
            let newLocation = UIAlertAction(title: location, style: .default) { action in
                UDHelper.shared.setLocation(location)
                self.weathers.removeAll()
                self.redusedWeathers.removeAll()
                self.closeWeathers.removeAll()
                self.weatherRecived(self.lat, self.lon)
                self.waitingUntilDataLoad()
                self.reduseWeathers()
                UDHelper.shared.setLat(Float(self.lat))
                UDHelper.shared.setLon(Float(self.lon))
                self.tableView.reloadData()
            }
            alert.addAction(newLocation)
        }
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addLocation(_ sender: Any) {
        let TFalert = UIAlertController(title: "Ajouter Location", message: nil, preferredStyle: .alert)
        TFalert.addTextField { tf in
            tf.placeholder = "Entrez le nom"
        }
        let validateBtn = UIAlertAction(title: "OK", style: .default) { action in
            if let value = TFalert.textFields?.first?.text {
                var existant = false
                let locations = UDHelper.shared.getArray()
                locations.forEach { location in
                    if value == location {
                        existant = true
                    }
                }
                if existant == false {
                    UDHelper.shared.setArray(value)
                    UDHelper.shared.setLocation(value)
                    self.weathers.removeAll()
                    self.redusedWeathers.removeAll()
                    self.closeWeathers.removeAll()
                    self.weatherRecived(self.lat, self.lon)
                    UDHelper.shared.setLat(Float(self.lat))
                    UDHelper.shared.setLon(Float(self.lon))
                    self.waitingUntilDataLoad()
                    self.reduseWeathers()
                    self.tableView.reloadData()
                    
                } else if existant {
                    let errorAlert = UIAlertController(title: "Déja Existant !", message: "Cette localisation existe déjà, vous pouvez la séléctionner dans l'onglet 'Changer'", preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "Retour", style: .destructive, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        TFalert.addAction(cancel)
        TFalert.addAction(validateBtn)
        present(TFalert, animated: true, completion: nil)
    }
}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if weathers.isEmpty {
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0 : return 1
        case 1 : return 1
        case 2 : if !weathers.isEmpty { return redusedWeathers.count } else { waitingUntilDataLoad() } ; return 1
    
        default : return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if !weathers.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: FirstCustomCell.identifier, for: indexPath) as! FirstCustomCell
                var min : Float = weathers[0].main.temp_min
                var max : Float = weathers[0].main.temp_max
                for index in 1...10 {
                    if weathers[index].main.temp_min <= min {
                        min = weathers[index].main.temp_min
                    }
                    if weathers[index].main.temp_max >= max {
                        max = weathers[index].main.temp_max
                    }
                }
                cell.currentLocation = UDHelper.shared.getLocation()
                cell.max = max
                cell.min = min
                cell.currentWeather = weathers[0]
                cell.selectionStyle = .none
                return cell
            } else if weathers.isEmpty {
                waitingUntilDataLoad()
            }
            
        } else if indexPath.section == 1 {
            if !weathers.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: SecondCustomCell.identifier, for: indexPath) as! SecondCustomCell
                cell.closeWeathers = closeWeathers
                cell.collectionView.reloadData()
                return cell
            }
        } else if indexPath.section == 2 {
            if !weathers.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: ThirdCustomCell.identifier, for: indexPath) as! ThirdCustomCell
                cell.selectionStyle = .none
                let currentWeather = redusedWeathers[indexPath.row]
                cell.configure(currentWeather)
                return cell
            }
        }
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if weathers.isEmpty { return view.frame.height}
        if indexPath.section == 0 {
            return 300
        } else if indexPath.section == 1 {
            return 180
        } else if indexPath.section == 2 {
            return 120
        }
        return 30
    }
}
