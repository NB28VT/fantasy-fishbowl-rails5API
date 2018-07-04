import React, {Component} from "react";
import {Link} from "react-router-dom";
class ConcertList extends Component {
  constructor(props) {
    super(props)
    this.state = {
      concerts: []
    }
  }

  componentDidMount(){
    // TODO: handle no auth token
    fetch("/concerts/upcoming",{
      headers: {
        "Content-Type": "application/json",
        "Authorization": this.props.authToken
      }
    })
    .then((res) => res.json())
    .then((responseData) => {
        this.setState({concerts: responseData["concerts"]})
      }
    )
  }

  render() {
    const concerts = this.state.concerts.map((concert) =>
      <li key={concert.id}><Link to={`concerts/${concert.id}`}>{`${concert.show_date} - ${concert.venue_name}`}</Link></li>
    );

    return (
      <div>
        <ul>
          {concerts}
        </ul>
      </div>
    )
  }
}

export default ConcertList;
