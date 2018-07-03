import React, {Component} from "react";

class Concert extends Component {
  // TODO: should fetch the deets on this concert using the ID
  render() {
    return(<h1>{this.props.match.id}</h1>)
  }
}

export default Concert;
