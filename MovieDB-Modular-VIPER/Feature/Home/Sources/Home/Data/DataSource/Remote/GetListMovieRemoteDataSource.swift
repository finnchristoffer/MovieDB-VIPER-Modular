//
//  GetListMovieRemoteDataSource.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 23/08/23.
//

import Alamofire
import Common
import Core
import RxSwift

public struct GetListMovieRemoteDataSource: RemoteDataSource {
  public typealias Request = Int
  public typealias Response = MovieResponseModel
  
  public func execute(request: Int?) -> Observable<MovieResponseModel> {
    return Observable.create { observer in
      let request = AF.request(Endpoints.Get.listMovie(genre: request!).url)
        .validate()
        .responseDecodable(of: MovieResponseModel.self) { response in
          switch response.result {
          case .success(let movieResponse):
            observer.onNext(movieResponse)
            observer.onCompleted()
          case .failure(_):
            observer.onError(URLError.invalidResponse)
          }
        }
      return Disposables.create {
        request.cancel()
      }
    }
  }
}
