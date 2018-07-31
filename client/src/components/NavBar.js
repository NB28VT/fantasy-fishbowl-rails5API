import React from 'react';
import {
  Navbar,
  Nav,
  NavItem
} from 'react-bootstrap';
import { LinkContainer } from "react-router-bootstrap";


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

const NavBar = (props) => {
  return(

    <Navbar inverse collapseOnSelect>
      <Navbar.Header>
        <Navbar.Brand>
          <a href="#brand">React-Bootstrap</a>
        </Navbar.Brand>
        <Navbar.Toggle />
      </Navbar.Header>
      <Navbar.Collapse>
        <NavLinks logoutUser={props.logoutUser} loggedIn={props.loggedIn}/>
        <Nav pullRight>
        </Nav>
      </Navbar.Collapse>
    </Navbar>
  )
}


export default NavBar;
