//
//  MovieGridViewController.swift
//  Flixster
//
//  Created by Mo Naqvi on 9/16/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    // Create outlet for collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // For each view controller
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Optimizing layout and configuring
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        // space between images on each row. This will wrap them into 1 column which is why you need layout.itemSize
        layout.minimumInteritemSpacing = 4
        // Get width of phone and place 3 posters
        // But we dont have the full width to work with, we have to account for spacing between posters which is 2 (or n-1, where n
        // is the number of posters)
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        // maintain a aspect ratio
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        
        
        // Send request to network for similar movies
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                // After network call success, collectionView needs to reload the data bc of movies count udpate
                // This will call the functions below again
                self.collectionView.reloadData()
                
                print(self.movies)
                    

             }
        }
        task.resume()
    }
    
    // Placing functions below
    // Dont have the data yet, so include 'self.collectionView.reloadData()' up top 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    // Return a verison of the cell and cast
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"MovieGridCell", for: indexPath) as! MovieGridCell
        
        // Configuration
        // Dont have row or table cell, they have item instead
        let movie = movies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        return cell
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
