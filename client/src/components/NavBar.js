import React from 'react';
import {
  Navbar,
  Nav,
  NavItem
} from 'react-bootstrap';
import Link from 'react-router-dom';

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
        <Nav>
          <NavItem eventKey={1}></NavItem>
          <NavItem eventKey={2} href="#">
            Link
          </NavItem>
        </Nav>
        <Nav pullRight>

        </Nav>
      </Navbar.Collapse>
    </Navbar>
  )
}


export default NavBar;
