import React, {Component} from "react";
import {
  Grid,
  Row,
  Col
} from 'react-bootstrap';
import "../stylesheets/concert-thumbnail.css"
// todo: load via API
import venueImage from "../images/alpharetta-venue-image.jpg"

const fakeConcertData = {
  "concert": {
    "venue_name": "Verizon Amphitheatre, Alpharetta, GA",
    "show_date": "8/13/18"
  }
}

class ConcertThumbnail extends Component {
  constructor(props) {
    super(props)
    this.state = {
      concertData: []
    }
  }

  componentWillMount() {
    const concertData = this.fetchConcertData();
    this.setState({concertData: concertData})
  }

  fetchConcertData() {
    return fakeConcertData["concert"];
  }

  render() {
    return(
      <div className="concert-thumbnail">
        <Grid>
          <Row className="show-grid">
            <Col xs={5} md={8}>
              <img alt="venue" width="100%" src={venueImage}></img>
            </Col>
            <Col xs={7} md={4}>
              <h1>Next Show:</h1>
              <h2>Venue: {this.state.concertData.venue_name} </h2>
              <h2>Date: {this.state.concertData.show_date}</h2>
            </Col>
          </Row>
        </Grid>
      </div>
    )
  }
}

export default ConcertThumbnail;
