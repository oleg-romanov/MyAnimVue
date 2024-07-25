//
//  ProfileInteractor.swift
//  MyAnimVue
//
//  Created by Олег Романов on 05.07.2024.
//

import Foundation

final class ProfileInteractor: ProfileBusinessLogic {
    
    // MARK: Instance Properties
    
    weak var presenter: ProfilePresentationLogic!
    
    private let networkService: APIClient
    private var userId: Int?
    
    init() {
        self.networkService = APIClient(baseURL: URL(string: APIConstants.hostShikimori))
    }
    
    // MARK: Instance Methods
    
    func fetchTitlesInfo() async {
        if userId == nil {
            do {
                let userShiki: UserShiki = try await networkService.send(Request(path: "/users/whoami")).value
                userId = userShiki.id
            } catch {
                presenter.presentError(with: error.localizedDescription)
                return
            }
        }
        
        do {
            guard let userId = userId else { return }
            let animeRateShiki: [AnimeRateShiki] = try await networkService.send(Request(path: "/users/\(userId)/anime_rates", query: ["limit":"5000"])).value
            var titles = [[PreviewTitleModel]]()
            
            var plannedArr: [PreviewTitleModel] = []
            var watchingArr: [PreviewTitleModel] = []
            var rewatchingArr: [PreviewTitleModel] = []
            var completedArr: [PreviewTitleModel] = []
            var onHoldArr: [PreviewTitleModel] = []
            var droppedArr: [PreviewTitleModel] = []
            
            animeRateShiki.forEach({ item in
                
                switch item.status {
                    case "planned":
                        plannedArr.append(createPreviewTitleModel(item: item, blockName: .planned))
                    case "watching":
                        watchingArr.append(createPreviewTitleModel(item: item, blockName: .watching))
                    case "rewatching":
                        rewatchingArr.append(createPreviewTitleModel(item: item, blockName: .rewatching))
                    case "completed":
                        completedArr.append(createPreviewTitleModel(item: item, blockName: .completed))
                    case "on_hold":
                        onHoldArr.append(createPreviewTitleModel(item: item, blockName: .onHold))
                    case "dropped":
                        droppedArr.append(createPreviewTitleModel(item: item, blockName: .dropped))
                    default:
                        break
                }
            })
            
            appendNotEmptyArrTo(source: &titles, element: &watchingArr)
            appendNotEmptyArrTo(source: &titles, element: &plannedArr)
            appendNotEmptyArrTo(source: &titles, element: &rewatchingArr)
            appendNotEmptyArrTo(source: &titles, element: &completedArr)
            appendNotEmptyArrTo(source: &titles, element: &onHoldArr)
            appendNotEmptyArrTo(source: &titles, element: &droppedArr)
            
            presenter.presentTitlesInfo(with: titles)
            
        } catch {
            presenter.presentError(with: error.localizedDescription)
        }
    }
    
    private func createPreviewTitleModel(item: AnimeRateShiki, blockName: BlockName) -> PreviewTitleModel {
        return PreviewTitleModel(
            blockName: blockName.rawValue,
            posterImageString: item.anime.image.preview,
            russianTitleName: item.anime.russian,
            englishTitleName: item.anime.name,
            episodesTotal: item.anime.episodes,
            episodesWathed: item.episodes,
            rating: Double(item.anime.score) ?? 0
        )
    }
    
    private func appendNotEmptyArrTo(source array: inout [[PreviewTitleModel]], element: inout [PreviewTitleModel]) {
        if !element.isEmpty {
            array.append(element)
        }
    }
}
