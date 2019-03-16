//
//  Constant.swift
//  YaSS
//
//  Created by Mostafa Saleh on 3/16/19.
//  Copyright © 2019 Mostafa Saleh. All rights reserved.
//

struct Action {
    static let MOVE_UP = "ActionMoveUp"
    static let MOVE_DOWN = "ActionMoveDown"
    static let MOVE_FROWARD = "ActionMoveForward"
    static let MOVE_BACKWARD = "ActionMoveBackward"
    static let ALL = [MOVE_UP, MOVE_DOWN, MOVE_FROWARD, MOVE_BACKWARD]
}

struct Player {
    struct Action {
        static let RUN = "PlayerActionRun"
        static let IDLE = "PlayerActionIdle"
        static let ALL = [RUN, IDLE]
    }
}
