//
//  ViewController.swift
//  TestTaskBerezhnoyKirill
//
//  Created by Кирилл Бережной on 12.09.2023.
//

import UIKit
import MapKit

protocol MainViewControllerDelegate {}

class MainViewController: UIViewController, MainViewControllerDelegate {
    
    private let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    
    private lazy var mapView = MKMapView(frame: UIScreen.main.bounds)
    private lazy var plusBtn = UIButton()
    private lazy var minusBtn = UIButton()
    private lazy var nowLocationBtn = UIButton()
    private lazy var messageBtn = UIButton()
    
    let personArray: [Person] = [
        Person(title: "Илья", connection: "GPS", date: "02.07.17", time: "14:00", coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661)),
        Person(title: "Александр", connection: "GPS", date: "03.07.17", time: "21:15", coordinate: CLLocationCoordinate2D(latitude: 21.294761, longitude: -157.830163)),
        Person(title: "Анастасия", connection: "GPS", date: "04.07.17", time: "09:35", coordinate: CLLocationCoordinate2D(latitude: 21.304038, longitude: -157.848963))]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupButtons()
    }
    
    private func setupMap() {
        let initialLocation = CLLocation(latitude: 21.282999, longitude: -157.829444)
        let nowLocation = NowLocationAnnotation(coordinate: initialLocation.coordinate)
        
        mapView.centerToLocation(initialLocation)
        view.addSubview(mapView)
        mapView.addAnnotation(nowLocation)
    }
    
    private func setupConstraints() {
        plusBtn.translatesAutoresizingMaskIntoConstraints = false
        minusBtn.translatesAutoresizingMaskIntoConstraints = false
        nowLocationBtn.translatesAutoresizingMaskIntoConstraints = false
        messageBtn.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            plusBtn.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 285),
            plusBtn.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -12),
            plusBtn.widthAnchor.constraint(equalToConstant: 42),
            minusBtn.topAnchor.constraint(equalTo: plusBtn.bottomAnchor, constant: 14),
            minusBtn.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -12),
            minusBtn.widthAnchor.constraint(equalToConstant: 42),
            nowLocationBtn.topAnchor.constraint(equalTo: minusBtn.bottomAnchor, constant: 14),
            nowLocationBtn.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -12),
            nowLocationBtn.widthAnchor.constraint(equalToConstant: 42),
            messageBtn.topAnchor.constraint(equalTo: nowLocationBtn.bottomAnchor, constant: 14),
            messageBtn.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -12),
            messageBtn.widthAnchor.constraint(equalToConstant: 42),
        ])
    }
    private func setupButtons() {
        plusBtn.layer.cornerRadius = 15
        plusBtn.setImage(UIImage(named: "plus"), for: .normal)
        plusBtn.addTarget(self, action: #selector(plusBtnTapped), for: .touchUpInside)
        
        minusBtn.layer.cornerRadius = 15
        minusBtn.setImage(UIImage(named: "minus"), for: .normal)
        minusBtn.addTarget(self, action: #selector(minusBtnTapped), for: .touchUpInside)
        
        nowLocationBtn.layer.cornerRadius = 15
        nowLocationBtn.setImage(UIImage(named: "location"), for: .normal)
        nowLocationBtn.addTarget(self, action: #selector(locationBtnTapped), for: .touchUpInside)
        
        messageBtn.layer.cornerRadius = 15
        messageBtn.setImage(UIImage(named: "message"), for: .normal)
        messageBtn.addTarget(self, action: #selector(locationBtnTapped), for: .touchUpInside)
        
        mapView.addSubview(nowLocationBtn)
        mapView.addSubview(minusBtn)
        mapView.addSubview(plusBtn)
        mapView.addSubview(messageBtn)

        addPerson(array: personArray)
        mapView.delegate = self
        setupConstraints()
    }
    
    private func addPerson(array: [Person]) {
        for person in array {
            person.image = person.newImage
            mapView.addAnnotation(person)
        }
    }
    
    @objc private func plusBtnTapped() {
        var region = mapView.region
            region.span.latitudeDelta /= 2.0
            region.span.longitudeDelta /= 2.0
            mapView.setRegion(region, animated: true)
    }
    
    @objc private func minusBtnTapped() {
        var region = mapView.region
            region.span.latitudeDelta *= 2.0
            region.span.longitudeDelta *= 2.0
            mapView.setRegion(region, animated: true)
    }
    
    @objc private func locationBtnTapped() {
        mapView.centerToLocation(initialLocation)
    }
}


extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
           center: location.coordinate,
           latitudinalMeters: regionRadius,
           longitudinalMeters: regionRadius)
           setRegion(coordinateRegion, animated: true)
    }
}

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Person"
        var view: MKAnnotationView
        
        if annotation is NowLocationAnnotation {
            view = MKAnnotationView(
                annotation: annotation,
                reuseIdentifier: "NowLocation")
            view.image = UIImage(named: "nowLocation")
            return view
        }
        
        guard let annotation = annotation as? Person else {
            return nil
        }
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier) {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier)
            let firstImage = UIImage(named: "mark")
            let secondImage = annotation.newImage
            let newImage = firstImage?.createImage(image: secondImage)
            view.image = newImage
            view.canShowCallout = true
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? Person else { return }
        showCustomInfoView(person: annotation)
    }
    
    private func showCustomInfoView(person: Person) {
        let detailVC = DetailViewController()
        detailVC.person = person
        let customInfoView = detailVC.view ?? UIView()
        mapView.addSubview(customInfoView)
        customInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customInfoView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            customInfoView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            customInfoView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor),
            customInfoView.heightAnchor.constraint(equalTo: mapView.heightAnchor, multiplier: 0.2)
        ])
    }
}

