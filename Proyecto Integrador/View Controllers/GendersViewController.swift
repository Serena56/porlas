//
//  GendersViewController.swift
//  Proyecto Integrador
//
//  Created by Digital House on 19/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit

class GendersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
   
    
    
    @IBAction func clearFilters(_ sender: Any) {
        
        if self.estado == "Movies"{
            self.movieDelegate?.deleteFilter()
            self.navigationController?.popViewController(animated: true)
        }
        
        if self.estado == "Series"{
            self.serieDelegate?.deleteFilter()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    var movieGenders:[Gender] = []
    var serieGenders:[Gender] = []
    var estado:String = ""
    var movieDelegate:MainPeliculaTableViewController?
    var serieDelegate:MainSerieTableViewController?
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.estado == "Movies" {
            return self.movieGenders.count
        } else{
            return self.serieGenders.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "genderCell", for: indexPath)
        
        
        if let celdaSeleccionada = cell as? GendersTableViewCell {

            
            if self.estado == "Movies" {
                celdaSeleccionada.resultado = self.movieGenders[indexPath.row]
                celdaSeleccionada.setup()
            }
            
            if self.estado == "Series"{
                celdaSeleccionada.resultado = self.serieGenders[indexPath.row]
                celdaSeleccionada.setup()
            }
            
        }
        
        
        return cell
    }
    

    @IBOutlet weak var movieSerieSegmented: UISegmentedControl!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.delegate = self 
        self.mainTableView.dataSource = self
        self.mainTableView.rowHeight = 200
        getGenders()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getGenders(){
       
        
        if self.estado == "Movies"{
            let service = MovieService()
            service.getGenders(){(genders) in
                self.movieGenders = genders
                self.mainTableView.reloadData()
            }
            
        }
            
            if self.estado == "Series"{
                let service = SerieService()
                service.getGenders(){(genders) in
                    self.serieGenders = genders
                    self.mainTableView.reloadData()
                }
            }
        
    }
    
        
        func tableView(_ tableView: UITableView,
                       didSelectRowAt indexPath: IndexPath){
            
            if self.estado == "Movies"{
                let genderSelected = self.movieGenders[indexPath.row]
                let service = MovieService()
                service.getMoviesForGender(gender: genderSelected){ (movies) in
                    if let delegate = self.movieDelegate{
                        delegate.applyFilter(newArray: movies)
                        self.navigationController?.popViewController(animated: true)
                        
                        }
                    }
            
                }
            
            if estado == "Series"{
                let genderSelected = self.serieGenders[indexPath.row]
                let service = SerieService()
                service.getSeriesForGenre(genre: genderSelected){ (series) in
                    
                    if let delegate = self.serieDelegate{
                    delegate.applyFilter(newArray: series)
                    self.navigationController?.popViewController(animated: true)
                }
             }
            }
        }
    }







    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


