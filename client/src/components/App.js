import React, { Component } from 'react';
import {
  BrowserRouter as Router,
  Route,
  Switch,
  Redirect
} from 'react-router-dom';
import Cookies from 'universal-cookie';
import '../stylesheets/app.css';

import Login from './Login';
import Concerts from './Concerts';
import NavBar from './NavBar'
import Dashboard from "./Dashboard";

const cookies = new Cookies();

const PrivateRoute = ({ component: Component, ...rest }) => (
  <Route
    {...rest}
    render={props =>
      props.loggedIn? (
        <Component {...props} {...rest} />
      ) : (
        <Redirect to={{pathname: "/login"}}
        />
      )
    }
  />
);

class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      authToken: "",
      loggedIn: false
    }

    this.loginUser = this.loginUser.bind(this)
    this.logoutUser = this.logoutUser.bind(this)

    this.checkCookie = this.checkCookie.bind(this)
  }

  checkCookie() {
    let authToken = cookies.get("token");
    if (typeof authToken !== 'undefined') {
      this.setState({
        authToken: authToken,
        loggedIn: true
      })
    }
  }

  componentWillMount(){
    this.checkCookie();
  }

  loginUser(authToken) {
    this.setState({
      authToken: authToken,
      loggedIn: true
    })
    cookies.set("token", authToken, {path: "/"})
    console.log("Logged in");
  }

  logoutUser() {
    cookies.remove("token", {path: "/"})
    this.setState({
      authToken: "",
      loggedIn: false
    })
  }

  render() {
    return (
      <div className="main-content">
        <Router>
          <div>
            <NavBar logoutUser={this.logoutUser} loggedIn={this.state.loggedIn}></NavBar>
            <PrivateRoute exact path="/" loggedIn={this.state.loggedIn} component={Dashboard}></PrivateRoute>
            <PrivateRoute path="/concerts" component={Concerts} authToken={this.state.authToken} loggedIn={this.state.loggedIn}></PrivateRoute>
            <Route path="/login" render={(props) => <Login {...props} loginUser={this.loginUser} />}></Route>
          </div>
        </Router>
      </div>
    );
  }
}

export default App;
