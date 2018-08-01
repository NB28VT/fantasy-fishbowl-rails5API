import React, {Component} from "react";
// import {Table} from "react-bootstrap";

const fakeUserData = {
  "user": {
    "user_name": "Kashka8675309",
    "current_tour": "Summer 2018",
    "tour_points": 555,
    "league_rank": 1
  }
}

class Dashboard extends Component {
  constructor(props) {
    super(props)
    this.state = {
      userData: []
    }
  }

  componentWillMount() {
    const userData = this.getUserData();
    this.setState({userData: userData})
  }

  getUserData() {
    // TODO: ping user profile route
    return fakeUserData["user"];
  }

  render() {
    return(
      <h1>Dashboard</h1>

    )
  }
}

{/* <Table responsive >
  <tbody>
    <tr>
      <td>{this.state.userData.user_name}</td>
    </tr>
  </tbody>
</Table> */}

export default Dashboard;
