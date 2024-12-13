// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Erc20Super.sol";

contract StreamManager {
    Erc20Super public superToken;

    struct Stream {
        address sender;
        address receiver;
        int256 flowRate;
        uint256 startTime;
    }

    mapping(bytes32 => Stream) public streams;

      event StreamCreated(
        bytes32 indexed streamId,
        address indexed sender,
        address indexed receiver,
        int256 flowRate,
        uint256 startTime
    );

    constructor(Erc20Super _superToken) {
        superToken = _superToken;
    }

    // Create a new stream
    function createStream(address receiver, int256 flowRate) external {
        require(flowRate > 0, "Flow rate must be positive");
        require(superToken.balanceOf(msg.sender) >= uint256(flowRate * 3600), "Insufficient balance for stream");

        bytes32 streamId = keccak256(abi.encodePacked(msg.sender, receiver, block.timestamp));
        streams[streamId] = Stream({
            sender: msg.sender,
            receiver: receiver,
            flowRate: flowRate,
            startTime: block.timestamp
        });

        superToken.updateFlow(msg.sender, -flowRate);
        superToken.updateFlow(receiver, flowRate);

        emit StreamCreated(streamId, msg.sender, receiver, flowRate, block.timestamp);
       
    }

    // Stop a stream
    function stopStream(bytes32 streamId) external {
        Stream memory stream = streams[streamId];
        require(stream.sender == msg.sender, "Only the sender can stop the stream");

        // int256 elapsedTokens = stream.flowRate * int256(block.timestamp - stream.startTime);
        superToken.updateFlow(stream.sender, stream.flowRate);
        superToken.updateFlow(stream.receiver, -stream.flowRate);

        delete streams[streamId];
    }
}
