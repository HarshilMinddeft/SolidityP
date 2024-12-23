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

    mapping(address => bytes32[]) public senderStreams;

      event StreamCreated(
        bytes32 indexed streamId,
        address indexed sender,
        address indexed receiver,
        int256 flowRate,
        uint256 startTime
    );

    event StreamStopped(
        bytes32 indexed streamId,
        address indexed sender,
        address indexed receiver,
        int256 flowRate,
        uint256 stopTime
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

        senderStreams[msg.sender].push(streamId);

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

         _removeStreamFromSender(stream.sender, streamId);

         delete streams[streamId];
         emit StreamStopped(streamId, stream.sender, stream.receiver, stream.flowRate, block.timestamp);
    }

       // Internal function to remove a stream from sender's active streams
    function _removeStreamFromSender(address sender, bytes32 streamId) internal {
        bytes32[] storage activeStreams = senderStreams[sender];
        for (uint256 i = 0; i < activeStreams.length; i++) {
            if (activeStreams[i] == streamId) {
                activeStreams[i] = activeStreams[activeStreams.length - 1];
                activeStreams.pop();
                break;
            }
        }
    }
    
      // Get active streams for a sender
    function getSenderStreams(address sender) external view returns (bytes32[] memory) {
        return senderStreams[sender];
    }

}