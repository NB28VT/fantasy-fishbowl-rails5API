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
      // <div className="concert-thumbnail">
        // <Grid>
          <Row className="concert-thumbnail">
            <Col xs={4} md={8}>
              <img className="img-responsive" alt="venue" src={this.props.venueImage}></img>
            </Col>
            <Col xs={8} md={4}>
              <h1>{this.props.showDate}</h1>
              <h2>{this.props.venueName}</h2>
            </Col>
          </Row>
        // </Grid>
      // </div>
    )
  }
}

export default ConcertThumbnail;
