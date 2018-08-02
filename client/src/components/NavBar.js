import React, {Component} from 'react';
import {
  Navbar,
  Nav,
  NavItem
} from 'react-bootstrap';
import {withRouter} from 'react-router-dom'
import { LinkContainer } from "react-router-bootstrap";
import horizontalLogo from "../images/yellow-logo-horizontal.png"

const NavLinks = (props) => {
  if (props.loggedIn === true) {
    return(
      <Nav>
        <NavItem onSelect={props.logoutUser}>Log Out</NavItem>
      </Nav>
    )
  }

  return (
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
      <Navbar inverse collapseOnSelect>
        <Navbar.Header>
          <Navbar.Brand>
            <a><img alt="logo" src={horizontalLogo} height="100%"/></a>
          </Navbar.Brand>
          <Navbar.Toggle />
        </Navbar.Header>
        <Navbar.Collapse>
          <NavLinks logoutUser={this.logoutUser} loggedIn={this.props.loggedIn}/>
          <Nav pullRight>
          </Nav>
        </Navbar.Collapse>
      </Navbar>
    )
  }
}


export default withRouter(NavBar);
