local HASH = require("constants/HashID")
local POSITIONS = require("constants/Positions")

local thirst = require("modules/models/Need")
local hunger = require("modules/models/Need")
local fatigue = require("modules/models/Need")

Player = {}

function Player:new()
    local o = {}

    setmetatable(o, {__index = self})

    o.state = {
        enable = false,
        vehicle = false,
        showNotif = false,
        refresh = false
    }
    o.actionCost = {
        alcohol = false,
        move = false,
        sprint = false,
        melee = false,
        jump = false
        --drug = false --wip
    }
    o.actionRegen = {
        drink = false,
        eat = false,
        shower = false,
        rest = false,
        sleep = false
        --sex = false --wip
    }
    o.needs = {
        thirst = thirst:new(),
        hunger = hunger:new(),
        fatigue = fatigue:new()
    }

    return o
end

function Player:reset()
    self.needs.thirst:reset()
    self.needs.hunger:reset()
    self.needs.fatigue:reset()
end

local function inCircle(pos, x, y, r_tol)
    local dx = pos.x - x
    local dy = pos.y - y
    local r_sq = dx^2 + dy^2
    return (r_sq <= r_tol^2)
end

function Player:getScenePos()
    local player = Game.GetPlayer()
    local playerPos = player:GetWorldPosition()

    for apt, aptData in pairs(POSITIONS) do
        if (inCircle(playerPos, aptData.x, aptData.y, aptData.r)) and
            (playerPos.z >= aptData.z_min and playerPos.z <= aptData.z_max) then
            print(('[LiNC Debug] Detected in Apt: %s'):format(apt))
            for poi, poiData in ipairs(aptData.pois) do
                if (inCircle(playerPos, poiData.x, poiData.y, poiData.r)) then
                    print(('[LiNC Debug] Detected in POI index %d, type %s'):format(poi, poiData.type))
                    if poiData.type == "bed" then
                        self.actionRegen.sleep = true
                    elseif poiData.type == "couch" then
                        self.state.enable = true
                        self.actionRegen.rest = true
                    elseif poiData.type == "shower" then
                        self.state.enable = true
                        self.actionRegen.shower = true
                    end
                end
            end
        end
    end
end

function Player:getConsumption()
    local player = Game.GetPlayer()
    local playerID = player:GetEntityID()
    local playerEffects = Game.GetStatusEffectSystem():GetAppliedEffects(playerID)

    self.actionRegen.drink = false
    self.actionRegen.eat = false
    self.actionCost.alcohol = false
    if (playerEffects) then
        for _, playerEffect in pairs(playerEffects) do
            local effect = HASH[playerEffect:GetRecord():GetID().hash]
            if effect ~= nil then
                if effect == "drink" then
                    self.actionRegen.drink = true
                elseif effect == "eat" then
                    self.actionRegen.eat = true
                elseif effect == "alcohol" then
                    self.actionCost.alcohol = true
                end
            end
        end
    end
end

function Player:updateMetabolism()
    self.needs.thirst:update(LiNC.config.thirst, User.settings.thirst)
    self.needs.hunger:update(LiNC.config.hunger, User.settings.hunger)
    self.needs.fatigue:update(LiNC.config.fatigue, User.settings.fatigue)
    if self.actionRegen.sleep then
        self.actionRegen.sleep = false
        self.needs.fatigue:setTotal(0)
        self.needs.hunger:setTotal(self.needs.hunger.state.total + LiNC.config.hunger.sleepTotalCost)
        self.needs.thirst:setTotal(self.needs.thirst.state.total + LiNC.config.thirst.sleepTotalCost)
    end
    self.actionRegen.melee = false
    self.actionCost.jump = false
    if self.state.showNotif then
        self.state.showNotif = false
        if User.settings.display.notif then
            Notif.show()
        end
    end
end

return Player
