//
//  MovieDetailsViewController.swift
//  Flixster
//
//  Created by Mo Naqvi on 9/14/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print(movie["title"])
        
        titleLabel.text = movie["title"] as? String
        // Since we haven't configured auto-layout, doing the following, after we set the text, we grow the label:
        titleLabel.sizeToFit()
    
        synopsisLabel.text = movie["overview"] as? String
        // Since we haven't configured auto-layout, doing the following, after we set the text, we grow the label:
        synopsisLabel.sizeToFit()
        
    
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        
        // Poster image in the details view
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        posterView.af.setImage(withURL: posterUrl!)
        
        // Backdrop image in details view
        let backdropPath = movie["backdrop_path"] as! String
        // Too blurry - use code below
        //let backdropUrl = URL(string: baseUrl + backdropPath)
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        backdropView.af.setImage(withURL: backdropUrl!)
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
