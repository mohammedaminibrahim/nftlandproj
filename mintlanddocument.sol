// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LandDocumentNFT is ERC721, Ownable {
    struct Memorial {
        uint256 entryDate;
        uint256 instrumentDate;
        uint256 registrationDate;
        string registrationNumber;
    }

    struct Location {
        string projection;
        string _block;
        string parcel;
        string locality;
        string district;
        string region;
        string area;
    }

    struct PlanData {
        string fromCoordinates;
        string toCoordinates;
        string bearing;
    }

    struct LandMap {
        string imageUrl;
    }

    mapping(uint256 => Memorial) public memorials;
    mapping(uint256 => Location) public locations;
    mapping(uint256 => PlanData) public planData;
    mapping(uint256 => LandMap) public landMaps;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

    function mint(
        address to,
        uint256 tokenId,
        uint256 entryDate,
        uint256 instrumentDate,
        uint256 registrationDate,
        string memory registrationNumber,
        string memory projection,
        string memory block,
        string memory parcel,
        string memory locality,
        string memory district,
        string memory region,
        string memory area,
        string memory fromCoordinates,
        string memory toCoordinates,
        string memory bearing,
        string memory imageUrl
    ) public onlyOwner {
        _mint(to, tokenId);

        memorials[tokenId] = Memorial(entryDate, instrumentDate, registrationDate, registrationNumber);
        locations[tokenId] = Location(projection, _block, parcel, locality, district, region, area);
        planData[tokenId] = PlanData(fromCoordinates, toCoordinates, bearing);
        landMaps[tokenId] = LandMap(imageUrl);
    }
}
