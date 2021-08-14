//
//  SongListViewModel.swift
//  TestProjectHedgehogTech
//
//  Created by Михаил on 12.08.2021.
//

import Foundation
import UIKit

class SongViewModel: Identifiable, ObservableObject {
    let id: Int
    let trackName: String
    let artistName: String
    
    
    init(song: Song) {
        self.id = song.id
        self.trackName = song.trackName
        self.artistName = song.artistName
        
    }
}
