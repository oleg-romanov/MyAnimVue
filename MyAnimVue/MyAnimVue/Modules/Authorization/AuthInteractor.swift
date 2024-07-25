//
//  AuthInteractor.swift
//  MyAnimVue
//
//  Created by Олег Романов on 03.07.2024.
//

import Foundation

final class AuthInteractor: AuthBusinessLogic {
    
    // MARK: Instance Properties
    
    weak var presenter: AuthPresentationLogic!
    
    private var anilibriaWasCalled: Bool = false
    private var shikimoriWasCalled: Bool = false
    
    private var loggedInToAnilibria: Bool = false
    private var loggedInToShikimori: Bool = false
    
    private var query = [String : String]()
    
    private let networkService: APIClient
    
    init() {
        self.networkService = APIClient(baseURL: URL(string: "https://shikimori.one/oauth"))
    }
    
    // MARK: Instance Methods
    
    func setAnilibriaWasCalled() {
        anilibriaWasCalled = true
    }
    
    func setShikimoriWasCalled() {
        shikimoriWasCalled = true
    }
    
    func processResult(isSuccess: Bool) {
        if (isSuccess) {
            if (anilibriaWasCalled) {
                loggedInToAnilibria = true
                presenter.presentCheckmarkAnilibriaCircleView()
            }
            if (shikimoriWasCalled) {
                loggedInToShikimori = true
                presenter.presentCheckmarkShikimoriCircleView()
            }
        }
        anilibriaWasCalled = false
        shikimoriWasCalled = false
        
#warning("Временно оставляю только shikimori, вернуть как было когда появится фнукицонал с anilibria")
        //        if (loggedInToAnilibria && loggedInToShikimori) {
        //            presenter.presentStartButtonActiveState()
        //        }
        
        if (loggedInToShikimori) {
            let authCode = Keychain.service.getShikimoriAuthCode()
            let clientId = APIConstants.obtainClientId()
            let clientSecret = APIConstants.obtainClientSecret()
            query["grant_type"] = "authorization_code"
            query["client_id"] = clientId
            query["client_secret"] = clientSecret
            query["code"] = authCode
            query["redirect_uri"] = "urn:ietf:wg:oauth:2.0:oob"
            Task {
                do {
                    let tokenResponse: TokenResponse = try await networkService.send(Request(path: "/token", method: .post, query: query)).value
                    Keychain.service.saveShikimoriTokens(accessToken: tokenResponse.accessToken, refreshToken: tokenResponse.refreshToken)
                    
                    presenter.presentStartButtonActiveState()
                } catch {
                    presenter.presentError(with: error.localizedDescription)
                    return
                }
            }
        }
    }
    
    func startButtonDidPress(isActive: Bool) {
        if isActive {
            presenter.routeToTabbar()
        }
    }
}
