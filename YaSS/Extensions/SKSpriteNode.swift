//
//  SKSpriteNode.swift
//  YaSS
//
//  Created by Mostafa Saleh on 3/16/19.
//  Copyright © 2019 Mostafa Saleh. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
    func move(by amount: CGFloat, _ direction: Direction) {
        let action: SKAction
        let actionKey: String
        switch direction {
        case .forward:
            action = SKAction.move(by: CGVector(dx: 10, dy: 0), duration: 0.1)
            actionKey = Action.MOVE_FROWARD
        case .backward:
            action = SKAction.move(by: CGVector(dx: -10, dy: 0), duration: 0.1)
            actionKey = Action.MOVE_BACKWARD
        case .up:
            action = SKAction.move(by: CGVector(dx: 0, dy: 10), duration: 0.1)
            actionKey = Action.MOVE_UP
        case .down:
            action = SKAction.move(by: CGVector(dx: 0, dy: -10), duration: 0.1)
            actionKey = Action.MOVE_DOWN
        }
        run(SKAction.repeatForever(action), withKey: actionKey)
    }

    func removeActions(forKeys keys: [String]) {
        for key in keys {
            removeAction(forKey: key)
        }
    }
    
    func hasAction(withKey key: String) -> Bool {
        return action(forKey: key) != nil
    }
}
