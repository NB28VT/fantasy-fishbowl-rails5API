import React, {Component} from "react";
import {Table} from "react-bootstrap";
import "../stylesheets/user-profile.css"
import avatarPlaceholder from "../images/avatar-placeholder.png"

class UserProfile extends Component {
  render() {
    return(
      <Table responsive >
        <tbody>
          <tr>
            <td className="avatar-image">
              <img alt="avatar" src={avatarPlaceholder}></img>
            </td>
            <td className="user-info">
              <h1>{this.props.userData.user_name}</h1>
              <h2>Current Tour: {this.props.userData.current_tour_name}</h2>
              <h2>Tour Points: {this.props.userData.tour_points}</h2>
            </td>
          </tr>
        </tbody>
      </Table>
    )
  }
}

export default UserProfile;
