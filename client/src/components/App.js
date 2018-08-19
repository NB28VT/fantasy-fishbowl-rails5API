import React, { Component } from 'react';
import {
  BrowserRouter as Router,
  Route,
  Redirect
} from 'react-router-dom';
import Cookies from 'universal-cookie';
import '../stylesheets/app.css';

import Login from './Login';
import Concerts from './Concerts';
import NavBar from './NavBar';
import Dashboard from "./Dashboard";
import TourRankings from "./TourRankings";
import LandingPage from "./LandingPage";

const cookies = new Cookies();

const PrivateRoute = ({ component: Component, loggedIn, ...rest }) => (
  <Route
    {...rest}
    render={props =>
      loggedIn === true ? (
        <Component {...rest} {...props}  />
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
      <div className="app">
        <Router>
          <div>
            <NavBar logoutUser={this.logoutUser} loggedIn={this.state.loggedIn}/>
            <div className="inner-content">

              <Route exact path="/" render={() => (
                this.state.loggedIn ? (
                  <Redirect to="/home"/>
                ) : (
                  <LandingPage/>
                )
              )}/>

              <PrivateRoute path="/home" component={Dashboard} authToken={this.state.authToken} loggedIn={this.state.loggedIn}/>
              <Route path="/concerts" render={(props) => <Concerts {...props} loggedIn={this.props.loggedIn} />}/>
              <Route path="/leaderboard" component={TourRankings}/>
              <Route path="/login" render={(props) => <Login {...props} loginUser={this.loginUser} />}/>
            </div>
          </div>
        </Router>
      </div>
    );
  }
}

export default App;
