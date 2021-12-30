//
//  Marker.swift
//  findT
//
//  Created by 장은석 on 2021/12/29.
//

import Foundation
import MapKit

class Marker: NSObject, MKAnnotation {
  let title: String?
  let coordinate: CLLocationCoordinate2D
  let subtitle: String?
  let pinTintColor: UIColor

  init(
    title: String?,
    subtitle: String?,
    coordinate: CLLocationCoordinate2D,
    pinTintColor: UIColor
  ) {
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate
    self.pinTintColor = pinTintColor
      
    super.init()
  }

}
