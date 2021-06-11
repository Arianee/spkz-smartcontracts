pragma solidity 0.5.6;

import "@0xcert/ethereum-utils-contracts/src/contracts/permission/abilitable.sol";

contract iArianeeWhitelist{
  function addWhitelistedAddress(uint256 _tokenId, address _address) external ;
}


contract ArianeeUserAction{
  iArianeeWhitelist whitelist;

  constructor(address _whitelistAddress) public{
    whitelist = iArianeeWhitelist(address(_whitelistAddress));
  }

  function addAddressToWhitelist(uint256 _tokenId, address _address) external {

    whitelist.addWhitelistedAddress(_tokenId, _address);

  }

}