pragma solidity 0.5.6;

import "@0xcert/ethereum-utils-contracts/src/contracts/permission/ownable.sol";

contract iArianeeWhitelist{
    function isAuthorized(uint256 _tokenId, address _sender) public view returns(bool);
}

contract ERC721Interface {
    function ownerOf(uint256 _tokenId) public view returns(address);
}


contract ArianeeMessage is Ownable{

  /**
 * @dev Mapping from receiver address to messagesId [].
 */
  mapping(address => uint256[]) public receiverToMessageIds;

  /**
* @dev Mapping from messageId to amount of reward Aria.
*/
  mapping(uint256 => uint256) rewards;

  iArianeeWhitelist whitelist;
  ERC721Interface smartAsset;
  address arianeeStoreAddress;

  struct Message {
    bytes32 imprint;
    address sender;
    uint256 tokenId;
  }

  mapping(uint256 => Message) public messages;

  /**
   * @dev This emits when a message is sent.
   */
  event MessageSent(address indexed _receiver, address indexed _sender, uint256 indexed _tokenId, uint256 _messageId);
  /**
   * @dev This emits when a message is read.
   */
  event MessageRead(address indexed _receiver, address indexed _sender, uint256 indexed _messageId);


  constructor(address _whitelistAddress, address _smartAssetAddress) public{
        whitelist = iArianeeWhitelist(address(_whitelistAddress));
        smartAsset = ERC721Interface(address(_smartAssetAddress));
    }

    modifier onlyStore(){
        require(msg.sender == arianeeStoreAddress);
        _;
    }

    /**
     * @dev set a new store address
     * @notice can only be called by the contract owner.
     * @param _storeAddress new address of the store.
     */
    function setStoreAddress(address _storeAddress) public onlyOwner(){
        arianeeStoreAddress = _storeAddress;
    }

    /**
     * @dev get length of message received by address
     * @param _receiver address.
     */
    function messageLengthByReceiver(address _receiver) public view returns (uint256){
           return receiverToMessageIds[_receiver].length;
    }

  /**
   * @dev Send a message
   * @notice can only be called by an whitelisted address and through the store
   * @param _messageId id of the message
   * @param _tokenId token associate to the message
   * @param _imprint of the message
   */
  function sendMessage(uint256 _messageId, uint256 _tokenId, bytes32 _imprint, address _from, uint256 _reward) public onlyStore() {

    address _owner = smartAsset.ownerOf(_tokenId);
    require(whitelist.isAuthorized(_tokenId, _from));
    require(messages[_messageId].sender == address(0));

    Message memory _message = Message({
            imprint : _imprint,
            sender : _from,
            tokenId: _tokenId
        });


    messages[_messageId] = _message;
    receiverToMessageIds[_owner].push(_messageId);

    rewards[_messageId] = _reward;

    emit MessageSent(_owner, _from, _tokenId, _messageId);
    }


}