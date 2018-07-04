import React, {Component} from "react";

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
    return(<h1>{this.state.concertID}</h1>)
  }
}

export default Concert;
