//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 26/08/23.
//

import Alamofire
import RxSwift
import RxCocoa
import Core
import Common

public struct GetReviewMovieDataSource: RemoteDataSource {
  public typealias Request = Int
  public typealias Response = [ReviewModel]
  
  public func execute(request: Int?) -> Observable<[ReviewModel]> {
    return Observable.create { observer in
      let request = AF.request(Endpoints.Get.review(movieId: request!).url)
        .validate()
        .responseDecodable(of: ReviewResponseModel.self) { response in
          switch response.result {
          case .success(let reviewResponse):
            observer.onNext(reviewResponse.results ?? [])
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
