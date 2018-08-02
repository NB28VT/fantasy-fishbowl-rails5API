import React, {Component} from "react";
import UserProfile from "./UserProfile"
import Leaderboard from "./Leaderboard"

const fakeUserData = {
  "user": {
    "user_name": "Kashka8675309",
    "current_tour_name": "Summer 2018",
    "current_tour_id": 1,
    "tour_points": 555,
    "league_rank": 1
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
    this.setState({userData: userData})
  }

  getUserData() {
    // TODO: ping user profile route
    return fakeUserData["user"];
  }

  render() {
    return(
      <div>
        <UserProfile userData={this.state.userData}/>
        <Leaderboard tourID={this.state.userData["current_tour_id"]} rankingsLimit={3} />
      </div>
    )
  }
}

export default Dashboard;
