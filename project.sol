// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdventureGames {

    address public owner;

    // Event to notify when a new game is created
    event GameCreated(uint256 gameId, string name, string description, uint256 timestamp);

    // Struct to hold game details
    struct Game {
        uint256 gameId;
        string name;
        string description;
        uint256 timestamp;
        address creator;
    }

    // Mapping from gameId to Game struct
    mapping(uint256 => Game) public games;
    uint256 public gameCount;

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    // Constructor to initialize the contract
    constructor() {
        owner = msg.sender;
        gameCount = 0;
    }

    // Function to create a new game
    function createGame(string memory _name, string memory _description) public returns (uint256) {
        gameCount++;
        games[gameCount] = Game(gameCount, _name, _description, block.timestamp, msg.sender);
        emit GameCreated(gameCount, _name, _description, block.timestamp);
        return gameCount;
    }

    // Function to get the details of a game
    function getGame(uint256 _gameId) public view returns (string memory, string memory, uint256, address) {
        Game memory game = games[_gameId];
        return (game.name, game.description, game.timestamp, game.creator);
    }

    // Function to update game details
    function updateGame(uint256 _gameId, string memory _name, string memory _description) public {
        require(msg.sender == games[_gameId].creator, "You are not the creator of this game");
        games[_gameId].name = _name;
        games[_gameId].description = _description;
    }

    // Function to delete a game (only by owner)
    function deleteGame(uint256 _gameId) public onlyOwner {
        delete games[_gameId];
    }
}
