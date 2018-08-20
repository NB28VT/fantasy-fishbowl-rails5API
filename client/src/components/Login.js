import React, { Component } from 'react';
import {Redirect} from 'react-router-dom';
import {
  Form,
  FormGroup,
  Col,
  FormControl,
  Button,
  Alert
} from 'react-bootstrap';
import WelcomeLogo from "./WelcomeLogo";
import "../stylesheets/login.css"

class Login extends Component {
  constructor(props) {
    super(props);
    this.state = {
      redirectToReferrer: false,
      email: "",
      password: "",
      displaySignInError: false
    }

    this.updateEmail = this.updateEmail.bind(this);
    this.updatePassword = this.updatePassword.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleDismiss = this.handleDismiss.bind(this);
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
    .then((res) => {
      if (res.status === 401) {
        throw Error(res.statusText);
      }
      return res.json();
    })
    .then((responseData) => {
        this.props.loginUser(responseData["token"]);
        this.setState({
          redirectToReferrer: true,
          displaySignInError: false
        });

      }
    ).catch((error)=> {
      this.setState({displaySignInError: true})
    })
  }

  updateEmail(event) {
    this.setState({email: event.target.value})
  }

  updatePassword(event) {
    this.setState({password: event.target.value})
  }

  handleDismiss() {
    this.setState({displaySignInError: false})
  }

  render() {
    // Hardcode homepage redirect
    if (this.state.redirectToReferrer) {
      return(
        <Redirect to="/"/>
      )
    } else if(this.state.displaySignInError) {
      return (
        <div className="alert-message">
          <Alert bsStyle="danger" onDismiss={this.handleDismiss}>
           <h4>Invalid email or password, please try again.</h4>
          </Alert>
        </div>
      )
    }


    return(
      <div className="login-content">
        <WelcomeLogo />
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
