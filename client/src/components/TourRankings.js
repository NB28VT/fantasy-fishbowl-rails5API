import React, {Component} from "react";
import Leaderboard from "./Leaderboard";
import "../stylesheets/tour-rankings.css"

class TourRankings extends Component {
  render(){
    return(
      <div className="rankings-leaderboard">
        <Leaderboard/>
      </div>
    )
  }
}

export default TourRankings;
