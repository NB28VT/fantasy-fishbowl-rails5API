import React, {Component} from 'react';
import {
  Navbar,
  Nav,
  NavItem
} from 'react-bootstrap';
import {withRouter} from 'react-router-dom'
import { LinkContainer } from "react-router-bootstrap";
import horizontalLogo from "../images/yellow-logo-horizontal.png"

const LoginLinks = (props) => {
  if (props.loggedIn === true) {
    return(
      <Nav>
        <LinkContainer to="/home">
          <NavItem>My Profile</NavItem>
        </LinkContainer>
        <NavItem onSelect={props.logoutUser}>Log Out</NavItem>
      </Nav>
    )
  }

  return (
    // need top level Nav component for navbar to collapse properly
    <Nav>
      <LinkContainer to="/login">
        <NavItem>Log In</NavItem>
      </LinkContainer>
    </Nav>

  )
}

class NavBar extends Component {
  constructor(props) {
    super(props)

    this.logoutUser = this.logoutUser.bind(this);
  }

  logoutUser() {
    this.props.logoutUser();
    this.props.history.push('/login');
  }

  render(){
    return(
      <Navbar inverse collapseOnSelect fixedTop>
        <Navbar.Header>
          <Navbar.Brand>
            <a><img alt="logo" src={horizontalLogo} height="100%"/></a>
          </Navbar.Brand>
          <Navbar.Toggle />
        </Navbar.Header>
        <Navbar.Collapse>
          <Nav>
            <LinkContainer to="/concerts/upcoming">
              <NavItem>Upcoming Shows</NavItem>
            </LinkContainer>
            <LinkContainer to="/leaderboard">
              <NavItem>Tour Leaderboard</NavItem>
            </LinkContainer>
          </Nav>
          <LoginLinks logoutUser={this.logoutUser} loggedIn={this.props.loggedIn}/>
        </Navbar.Collapse>
      </Navbar>
    )
  }
}

export default withRouter(NavBar);
