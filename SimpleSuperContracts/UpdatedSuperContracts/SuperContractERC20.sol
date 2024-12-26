// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./SuperTokenWrapUnwrap.sol";

contract StreamManager is ReentrancyGuard{
    
    Erc20Super public superToken;
    address public operator;
    
    struct Stream {
        address sender;
        address receiver;
        int256 flowRate;
        uint256 startTime;
        uint256 fee; // 20 minutes worth of tokens
    }

    mapping(bytes32 => Stream) public streams;
    mapping(address => bytes32[]) public senderStreams;

    event StreamCreated(
        bytes32 indexed streamId,
        address indexed sender,
        address indexed receiver,
        int256 flowRate,
        uint256 startTime,
        uint256 fee
    );

    event StreamStopped(
        bytes32 indexed streamId,
        address indexed sender,
        address indexed receiver,
        int256 flowRate,
        uint256 stopTime,
        address stopper,
        uint256 fee
    );

    constructor(Erc20Super _superToken, address _operator) {
        superToken = _superToken;
        operator = _operator;
    }

    // Create a new stream
    function createStream(address receiver, int256 flowRate) external nonReentrant {
        require(flowRate > 0, "Flow rate must be positive");

        // Calculate 20-minute fee and required balance
        uint256 fee = uint256(flowRate * 20 * 60); // 20 minutes worth of tokens
        uint256 requiredBalance = uint256(flowRate * 1800) + fee; // 0.5 hour + fee

        require(
            superToken.balanceOf(msg.sender) >= requiredBalance,
            "Insufficient balance for stream"
        );

        // Deduct the fee from the sender instantly not same as below decreasing balance everySecond
        superToken.transferFrom(msg.sender, address(this), fee);

        // Update token flows
        superToken.updateFlow(msg.sender, -flowRate);
        superToken.updateFlow(receiver, flowRate);

        // Create the stream
        bytes32 streamId = keccak256(abi.encodePacked(msg.sender, receiver, block.timestamp));
        streams[streamId] = Stream({
            sender: msg.sender,
            receiver: receiver,
            flowRate: flowRate,
            startTime: block.timestamp,
            fee: fee
        });

        senderStreams[msg.sender].push(streamId);

        emit StreamCreated(streamId, msg.sender, receiver, flowRate, block.timestamp, fee);
    }

// Gas optimisation can be done in this function 
    // Stop a stream
    function stopStream(bytes32 streamId) external nonReentrant{
     Stream memory stream = streams[streamId];
         require(
            msg.sender == stream.sender || msg.sender == stream.receiver || msg.sender == operator,
           "NotAllowed"
       );

    // Stop the token flows for the stream
      superToken.updateFlow(stream.sender, stream.flowRate);
      superToken.updateFlow(stream.receiver, -stream.flowRate);

    // Handle fee distribution
      if (msg.sender == operator) {
        // Operator gets the fee
          superToken.transfer(operator, stream.fee);
     } else {
        // Sender gets the fee back
        superToken.transfer(stream.sender, stream.fee);
     }

    // Remove the stream
      _removeStreamFromSender(stream.sender, streamId);
          delete streams[streamId];

      emit StreamStopped(
        streamId,
        stream.sender,
        stream.receiver,
        stream.flowRate,
        block.timestamp,
        msg.sender,
        stream.fee
    );
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

    // Update the operator address
    function setOperator(address _operator) external {
        require(msg.sender == operator, "Only the current operator can set a new operator");
        operator = _operator;
    }

}
