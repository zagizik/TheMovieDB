import UIKit

protocol NetworkServiceProtocol {
    func getMovieList(list: movieList, page: Int, complition: @escaping (Result<[Movie]?, Error>) -> Void)
    func downloadImage(urlString: String, completion: @escaping (Result<UIImage?, Error>) -> Void)}

class NetworkService: NetworkServiceProtocol {
    func getMovieList(list: movieList, page: Int = 0 ,complition: @escaping (Result<[Movie]?, Error>) -> Void) {
        let pageString = String(page)
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.themoviedb.org"
        urlConstructor.path = "/3/movie/\(list.rawValue)"
        urlConstructor.queryItems = [URLQueryItem(name: "api_key", value: "a77fcc7c6a3a934746427df05b2abd6c"),
                                     URLQueryItem(name: "language", value: "ru-RU")]
        
        if pageString != "0" {
            urlConstructor.queryItems?.append(URLQueryItem(name: "page", value: pageString))
        }
        
        
        guard let url = urlConstructor.url else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complition(.failure(error))
                return
            }
            
            do {
                let movies = try JSONDecoder().decode(Movies.self, from: data!)
                guard let result = movies.results else{ return }
                complition(.success(result))
                
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
    
    var imageCache = NSCache<NSString, UIImage>()
    
    func downloadImage(urlString: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(.success(cachedImage))
        } else {
            guard let url = URL(string: "https://www.themoviedb.org/t/p/w440_and_h660_face/" + urlString) else { return }
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                
                guard error == nil,
                      data != nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let `self` = self else { completion(.failure(error!)); return }
                
                guard let image = UIImage(data: data!) else { return }
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            }
            dataTask.resume()
        }
    }
}

extension UIImageView {

    func load(from imagePath: String?) {
        guard let imagePath = imagePath else { return }
        let url = URL(string: "https://www.themoviedb.org/t/p/w440_and_h660_face/" + imagePath)
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
