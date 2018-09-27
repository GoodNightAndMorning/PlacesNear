//
//  PNHomeViewController.swift
//  PlacesNear
//
//  Created by apple on 2018/9/27.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNHomeViewController: UIViewController {
    
    var _mapView:BMKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.orange
        
        _mapView = BMKMapView(frame: self.view.bounds)
        self.view .addSubview(_mapView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
