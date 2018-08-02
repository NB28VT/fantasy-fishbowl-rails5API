import React, {Component} from "react";
import {Table} from "react-bootstrap";
import "../stylesheets/leaderboard.css"

const fakeRankings = {
  tour_name: "Summer 2018",
  "rankings": [
    {rank: 1,
    "user_name": "Kashka8675309",
    score: 555},
    {rank: 2,
    "user_name": "TheBobs1234",
    score: 324},
    {rank: 3,
    "user_name": "RustyShackleford802",
    score: 15}
  ]
}

class Leaderboard extends Component {
  constructor(props) {
    super(props)
    this.state = {
      rankingsData: [],
      tourName: ""
    }

    this.fetchTourRankings = this.fetchTourRankings.bind(this);
  }

  componentWillMount() {
    const rankings = this.fetchTourRankings();
    this.setState({rankingsData: rankings["rankings"], tourName: rankings["tour_name"]});
  }

  fetchTourRankings() {
    // Drive off of tour id passed to props
    // TODO: QUERY. Allow limiting (like max 3 to view on dasboard)
    return fakeRankings;
  }

  render() {
    const rankingsTable = this.state.rankingsData.map((user) =>
      <tr key={user.rank}>
        <td>{user.rank}</td>
        <td>{user.user_name}</td>
        <td></td>
        <td>{user.score}</td>
      </tr>
    );

    return(
      <div className="leaderboard">
        <h1>{this.state.tourName} Leaderboard</h1>
        <Table striped>
          <thead>
            <tr>
              <th>Rank</th>
              <th>Name</th>
              <th></th>
              <th>Score</th>
            </tr>
          </thead>
          <tbody>
            {rankingsTable}
          </tbody>
        </Table>
      </div>
    )
  }
}

export default Leaderboard;
