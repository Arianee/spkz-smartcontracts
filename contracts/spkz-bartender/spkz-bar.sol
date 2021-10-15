// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";

contract SPKZBar is Initializable, ERC721Upgradeable, ERC721EnumerableUpgradeable, OwnableUpgradeable, UUPSUpgradeable {
  using CountersUpgradeable for CountersUpgradeable.Counter;

  CountersUpgradeable.Counter private _tokenIdCounter;
  string private contractUri;

  /// @custom:oz-upgrades-unsafe-allow constructor
  constructor() initializer {}

  function initialize(string memory _newContractUri) initializer public {
    __ERC721_init("SPKZ Bar", "SPKZBar");
    __ERC721Enumerable_init();
    __Ownable_init();
    __UUPSUpgradeable_init();
    contractUri = _newContractUri;
  }

  function safeMint(address to) public {
    _safeMint(to, _tokenIdCounter.current());
    _tokenIdCounter.increment();
  }

  function _authorizeUpgrade(address newImplementation)
  internal
  onlyOwner
  override
  {}

  // The following functions are overrides required by Solidity.

  function _beforeTokenTransfer(address from, address to, uint256 tokenId)
  internal
  override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
  {
    require(this.balanceOf(to) == 0, "This address already got a free drink !");
    super._beforeTokenTransfer(from, to, tokenId);
  }

  function supportsInterface(bytes4 interfaceId)
  public
  view
  override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
  returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }

  function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
    require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

    if(tokenId == 0){
      return "https://raw.githubusercontent.com/Arianee/spkz-metadata/main/80001/spkz-bar/0.json";
    }

    if(tokenId < 17){
      return "https://raw.githubusercontent.com/Arianee/spkz-metadata/main/80001/spkz-bar/2-16.json";
    }

    if(tokenId == 17){
      return "https://raw.githubusercontent.com/Arianee/spkz-metadata/main/80001/spkz-bar/17.json";
    }

    if(tokenId<1921){
      return "https://raw.githubusercontent.com/Arianee/spkz-metadata/main/80001/spkz-bar/1920.json";
    }

    return "https://raw.githubusercontent.com/Arianee/spkz-metadata/main/80001/spkz-bar/1920%2B.json";
  }

  function contractURI() public view returns (string memory)
  {
    return contractUri;
  }


}
