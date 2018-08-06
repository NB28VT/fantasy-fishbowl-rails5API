import React, {Component} from "react";
import {Row, Col} from 'react-bootstrap';
import "../stylesheets/concert-thumbnail.css"

class ConcertThumbnail extends Component {
  constructor(props) {
    super(props)
    this.state = {
      concertData: []
    }
  }

  render() {
    return(
      <div className="concert-thumbnail">
          <Row className="thumbnail-row">
            <Col xs={4} md={6} className="image-column">
              <img className="thumbnail-image" alt="venue" src={this.props.venueImage}></img>
            </Col>
            <Col xs={8} md={6} className="show-info-column">
              <h1>{this.props.showDate}</h1>
              <h2>{this.props.venueName}</h2>
              <h2>Showtime: 7:30 p.m. EST</h2>
            </Col>
          </Row>
          <Row className="spacer-row"></Row>
      </div>
    )
  }
}

export default ConcertThumbnail;
