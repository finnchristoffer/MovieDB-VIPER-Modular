//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 25/08/23.
//

import Alamofire
import RxSwift
import RxCocoa
import Core
import Common

public struct GetTrailerVideoDataSource: RemoteDataSource {
  public typealias Request = Int
  public typealias Response = [VideoModel]
  
  public func execute(request: Int?) -> Observable<[VideoModel]> {
    return Observable.create { observer in
      let request = AF.request(Endpoints.Get.movieTrailer(movieId: request!).url)
        .validate()
        .responseDecodable(of: VideoResponseModel.self) { response in
          switch response.result {
          case .success(let videoResponse):
            observer.onNext(videoResponse.results ?? [])
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
