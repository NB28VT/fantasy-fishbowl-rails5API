import React, {Component} from "react";
import UserProfile from "./UserProfile"
import Leaderboard from "./Leaderboard"
import ConcertThumbnail from "./ConcertThumbnail"
import "../stylesheets/dashboard.css"

// todo: load via API, use webpack:
// https://shakacode.gitbooks.io/react-on-rails/content/docs/additional-reading/rails-assets-relative-paths.html
// OR, use ActiveStorage https://edgeguides.rubyonrails.org/active_storage_overview.html
import venueImage from "../images/alpharetta-venue-image.jpg"

const fakeUserData = {
  "user": {
    "user_name": "Kashka8675309",
    "current_tour_id": 1,
    "tour_points": 555,
    "league_rank": 1
  }
}

const fakeConcertData = {
  "concert": {
    "venue_name": "Verizon Amphitheatre, Alpharetta, GA",
    "show_date": "8/13/18"
  }
}

class Dashboard extends Component {
  constructor(props) {
    super(props)
    this.state = {
      userData: [],
      concertData: []
    }
  }

  componentWillMount() {
    const userData = this.getUserData();

    this.setState({userData: userData});

    const tourID = userData["current_tour_id"];

    if (tourID !== null) {
      const upcomingConcert = this.getUpcomingConcert(tourID);
      this.setState({upcomingConcert: upcomingConcert});
    }
  }

  getUpcomingConcert(tourID) {
    // TODO: fetch upcoming concert via API
    return fakeConcertData["concert"];
  }

  getUserData() {
    // TODO: ping user profile route
    return fakeUserData["user"];
  }

  render() {
    return(
      <div>
        <UserProfile userData={this.state.userData}/>
        <Leaderboard rankingsLimit={3} />
        <div className="upcoming-concert">
          <h1>Next Show</h1>
          <ConcertThumbnail venueName={this.state.upcomingConcert.venue_name} showDate={this.state.upcomingConcert.show_date} venueImage={venueImage}/>
        </div>
      </div>
    )
  }
}

export default Dashboard;
