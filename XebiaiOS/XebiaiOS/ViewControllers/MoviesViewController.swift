//
//  MoviesViewController.swift
//  XebiaiOS
//
//  Created by Yagnyadatta Bairiganjan on 19/01/21.
//

import UIKit


class MoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieCollection: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var daySinceRelease: UILabel!
}


class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let spinner = UIActivityIndicatorView(style: .large)
    @IBOutlet weak var movieTable: UITableView!
    
    let manager = MovieManager()
    var movies = [Movies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieTable.delegate = self
        self.movieTable.dataSource = self
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Top movies this year!"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshMovieData))
        refreshMovieData()
    }
    
    @objc func refreshMovieData(){
        movies.removeAll()
        self.startSpinner()
        let movieService = MovieService()
        movieService.fetchMovieDataFromService(completion: {
               movies in
               for movie in movies{
                   self.movies.append(movie)
                DispatchQueue.main.async {
                    self.stopSpinner()
                    self.movieTable.reloadData()
                }
                
               }
           })
       }
       
       
       // MARK: - Table view data source
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return self.movies.count
       }

       
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MoviesTableViewCell
           self.updateTableContent(indexPath, cell)
           return cell
       }
       
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            MovieManager.sharedManager.selectedMovie = self.movies[indexPath.row]
            self.performSegue(withIdentifier: "movieDetailsVC", sender: nil)
           
       }
        open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return CGFloat(manager.rowHeight)
        }
    
    
       private func updateTableContent(_ indexPath: IndexPath, _ cell: MoviesTableViewCell){
           do{
            let imageData = try Data(contentsOf: URL(string: self.movies[indexPath.row].posterImageUrl!)!)
            cell.moviePoster.image = UIImage(data: imageData)
            cell.movieName.text = "\(self.movies[indexPath.row].movieName ?? "")"
            cell.movieCollection.text = "Collection in RS: \( self.movies[indexPath.row].collection ?? "")"
            cell.releaseDate.text = "Released on: \( self.movies[indexPath.row].releaseDate ?? "")"
               cell.daySinceRelease.text = "Day since release: \(String(self.movies[indexPath.row].daysSinceRelease!)) days"
           }catch{
              print(error)
           }
           
       }
    
    func startSpinner(){
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        self.view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func stopSpinner(){
        spinner.stopAnimating()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
