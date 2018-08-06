import React, {Component} from "react";
import UserProfile from "./UserProfile"
import Leaderboard from "./Leaderboard"
import ConcertThumbnail from "./ConcertThumbnail"

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

const fakeTourData = {
  "tour": {
    "id" : 1,
    "name": "Summer 2018",
    "upcoming_concert_id": 7
  }
}

const fakeConcertData = {
  "concert": {
    "venue_name": "Verizon Amphitheatre, Alpharetta, GA",
    "show_date": "8/13/18"
  }
}

const ConcertHeader = () => {
  return(
    <div className="concert-header">
      <h1>Next Show</h1>
    </div>
  )
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
      const tourData = this.getTourData(tourID);
      const upcomingConcert = this.getUpcomingConcert(tourID);
      this.setState({
        tourData: tourData,
        upcomingConcert: upcomingConcert
      });
    }
  }

  getUpcomingConcert(tourID) {
    // TODO: fetch upcoming concert via API
    return fakeConcertData["concert"];
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
        <ConcertHeader/>
        <ConcertThumbnail venueName={this.state.upcomingConcert.venue_name} showDate={this.state.upcomingConcert.show_date} venueImage={venueImage}/>
      </div>
    )
  }
}

export default Dashboard;
