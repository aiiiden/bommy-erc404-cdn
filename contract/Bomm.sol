//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./ERC404.sol";
import "./libs/Strings.sol"; 

contract Bommy is ERC404 {
    string public dataURI;
    string public baseTokenURI;

    constructor(address _owner) ERC404("Bommy", "BOMMY", 18, 100, _owner) {
        balanceOf[_owner] = 100 * 10 ** 18;
        whitelist[_owner] = true;
    }

    function setDataURI(string memory _dataURI) public onlyOwner {
        dataURI = _dataURI;
    }

    function setTokenURI(string memory _tokenURI) public onlyOwner {
        baseTokenURI = _tokenURI;
    }

    function setNameSymbol(string memory _name, string memory _symbol) public onlyOwner {
        _setNameSymbol(_name, _symbol);
    }

    function tokenURI(uint256 id) public view override returns (string memory) {
        if (bytes(baseTokenURI).length > 0) {
            return string.concat(baseTokenURI, Strings.toString(id));
        } else {
            uint8 seed = uint8(bytes1(keccak256(abi.encodePacked(id))));
            string memory image;

            if (seed <= 10) {
                image = "1.png";
            } else if (seed <= 30) {
                image = "2.png";
            } else if (seed <= 50) {
                image = "3.png";
            } else if (seed <= 70) {
                image = "4.png";
            } else if (seed <= 100) {
                image = "5.png";
            }

            string memory jsonPreImage = string.concat(
                string.concat(
                    string.concat('{"name": "Bommy #', Strings.toString(id)),
                    '","description":"Five cats are coming","image":"'
                ),
                string.concat(dataURI, image)
            );
            string memory jsonPostImage = string.concat('","attributes":[{"trait_type":"Name","value":"Bommy');
            string memory jsonPostTraits = '"}]}';

            return string.concat(
                "data:application/json;utf8,", string.concat(string.concat(jsonPreImage, jsonPostImage), jsonPostTraits)
            );
        }
    }
}