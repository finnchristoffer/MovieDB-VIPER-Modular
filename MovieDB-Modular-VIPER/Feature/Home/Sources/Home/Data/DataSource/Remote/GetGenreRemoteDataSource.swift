//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 22/08/23.
//

import Alamofire
import Common
import Core
import RxSwift

public struct GetListGenreMovieRemoteDataSource: RemoteDataSource {
  public typealias Request = Any
  public typealias Response = [GenreModel]
  
  public func execute(request: Any?) -> Observable<[GenreModel]> {
    return Observable.create { observer in
      let request = AF.request(Endpoints.Get.genre.url)
        .validate()
        .responseDecodable(of: GenreResponse.self) { response in
          switch response.result {
          case .success(let genreResponse):
            observer.onNext(genreResponse.genres ?? [])
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
