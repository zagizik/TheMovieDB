import Foundation

protocol NetworkServiceProtocol {
    func getTopRated(complition: @escaping (Result<[Movie]?, Error>) -> Void)
    func fetchImage(from imagePath: String?, completion: @escaping (Result<Data?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getTopRated(complition: @escaping (Result<[Movie]?, Error>) -> Void) {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.themoviedb.org"
        urlConstructor.path = "/3/movie/top_rated"
        urlConstructor.queryItems = [URLQueryItem(name: "api_key", value: "a77fcc7c6a3a934746427df05b2abd6c")]

        guard let url = urlConstructor.url else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complition(.failure(error))
                return
            }

            do {
                let movies = try JSONDecoder().decode(Movies.self, from: data!)
                let result = movies.results
                complition(.success(result))

            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
    
    func fetchImage(from imagePath: String?, completion: @escaping (Result<Data?, Error>) -> Void ) {
        let session = URLSession.shared
        guard let imagePath = imagePath else { return }
        let url = URL(string: "https://www.themoviedb.org/t/p/w440_and_h660_face/" + imagePath)
            
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            } else {
                completion(.success(data))
            }
        }
        dataTask.resume()
    }
}
