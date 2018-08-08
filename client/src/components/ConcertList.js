import React, {Component} from "react";
import {Grid} from 'react-bootstrap';
import '../stylesheets/concert_list.css';
import ConcertThumbnail from "./ConcertThumbnail";

// todo: load via API, use webpack:
// https://shakacode.gitbooks.io/react-on-rails/content/docs/additional-reading/rails-assets-relative-paths.html
// OR, use ActiveStorage https://edgeguides.rubyonrails.org/active_storage_overview.html
import venueImage from "../images/alpharetta-venue-image.jpg"


class ConcertList extends Component {
  constructor(props) {
    super(props)
    this.state = {
      concerts: []
    }
  }

  componentDidMount(){
    const endpoint = this.props.upcomingOnly ? "/concerts/upcoming" : "/concerts"
    this.fetchConcertData(endpoint);
  }

  fetchConcertData(endpoint) {
    fetch(endpoint,{
      headers: {"Content-Type": "application/json"}
    })
    .then((res) => res.json())
    .then((responseData) => {
      // TODO: error handling
      this.setState({
        concerts: responseData["concerts"]
      })
    })
  }

  render() {
    const concerts = this.state.concerts.map((concert) =>
      <ConcertThumbnail key={concert.id} id={concert.id} venueName={concert.venue_name} showDate={concert.show_date} venueImage={venueImage}/>
    );

    const ConcertHeader = () => {
      if (this.props.upcomingOnly) {
        return(<h1>Upcoming Shows</h1>);
      } else {
        return(<h1>Shows</h1>);
      }
    }

    return(
      <div>
        <div className="concert-header">
          <ConcertHeader/>
        </div>
        <Grid>
          {concerts}
        </Grid>
      </div>
    )
  }
}

export default ConcertList;
