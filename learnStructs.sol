// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract LearnStructs {
    struct Movie {
        string title;
        string director;
        uint movie_id;        
    }

    Movie movie;

    function setMovie() public {
        movie = Movie(
            "Blad Runner",
            "Ridley Scott",
            2
        );
    }

    function getMovieId() public view returns (uint) {
        return movie.movie_id;
    }
}