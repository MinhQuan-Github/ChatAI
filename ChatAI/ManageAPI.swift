//
//  ManageAPI.swift
//  ChatAI
//
//  Created by Minh Quan on 16/12/2022.
//

import Foundation
import OpenAISwift

final class ManageAPI {
    static let shared = ManageAPI()
    private var client: OpenAISwift?
    
    @frozen enum Constants {
        static let key = "<Your API key>"
    }
    
    private init() {}
    
    public func setup() {
        self.client = OpenAISwift(authToken: Constants.key)
    }
    
    public func getResponse(input: String, completion: @escaping (Result<String, Error>) -> Void) {
        client?.sendCompletion(with: input, completionHandler: { result in
            switch result {
            case.success(let model):
                let output = model.choices.first?.text ?? ""
                completion(.success(output))
            case.failure(let error):
                completion(.failure(error))
            }
        })
    }
}
