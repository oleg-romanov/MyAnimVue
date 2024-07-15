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
    
    // MARK: Instance Methods
    
    func fetchTitlesInfo() {
        let data = generateMockData()
        
        let result = try? JSONDecoder().decode([AnimeRateShiki].self, from: data)
        
        var titles = [[PreviewTitleModel]]()
        
        var plannedArr: [PreviewTitleModel] = []
        var watchingArr: [PreviewTitleModel] = []
        var rewatchingArr: [PreviewTitleModel] = []
        var completedArr: [PreviewTitleModel] = []
        var onHoldArr: [PreviewTitleModel] = []
        var droppedArr: [PreviewTitleModel] = []
        
        result?.forEach({ item in
            
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
    
    private func generateMockData() -> Data {
        guard let data = """
        [{"id":164138028,"score":0,"status":"watching","text":null,"episodes":10,"chapters":0,"volumes":0,"text_html":"","rewatches":0,"created_at":"2024-01-09T23:35:14.151+03:00","updated_at":"2024-01-29T13:47:00.367+03:00","user":{"id":1380904,"nickname":"Heliagrotor","avatar":"https://desu.shikimori.one/system/users/x48/1380904.png?1697830845","image":{"x160":"https://desu.shikimori.one/system/users/x160/1380904.png?1697830845","x148":"https://desu.shikimori.one/system/users/x148/1380904.png?1697830845","x80":"https://desu.shikimori.one/system/users/x80/1380904.png?1697830845","x64":"https://desu.shikimori.one/system/users/x64/1380904.png?1697830845","x48":"https://desu.shikimori.one/system/users/x48/1380904.png?1697830845","x32":"https://desu.shikimori.one/system/users/x32/1380904.png?1697830845","x16":"https://desu.shikimori.one/system/users/x16/1380904.png?1697830845"},"last_online_at":"2024-07-07T15:58:06.947+03:00","url":"https://shikimori.one/Heliagrotor"},"anime":{"id":15809,"name":"Hataraku Maou-sama!","russian":"Повелитель тьмы на подработке!","image":{"original":"/system/animes/original/15809.jpg?1711952944","preview":"/system/animes/preview/15809.jpg?1711952944","x96":"/system/animes/x96/15809.jpg?1711952944","x48":"/system/animes/x48/15809.jpg?1711952944"},"url":"/animes/15809-hataraku-maou-sama","kind":"tv","score":"7.73","status":"released","episodes":13,"episodes_aired":13,"aired_on":"2013-04-04","released_on":"2013-06-27"},"manga":null},{"id":161514327,"score":0,"status":"watching","text":null,"episodes":1,"chapters":null,"volumes":null,"text_html":"","rewatches":0,"created_at":"2023-12-02T22:56:31.743+03:00","updated_at":"2023-12-15T14:44:27.125+03:00","user":{"id":1380904,"nickname":"Heliagrotor","avatar":"https://desu.shikimori.one/system/users/x48/1380904.png?1697830845","image":{"x160":"https://desu.shikimori.one/system/users/x160/1380904.png?1697830845","x148":"https://desu.shikimori.one/system/users/x148/1380904.png?1697830845","x80":"https://desu.shikimori.one/system/users/x80/1380904.png?1697830845","x64":"https://desu.shikimori.one/system/users/x64/1380904.png?1697830845","x48":"https://desu.shikimori.one/system/users/x48/1380904.png?1697830845","x32":"https://desu.shikimori.one/system/users/x32/1380904.png?1697830845","x16":"https://desu.shikimori.one/system/users/x16/1380904.png?1697830845"},"last_online_at":"2024-07-07T15:58:06.947+03:00","url":"https://shikimori.one/Heliagrotor"},"anime":{"id":37932,"name":"Quanzhi Gaoshou 2","russian":"Аватар короля 2","image":{"original":"/system/animes/original/37932.jpg?1711969844","preview":"/system/animes/preview/37932.jpg?1711969844","x96":"/system/animes/x96/37932.jpg?1711969844","x48":"/system/animes/x48/37932.jpg?1711969844"},"url":"/animes/37932-quanzhi-gaoshou-2","kind":"ona","score":"7.88","status":"released","episodes":12,"episodes_aired":12,"aired_on":"2020-09-25","released_on":"2020-12-04"},"manga":null},{"id":159085744,"score":0,"status":"watching","text":null,"episodes":3,"chapters":null,"volumes":null,"text_html":"","rewatches":0,"created_at":"2023-10-24T13:02:05.038+03:00","updated_at":"2023-11-25T20:40:17.005+03:00","user":{"id":1380904,"nickname":"Heliagrotor","avatar":"https://desu.shikimori.one/system/users/x48/1380904.png?1697830845","image":{"x160":"https://desu.shikimori.one/system/users/x160/1380904.png?1697830845","x148":"https://desu.shikimori.one/system/users/x148/1380904.png?1697830845","x80":"https://desu.shikimori.one/system/users/x80/1380904.png?1697830845","x64":"https://desu.shikimori.one/system/users/x64/1380904.png?1697830845","x48":"https://desu.shikimori.one/system/users/x48/1380904.png?1697830845","x32":"https://desu.shikimori.one/system/users/x32/1380904.png?1697830845","x16":"https://desu.shikimori.one/system/users/x16/1380904.png?1697830845"},"last_online_at":"2024-07-07T15:58:06.947+03:00","url":"https://shikimori.one/Heliagrotor"},"anime":{"id":46569,"name":"Jigokuraku","russian":"Адский рай","image":{"original":"/system/animes/original/46569.jpg?1711955691","preview":"/system/animes/preview/46569.jpg?1711955691","x96":"/system/animes/x96/46569.jpg?1711955691","x48":"/system/animes/x48/46569.jpg?1711955691"},"url":"/animes/46569-jigokuraku","kind":"tv","score":"8.11","status":"released","episodes":13,"episodes_aired":13,"aired_on":"2023-04-01","released_on":"2023-07-01"},"manga":null},{"id":159678001,"score":0,"status":"watching","text":null,"episodes":8,"chapters":null,"volumes":null,"text_html":"","rewatches":0,"created_at":"2023-11-05T19:55:40.703+03:00","updated_at":"2024-01-16T16:45:38.941+03:00","user":{"id":1380904,"nickname":"Heliagrotor","avatar":"https://desu.shikimori.one/system/users/x48/1380904.png?1697830845","image":{"x160":"https://desu.shikimori.one/system/users/x160/1380904.png?1697830845","x148":"https://desu.shikimori.one/system/users/x148/1380904.png?1697830845","x80":"https://desu.shikimori.one/system/users/x80/1380904.png?1697830845","x64":"https://desu.shikimori.one/system/users/x64/1380904.png?1697830845","x48":"https://desu.shikimori.one/system/users/x48/1380904.png?1697830845","x32":"https://desu.shikimori.one/system/users/x32/1380904.png?1697830845","x16":"https://desu.shikimori.one/system/users/x16/1380904.png?1697830845"},"last_online_at":"2024-07-07T15:58:06.947+03:00","url":"https://shikimori.one/Heliagrotor"},"anime":{"id":48761,"name":"Saihate no Paladin","russian":"Далёкий паладин","image":{"original":"/system/animes/original/48761.jpg?1708760701","preview":"/system/animes/preview/48761.jpg?1708760701","x96":"/system/animes/x96/48761.jpg?1708760701","x48":"/system/animes/x48/48761.jpg?1708760701"},"url":"/animes/48761-saihate-no-paladin","kind":"tv","score":"6.86","status":"released","episodes":12,"episodes_aired":12,"aired_on":"2021-10-09","released_on":"2022-01-03"},"manga":null},{"id":160056702,"score":0,"status":"watching","text":null,"episodes":2,"chapters":0,"volumes":0,"text_html":"","rewatches":0,"created_at":"2023-11-12T16:56:07.679+03:00","updated_at":"2024-04-16T12:59:11.176+03:00","user":{"id":1380904,"nickname":"Heliagrotor","avatar":"https://desu.shikimori.one/system/users/x48/1380904.png?1697830845","image":{"x160":"https://desu.shikimori.one/system/users/x160/1380904.png?1697830845","x148":"https://desu.shikimori.one/system/users/x148/1380904.png?1697830845","x80":"https://desu.shikimori.one/system/users/x80/1380904.png?1697830845","x64":"https://desu.shikimori.one/system/users/x64/1380904.png?1697830845","x48":"https://desu.shikimori.one/system/users/x48/1380904.png?1697830845","x32":"https://desu.shikimori.one/system/users/x32/1380904.png?1697830845","x16":"https://desu.shikimori.one/system/users/x16/1380904.png?1697830845"},"last_online_at":"2024-07-07T15:58:06.947+03:00","url":"https://shikimori.one/Heliagrotor"},"anime":{"id":56923,"name":"Lv2 kara Cheat datta Motoyuusha Kouho no Mattari Isekai Life","russian":"Непринуждённая жизнь в другом мире экс-кандидата в герои, оказавшегося читером со второго уровня","image":{"original":"/system/animes/original/56923.jpg?1718686012","preview":"/system/animes/preview/56923.jpg?1718686012","x96":"/system/animes/x96/56923.jpg?1718686012","x48":"/system/animes/x48/56923.jpg?1718686012"},"url":"/animes/56923-lv2-kara-cheat-datta-motoyuusha-kouho-no-mattari-isekai-life","kind":"tv","score":"6.83","status":"released","episodes":12,"episodes_aired":12,"aired_on":"2024-04-08","released_on":"2024-06-24"},"manga":null},{"id":160219046,"score":0,"status":"watching","text":null,"episodes":0,"chapters":null,"volumes":null,"text_html":"","rewatches":0,"created_at":"2023-11-15T00:09:40.828+03:00","updated_at":"2024-04-04T13:10:58.536+03:00","user":{"id":1380904,"nickname":"Heliagrotor","avatar":"https://desu.shikimori.one/system/users/x48/1380904.png?1697830845","image":{"x160":"https://desu.shikimori.one/system/users/x160/1380904.png?1697830845","x148":"https://desu.shikimori.one/system/users/x148/1380904.png?1697830845","x80":"https://desu.shikimori.one/system/users/x80/1380904.png?1697830845","x64":"https://desu.shikimori.one/system/users/x64/1380904.png?1697830845","x48":"https://desu.shikimori.one/system/users/x48/1380904.png?1697830845","x32":"https://desu.shikimori.one/system/users/x32/1380904.png?1697830845","x16":"https://desu.shikimori.one/system/users/x16/1380904.png?1697830845"},"last_online_at":"2024-07-07T15:58:06.947+03:00","url":"https://shikimori.one/Heliagrotor"},"anime":{"id":30276,"name":"One Punch Man","russian":"Ванпанчмен","image":{"original":"/system/animes/original/30276.jpg?1711967568","preview":"/system/animes/preview/30276.jpg?1711967568","x96":"/system/animes/x96/30276.jpg?1711967568","x48":"/system/animes/x48/30276.jpg?1711967568"},"url":"/animes/z30276-one-punch-man","kind":"tv","score":"8.5","status":"released","episodes":12,"episodes_aired":12,"aired_on":"2015-10-05","released_on":"2015-12-21"},"manga":null},{"id":166340815,"score":0,"status":"watching","text":null,"episodes":8,"chapters":null,"volumes":null,"text_html":"","rewatches":0,"created_at":"2024-02-05T21:28:20.106+03:00","updated_at":"2024-02-21T22:13:49.893+03:00","user":{"id":1380904,"nickname":"Heliagrotor","avatar":"https://desu.shikimori.one/system/users/x48/1380904.png?1697830845","image":{"x160":"https://desu.shikimori.one/system/users/x160/1380904.png?1697830845","x148":"https://desu.shikimori.one/system/users/x148/1380904.png?1697830845","x80":"https://desu.shikimori.one/system/users/x80/1380904.png?1697830845","x64":"https://desu.shikimori.one/system/users/x64/1380904.png?1697830845","x48":"https://desu.shikimori.one/system/users/x48/1380904.png?1697830845","x32":"https://desu.shikimori.one/system/users/x32/1380904.png?1697830845","x16":"https://desu.shikimori.one/system/users/x16/1380904.png?1697830845"},"last_online_at":"2024-07-07T15:58:06.947+03:00","url":"https://shikimori.one/Heliagrotor"},"anime":{"id":49220,"name":"Isekai Ojisan","russian":"Перерождение Дяди","image":{"original":"/system/animes/original/49220.jpg?1703475899","preview":"/system/animes/preview/49220.jpg?1703475899","x96":"/system/animes/x96/49220.jpg?1703475899","x48":"/system/animes/x48/49220.jpg?1703475899"},"url":"/animes/49220-isekai-ojisan","kind":"tv","score":"7.8","status":"released","episodes":13,"episodes_aired":12,"aired_on":"2022-07-06","released_on":"2023-03-08"},"manga":null},
            {
                    "id": 164138028,
                    "score": 0,
                    "status": "rewatching",
                    "text": null,
                    "episodes": 10,
                    "chapters": 0,
                    "volumes": 0,
                    "text_html": "",
                    "rewatches": 0,
                    "created_at": "2024-01-09T23:35:14.151+03:00",
                    "updated_at": "2024-01-29T13:47:00.367+03:00",
                    "user": {
                        "id": 1380904,
                        "nickname": "Heliagrotor",
                        "avatar": "https://desu.shikimori.one/system/users/x48/1380904.png?1697830845",
                        "image": {
                            "x160": "https://desu.shikimori.one/system/users/x160/1380904.png?1697830845",
                            "x148": "https://desu.shikimori.one/system/users/x148/1380904.png?1697830845",
                            "x80": "https://desu.shikimori.one/system/users/x80/1380904.png?1697830845",
                            "x64": "https://desu.shikimori.one/system/users/x64/1380904.png?1697830845",
                            "x48": "https://desu.shikimori.one/system/users/x48/1380904.png?1697830845",
                            "x32": "https://desu.shikimori.one/system/users/x32/1380904.png?1697830845",
                            "x16": "https://desu.shikimori.one/system/users/x16/1380904.png?1697830845"
                        },
                        "last_online_at": "2024-07-07T15:58:06.947+03:00",
                        "url": "https://shikimori.one/Heliagrotor"
                    },
                    "anime": {
                        "id": 15809,
                        "name": "Hataraku Maou-sama!",
                        "russian": "Пfdffddfdfdffdfdfddffdаботке!",
                        "image": {
                            "original": "/system/animes/original/15809.jpg?1711952944",
                            "preview": "/system/animes/preview/15809.jpg?1711952944",
                            "x96": "/system/animes/x96/15809.jpg?1711952944",
                            "x48": "/system/animes/x48/15809.jpg?1711952944"
                        },
                        "url": "/animes/15809-hataraku-maou-sama",
                        "kind": "tv",
                        "score": "7.73",
                        "status": "released",
                        "episodes": 13,
                        "episodes_aired": 13,
                        "aired_on": "2013-04-04",
                        "released_on": "2013-06-27"
                    },
                    "manga": null
                },
            {
                    "id": 164138029,
                    "score": 0,
                    "status": "rewatching",
                    "text": null,
                    "episodes": 5,
                    "chapters": 0,
                    "volumes": 0,
                    "text_html": "",
                    "rewatches": 0,
                    "created_at": "2024-01-09T23:35:14.151+03:00",
                    "updated_at": "2024-01-29T13:47:00.367+03:00",
                    "user": {
                        "id": 1380904,
                        "nickname": "Heliagrotor",
                        "avatar": "https://desu.shikimori.one/system/users/x48/1380904.png?1697830845",
                        "image": {
                            "x160": "https://desu.shikimori.one/system/users/x160/1380904.png?1697830845",
                            "x148": "https://desu.shikimori.one/system/users/x148/1380904.png?1697830845",
                            "x80": "https://desu.shikimori.one/system/users/x80/1380904.png?1697830845",
                            "x64": "https://desu.shikimori.one/system/users/x64/1380904.png?1697830845",
                            "x48": "https://desu.shikimori.one/system/users/x48/1380904.png?1697830845",
                            "x32": "https://desu.shikimori.one/system/users/x32/1380904.png?1697830845",
                            "x16": "https://desu.shikimori.one/system/users/x16/1380904.png?1697830845"
                        },
                        "last_online_at": "2024-07-07T15:58:06.947+03:00",
                        "url": "https://shikimori.one/Heliagrotor"
                    },
                    "anime": {
                        "id": 15809,
                        "name": "Hataraku Maou-sama!",
                        "russian": "1111111222222223333333",
                        "image": {
                            "original": "/system/animes/original/15809.jpg?1711952944",
                            "preview": "/system/animes/preview/15809.jpg?1711952944",
                            "x96": "/system/animes/x96/15809.jpg?1711952944",
                            "x48": "/system/animes/x48/15809.jpg?1711952944"
                        },
                        "url": "/animes/15809-hataraku-maou-sama",
                        "kind": "tv",
                        "score": "7.73",
                        "status": "released",
                        "episodes": 13,
                        "episodes_aired": 13,
                        "aired_on": "2013-04-04",
                        "released_on": "2013-06-27"
                    },
                    "manga": null
                },
                    {
                            "id": 164138028,
                            "score": 0,
                            "status": "completed",
                            "text": null,
                            "episodes": 10,
                            "chapters": 0,
                            "volumes": 0,
                            "text_html": "",
                            "rewatches": 0,
                            "created_at": "2024-01-09T23:35:14.151+03:00",
                            "updated_at": "2024-01-29T13:47:00.367+03:00",
                            "user": {
                                "id": 1380904,
                                "nickname": "Heliagrotor",
                                "avatar": "https://desu.shikimori.one/system/users/x48/1380904.png?1697830845",
                                "image": {
                                    "x160": "https://desu.shikimori.one/system/users/x160/1380904.png?1697830845",
                                    "x148": "https://desu.shikimori.one/system/users/x148/1380904.png?1697830845",
                                    "x80": "https://desu.shikimori.one/system/users/x80/1380904.png?1697830845",
                                    "x64": "https://desu.shikimori.one/system/users/x64/1380904.png?1697830845",
                                    "x48": "https://desu.shikimori.one/system/users/x48/1380904.png?1697830845",
                                    "x32": "https://desu.shikimori.one/system/users/x32/1380904.png?1697830845",
                                    "x16": "https://desu.shikimori.one/system/users/x16/1380904.png?1697830845"
                                },
                                "last_online_at": "2024-07-07T15:58:06.947+03:00",
                                "url": "https://shikimori.one/Heliagrotor"
                            },
                            "anime": {
                                "id": 15809,
                                "name": "Hataraku Maou-sama!",
                                "russian": "aaaaaaaaaaaaa!",
                                "image": {
                                    "original": "/system/animes/original/15809.jpg?1711952944",
                                    "preview": "/system/animes/preview/15809.jpg?1711952944",
                                    "x96": "/system/animes/x96/15809.jpg?1711952944",
                                    "x48": "/system/animes/x48/15809.jpg?1711952944"
                                },
                                "url": "/animes/15809-hataraku-maou-sama",
                                "kind": "tv",
                                "score": "7.73",
                                "status": "released",
                                "episodes": 13,
                                "episodes_aired": 13,
                                "aired_on": "2013-04-04",
                                "released_on": "2013-06-27"
                            },
                            "manga": null
                        },
                    {
                            "id": 164138028,
                            "score": 0,
                            "status": "on_hold",
                            "text": null,
                            "episodes": 10,
                            "chapters": 0,
                            "volumes": 0,
                            "text_html": "",
                            "rewatches": 0,
                            "created_at": "2024-01-09T23:35:14.151+03:00",
                            "updated_at": "2024-01-29T13:47:00.367+03:00",
                            "user": {
                                "id": 1380904,
                                "nickname": "Heliagrotor",
                                "avatar": "https://desu.shikimori.one/system/users/x48/1380904.png?1697830845",
                                "image": {
                                    "x160": "https://desu.shikimori.one/system/users/x160/1380904.png?1697830845",
                                    "x148": "https://desu.shikimori.one/system/users/x148/1380904.png?1697830845",
                                    "x80": "https://desu.shikimori.one/system/users/x80/1380904.png?1697830845",
                                    "x64": "https://desu.shikimori.one/system/users/x64/1380904.png?1697830845",
                                    "x48": "https://desu.shikimori.one/system/users/x48/1380904.png?1697830845",
                                    "x32": "https://desu.shikimori.one/system/users/x32/1380904.png?1697830845",
                                    "x16": "https://desu.shikimori.one/system/users/x16/1380904.png?1697830845"
                                },
                                "last_online_at": "2024-07-07T15:58:06.947+03:00",
                                "url": "https://shikimori.one/Heliagrotor"
                            },
                            "anime": {
                                "id": 15809,
                                "name": "Hataraku Maou-sama!",
                                "russian": "kidalovo yoy!!",
                                "image": {
                                    "original": "/system/animes/original/15809.jpg?1711952944",
                                    "preview": "/system/animes/preview/15809.jpg?1711952944",
                                    "x96": "/system/animes/x96/15809.jpg?1711952944",
                                    "x48": "/system/animes/x48/15809.jpg?1711952944"
                                },
                                "url": "/animes/15809-hataraku-maou-sama",
                                "kind": "tv",
                                "score": "7.73",
                                "status": "released",
                                "episodes": 13,
                                "episodes_aired": 13,
                                "aired_on": "2013-04-04",
                                "released_on": "2013-06-27"
                            },
                            "manga": null
                        },
                    {
                            "id": 164138028,
                            "score": 0,
                            "status": "dropped",
                            "text": null,
                            "episodes": 10,
                            "chapters": 0,
                            "volumes": 0,
                            "text_html": "",
                            "rewatches": 0,
                            "created_at": "2024-01-09T23:35:14.151+03:00",
                            "updated_at": "2024-01-29T13:47:00.367+03:00",
                            "user": {
                                "id": 1380904,
                                "nickname": "Heliagrotor",
                                "avatar": "https://desu.shikimori.one/system/users/x48/1380904.png?1697830845",
                                "image": {
                                    "x160": "https://desu.shikimori.one/system/users/x160/1380904.png?1697830845",
                                    "x148": "https://desu.shikimori.one/system/users/x148/1380904.png?1697830845",
                                    "x80": "https://desu.shikimori.one/system/users/x80/1380904.png?1697830845",
                                    "x64": "https://desu.shikimori.one/system/users/x64/1380904.png?1697830845",
                                    "x48": "https://desu.shikimori.one/system/users/x48/1380904.png?1697830845",
                                    "x32": "https://desu.shikimori.one/system/users/x32/1380904.png?1697830845",
                                    "x16": "https://desu.shikimori.one/system/users/x16/1380904.png?1697830845"
                                },
                                "last_online_at": "2024-07-07T15:58:06.947+03:00",
                                "url": "https://shikimori.one/Heliagrotor"
                            },
                            "anime": {
                                "id": 15809,
                                "name": "Hataraku Maou-sama!",
                                "russian": "ee eeee eeeeee e!",
                                "image": {
                                    "original": "/system/animes/original/15809.jpg?1711952944",
                                    "preview": "/system/animes/preview/15809.jpg?1711952944",
                                    "x96": "/system/animes/x96/15809.jpg?1711952944",
                                    "x48": "/system/animes/x48/15809.jpg?1711952944"
                                },
                                "url": "/animes/15809-hataraku-maou-sama",
                                "kind": "tv",
                                "score": "7.73",
                                "status": "released",
                                "episodes": 13,
                                "episodes_aired": 13,
                                "aired_on": "2013-04-04",
                                "released_on": "2013-06-27"
                            },
                            "manga": null
                        },
        
        ]
        """.data(using: .utf8) else {
            fatalError()
        }
        return data
    }
}
