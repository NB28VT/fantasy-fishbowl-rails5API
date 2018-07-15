import React, {Component} from "react";
import SongSearch from './SongSearch'

class Concert extends Component {
  // Just blocking in ID for now
  constructor(props) {
    super(props)
    this.state = {
      // concert: []
      concertID: null
    }
  }
  componentDidMount() {
    this.setState({concertID: this.props.match.params.id})
  }

  render() {
    return(
      <div>
        <h1>{this.state.concertID}</h1>
        <SongSearch authToken={this.props.authToken}/>
      </div>




    )
  }
}

export default Concert;
