// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract LearnMapping {
    mapping(address => uint) public myMap;

    function getAddress(address _addr) public view returns(uint) {
        return myMap[_addr];
    }

    function setAddress(address _addr, uint _i) public {
        myMap[_addr] = _i;
    }

    function removeAddress(address _addr) public {
        delete myMap[_addr];
    }
}

contract MappingAssignment {
    struct Movie {
        string title;
        string director;
    }

    mapping(uint => Movie) movie;

    function addMovie(uint movieId, string memory title, string memory director) public {
        movie[movieId] = Movie(
            title,
            director
        );
    }

    function getMovie(uint movieId) public view returns(Movie memory) {
        return movie[movieId];
    }
}
