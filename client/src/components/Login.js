import React, { Component } from 'react';
import {Redirect} from 'react-router-dom';
import {
  Form,
  FormGroup,
  Col,
  FormControl,
  Button
} from 'react-bootstrap';
// import Cookies from 'universal-cookie';

import "../stylesheets/login.css"
import vertLogo from "../images/yellow-logo-vertical.png"

// const cookies = new Cookies();

const WelcomeMessage = () => {
  return(
    <div className="welcome-message">
      <img alt="logo" width="100%" src={vertLogo}></img>
      <p>The Setlist Prediction Game</p>
    </div>
  )
}

class Login extends Component {
  constructor(props) {
    super(props);
    this.state = {
      redirectToReferrer: false,
      email: "",
      password: ""
    }

    this.updateEmail = this.updateEmail.bind(this);
    this.updatePassword = this.updatePassword.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(event) {
    event.preventDefault();

    const encodedEmail = encodeURIComponent(this.state.email);
    const encodedPassword = encodeURIComponent(this.state.password);

    const authUrl = `/authenticate?email=${encodedEmail}&password=${encodedPassword}`
    fetch(authUrl, {
      method: "POST",
      headers: {"Content-Type": "application/json"}
    })
    .then((res) => res.json())
    .then((responseData) => {
        // this.setCookie(responseData["token"])

        this.props.loginUser(responseData["token"]);
        this.setState({redirectToReferrer: true});
      }
    )
  }

  updateEmail(event) {
    this.setState({email: event.target.value})
  }

  updatePassword(event) {
    this.setState({password: event.target.value})
  }

  // setCookie(token) {
  //   cookies.set("token", token, {path: "/"})
  // }

  render() {
    // Hardcode homepage redirect
    if (this.state.redirectToReferrer) {
      return(
        <Redirect to="/"/>
      )
    }

    return(
      <div className="login-content">
        <WelcomeMessage />
        <Form horizontal onSubmit={this.handleSubmit}>
          <FormGroup controlId="formHorizontalEmail">
            <Col sm={10}>
              <FormControl type="email" placeholder="Email" name="email" onChange={this.updateEmail} value={this.state.email}/>
            </Col>
          </FormGroup>

          <FormGroup controlId="formHorizontalPassword">
            <Col sm={10}>
              <FormControl type="password" placeholder="Password" name="password" onChange={this.updatePassword} value={this.state.password}/>
            </Col>
          </FormGroup>

          <FormGroup>
            <Col smOffset={2} sm={10}>
              <Button className ="sign-in-button" type="submit">Log In</Button>
            </Col>
          </FormGroup>
        </Form>
      </div>
    )
  }
}

export default Login;
