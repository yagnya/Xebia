//
//  MovieDetailsViewController.swift
//  XebiaiOS
//
//  Created by Yagnyadatta Bairiganjan on 19/01/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieposter: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var collection: UILabel!
    @IBOutlet weak var releaseSinceDate: UILabel!
    @IBOutlet weak var movieDesc: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = MovieManager.sharedManager.selectedMovie?.movieName
        updateDataOnScreen()
        // Do any additional setup after loading the view.
    }
    
    private func updateDataOnScreen(){
        do{
         let imageData = try Data(contentsOf: URL(string: MovieManager.sharedManager.selectedMovie?.posterImageUrl ?? "No data")!)
         self.movieposter.image = UIImage(data: imageData)
         self.collection.text = "Collection in Rs: \( MovieManager.sharedManager.selectedMovie?.collection ?? "No data")"
         self.releaseDate.text = "Released on: \( MovieManager.sharedManager.selectedMovie?.releaseDate ?? "No data")"
         self.releaseSinceDate.text = "Day since release: \(String((MovieManager.sharedManager.selectedMovie?.daysSinceRelease)!) ) days"
         self.movieDesc.text = MovieManager.sharedManager.selectedMovie?.description ?? "No data"
        }catch{
           fatalError("")
        }
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
