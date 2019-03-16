//
//  GameScene.swift
//  The Runner
//
//  Created by Mostafa Saleh on 3/16/19.
//  Copyright © 2019 Mostafa Saleh. All rights reserved.
//

import GameplayKit
import SpriteKit

class GameScene: SKScene {
    private var backgrounds: [(SKSpriteNode, SKSpriteNode, shift: CGFloat)] = []
    private var player: SKSpriteNode!
    private var playerRunningFrames: [SKTexture] = []
    private var playerIdleFrames: [SKTexture] = []
    private var groundHeight: CGFloat!

    override func didMove(to view: SKView) {
        setupBackground()
        setupGround()
        setupPlayer()
        animatePlayerRunning()
    }

    override func update(_ currentTime: TimeInterval) {
        for background in backgrounds {
            if background.0.position.x <= -background.0.size.width {
                background.0.position.x = background.0.size.width - background.shift
            }
            if background.1.position.x <= -background.1.size.width {
                background.1.position.x = background.1.size.width - background.shift
            }
            background.0.position.x -= background.shift
            background.1.position.x -= background.shift
        }
        if player.position.x <= 0 {
            player.position.x = 0
            animatePlayerRunning()
        } else if player.hasAction(withKey: Player.Action.IDLE) {
            player.position.x -= backgrounds.last!.shift
        } else if player.hasAction(withKey: Action.MOVE_FROWARD) && player.position.x >= frame.width - player.size.width {
            player.position.x = frame.width - player.size.width
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: view) {
            if location.x > frame.width / 2 {
                if !player.hasAction(withKey: Action.MOVE_FROWARD) {
                    player.removeActions(forKeys: Action.ALL)
                    player.move(by: 10, .forward)
                    animatePlayerRunning()
                }
            } else {
                if !player.hasAction(withKey: Action.MOVE_BACKWARD) {
                    player.removeActions(forKeys: Action.ALL)
                    animatePlayerIdle()
                }
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: view)
            if (location.x > frame.width / 2 && player.hasAction(withKey: Player.Action.IDLE))
                || (location.x <= frame.width / 2 && player.hasAction(withKey: Action.MOVE_FROWARD)) {
                touchesEnded(touches, with: event)
                touchesBegan(touches, with: event)
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        animatePlayerRunning()
        player.removeActions(forKeys: Action.ALL)
    }

    private func setupBackground() {
        let backgroundColor = UIColor(red: 171, green: 222, blue: 204)
        let background = SKSpriteNode(color: backgroundColor, size: view!.frame.size)
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint.zero
        background.zPosition = -1000
        addChild(background)
        let backgroundAtlas = SKTextureAtlas(named: "Background")
        let backgroundsCount = backgroundAtlas.textureNames.count
        for i in 1 ... backgroundsCount {
            let desiredWidth = frame.height * 1.7778
            let texture = backgroundAtlas.textureNamed("Background Layer \(i)")
            let shift: CGFloat = CGFloat(abs(i - backgroundsCount) + 1) / 3
            let background = (SKSpriteNode(texture: texture), SKSpriteNode(texture: texture), shift)
            background.0.anchorPoint = CGPoint.zero
            background.0.position = CGPoint.zero
            background.0.size = CGSize(width: desiredWidth, height: frame.height)
            background.0.zPosition = CGFloat(integerLiteral: -(i + 1))
            background.1.anchorPoint = CGPoint.zero
            background.1.position = CGPoint(x: desiredWidth, y: 0)
            background.1.size = CGSize(width: desiredWidth, height: frame.height)
            background.1.zPosition = CGFloat(integerLiteral: -(i + 1))
            addChild(background.0)
            addChild(background.1)
            backgrounds.append(background)
        }
    }

    private func setupGround() {
        groundHeight = frame.height * 0.13
        let desiredSize = CGSize(width: groundHeight * 13.28125, height: groundHeight)
        let ground = (SKSpriteNode(imageNamed: "Ground"), SKSpriteNode(imageNamed: "Ground"), CGFloat(2))
        ground.0.anchorPoint = CGPoint.zero
        ground.0.position = CGPoint.zero
        ground.0.size = desiredSize
        ground.0.zPosition = -1
        ground.1.anchorPoint = CGPoint.zero
        ground.1.position = CGPoint(x: desiredSize.width, y: 0)
        ground.1.size = desiredSize
        ground.1.zPosition = -1
        addChild(ground.0)
        addChild(ground.1)
        backgrounds.append(ground)
    }

    private func setupPlayer() {
        let playerRunningAtlas = SKTextureAtlas(named: "Player Running")
        let playerIdleAtlas = SKTextureAtlas(named: "Player Idle")
        for i in 0 ..< playerRunningAtlas.textureNames.count {
            let textureName = "Running \(i)"
            playerRunningFrames.append(playerRunningAtlas.textureNamed(textureName))
        }
        for i in 0 ..< playerIdleAtlas.textureNames.count {
            let textureName = "Idle \(i)"
            playerIdleFrames.append(playerIdleAtlas.textureNamed(textureName))
        }
        player = SKSpriteNode(texture: playerRunningFrames[0])
        player.anchorPoint = CGPoint.zero
        player.position = CGPoint(x: frame.width / 8, y: groundHeight - (groundHeight / 7))
        addChild(player)
    }

    private func animatePlayerRunning() {
        if !player.hasAction(withKey: Player.Action.RUN) {
            player.removeActions(forKeys: Player.Action.ALL)
            player.texture = playerRunningFrames[0]
            player.run(SKAction.repeatForever(
                SKAction.animate(with: playerRunningFrames, timePerFrame: 0.1, resize: false, restore: true)
            ), withKey: Player.Action.RUN)
        }
    }

    private func animatePlayerIdle() {
        if !player.hasAction(withKey: Player.Action.IDLE) {
            player.removeActions(forKeys: Player.Action.ALL)
            player.texture = playerIdleFrames[0]
            player.run(SKAction.repeatForever(
                SKAction.animate(with: playerIdleFrames, timePerFrame: 0.1, resize: false, restore: true)
            ), withKey: Player.Action.IDLE)
        }
    }
}
