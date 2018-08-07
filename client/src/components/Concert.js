import React, {Component} from "react";
import SongSearch from './SongSearch'
import ConcertThumbnail from "./ConcertThumbnail"
import PredictionForm from "./PredictionForm"
import Leaderboard from "./Leaderboard"
import SetList from "./SetList"

import '../stylesheets/concert.css';
import venueImage from "../images/alpharetta-venue-image.jpg"

class Concert extends Component {
  // Just blocking in ID for now
  constructor(props) {
    super(props)
    this.state = {
      concert: [],
      loggedIn: true
    }
  }
  componentDidMount() {
    const concertID = this.props.match.params.id;

    fetch(`/concerts/${concertID}`,{
      headers: {"Content-Type": "application/json"}
    })
    .then((res) => res.json())
    .then((responseData) => {
      // TODO: error handling
      this.setState({
        concert: responseData["concert"]
      })
    })
  }

  render() {
    const ConcertInformation = () => {
      if (this.state.concert.performance_finished) {
        return(
          <div>
            <SetList concert_id={this.state.concert.id}/>
            <Leaderboard concert_id={this.state.concert.id} rankingsLimit={5} />
          </div>
        )
      } else {
        return(
          <p>This concert has yet to be performed. Check back later for the setlist and prediction scores!</p>
        )
      }
    }

    const NewUserMessage = () => {
      return(<p>You must be an active user to create a prediction</p>)
        // TODO: Link to sign up
    }

    const NewPrediction = () => {
      // TODO: tie to this.props.logged in
      if (this.state.loggedIn) {
        return(<PredictionForm userID={this.props.userID} concertID={this.state.concert.id}/>)
      } else {
        return (<NewUserMessage/>)
      }
    }

    const PredictionResult = () => {
      // TODO: tie to this.props.logged in
      if (this.state.loggedIn) {
        return(<p>Prediction Result</p> )
      } else {
        return(<NewUserMessage/>)
      }
    }

    const PredictionInformation = () => {
      if (this.state.concert.performance_finished) {
        return (<PredictionResult/>)
      } else {
        return(<NewPrediction/>)
      }
    }

    return(
      <div className="concert">
        <ConcertThumbnail id={this.state.concert.id} venueName={this.state.concert.venue_name} showDate={this.state.concert.show_date} venueImage={venueImage}/>
        <div className="prediction">
          <h1>My Prediction</h1>
          <PredictionInformation />
        </div>
        <div className="concert-info">
          <h1>Concert Info</h1>
          <ConcertInformation />
        </div>

        {/* <SongSearch authToken={this.props.authToken}/> */}
      </div>
    )
  }
}

export default Concert;
