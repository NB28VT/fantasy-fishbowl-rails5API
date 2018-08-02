import React, {Component} from "react";
import UserProfile from "./UserProfile"
import Leaderboard from "./Leaderboard"
import ConcertThumbnail from "./ConcertThumbnail"

const fakeUserData = {
  "user": {
    "user_name": "Kashka8675309",
    "current_tour_id": 1,
    "tour_points": 555,
    "league_rank": 1
  }
}

const fakeTourData = {
  "tour": {
    "id" : 1,
    "name": "Summer 2018",
    "upcoming_concert_id": 7
  }
}


class Dashboard extends Component {
  constructor(props) {
    super(props)
    this.state = {
      userData: []    }
  }

  componentWillMount() {
    const userData = this.getUserData();
    this.setState({userData: userData});

    if (userData["current_tour_id"]) {
      const tourData = this.getTourData(userData["current_tour_id"]);
      this.setState({tourData: tourData});
    }
  }

  getTourData() {
    // TODO: ping tour data
    return fakeTourData["tour"]
  }

  getUserData() {
    // TODO: ping user profile route
    return fakeUserData["user"];
  }

  render() {
    return(
      <div>
        <UserProfile userData={this.state.userData}/>
        <Leaderboard tourID={this.state.tourData} rankingsLimit={3} />
        <ConcertThumbnail concertID={this.state.tourData["upcoming_concert_id"]}/>
      </div>
    )
  }
}

export default Dashboard;
