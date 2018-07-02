import React, { Component } from 'react';
import {Redirect} from 'react-router-dom';
import {
  Form,
  FormGroup,
  Col,
  ControlLabel,
  FormControl,
  Button
} from 'react-bootstrap';

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
    // this.loginUser = this.loginUser.bind(this);
  }

  // loginUser(token){
  //   debugger;
  //   // Figure out how to use parent function again
  //   this.props.loginUser(token);
  // }

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
        this.props.loginUser(responseData["token"]);
        this.setState({redirectToReferrer: true})
        // If login is successful
        // update token in app state
        // update loggedin to true
        // update login state to redirect to refferer

      }
    )
  }

  updateEmail(event) {
    this.setState({email: event.target.value})
  }

  updatePassword(event) {
    this.setState({password: event.target.value})
  }

  render() {
    // Props location not being passed. Default to main route for now
    // const { from } = this.props.location || { from: { pathname: '/' } }
    // const { redirectToReferrer } = this.state;

    if (this.state.redirectToReferrer) {
      return(
        <Redirect to={"/"}/>
      )
    }

    return(
      <Form horizontal onSubmit={this.handleSubmit}>
        <FormGroup controlId="formHorizontalEmail">
          <Col componentClass={ControlLabel} sm={2}>
            Email
          </Col>
          <Col sm={10}>
            <FormControl type="email" placeholder="Email" name="email" onChange={this.updateEmail} value={this.state.email}/>
          </Col>
        </FormGroup>

        <FormGroup controlId="formHorizontalPassword">
          <Col componentClass={ControlLabel} sm={2}>
            Password
          </Col>
          <Col sm={10}>
            <FormControl type="password" placeholder="Password" name="password" onChange={this.updatePassword} value={this.state.password}/>
          </Col>
        </FormGroup>

        <FormGroup>
          <Col smOffset={2} sm={10}>
            <Button type="submit">Sign in</Button>
          </Col>
        </FormGroup>
      </Form>
    )
  }
}

export default Login;
