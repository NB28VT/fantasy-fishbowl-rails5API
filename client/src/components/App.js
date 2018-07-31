import React, { Component } from 'react';
import {
  BrowserRouter as Router,
  Route,
  Redirect,
  withRouter
} from 'react-router-dom';
import Login from './Login';
import Concerts from './Concerts';
import NavBar from './NavBar'
import Cookies from 'universal-cookie';

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
  }

  componentWillMount(){
    let authToken = cookies.get("token");
    if (typeof authToken !== 'undefined') {
      this.setState({
        authToken: authToken,
        loggedIn: true
      })
    }
  }

  loginUser(authToken) {
    this.setState({
      authToken: authToken,
      loggedIn: true
    })
    cookies.set("token", authToken, {path: "/"})
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
      <div >
        <Router>
          <div>
            <NavBar logoutUser={this.logoutUser} loggedIn={this.state.loggedIn}></NavBar>
            <PrivateRoute path="/concerts" component={Concerts} authToken={this.state.authToken} loggedIn={this.state.loggedIn}></PrivateRoute>
            <Route path="/login" render={(props) => <Login {...props} loginUser={this.loginUser} />}></Route>
          </div>
        </Router>
      </div>
    );
  }
}

export default App;
