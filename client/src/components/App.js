import React, { Component } from 'react';
import {
  BrowserRouter as Router,
  Route,
  Link,
  Redirect
} from 'react-router-dom';
import Login from './Login';
import Concerts from './Concerts';
import Cookies from 'universal-cookie';

const cookies = new Cookies();

const PrivateRoute = ({ component: Component, ...rest }) => (
  <Route
    {...rest}
    render={props =>
      authTracker.loggedIn? (
        <Component {...props} {...rest} />
      ) : (
        <Redirect
          to={{
            pathname: "/login",
            state: { from: props.location }
          }}
        />
      )
    }
  />
);

// React router recommends this stays outside of state. Hmm.
const authTracker = {
  loggedIn: false
}

class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      authToken: ""
    }

    this.loginUser = this.loginUser.bind(this)
    this.logoutUser = this.logoutUser.bind(this)
  }

  componentWillMount(){
    let authToken = cookies.get("token");
    if (typeof authToken !== 'undefined') {
      this.setState({authToken: authToken})
      authTracker.loggedIn = true;
    }
  }

  loginUser(authToken) {
    this.setState({authToken})
    cookies.set("token", authToken, {path: "/"})
    authTracker.loggedIn = true;
  }

  logoutUser() {
    cookies.remove("token", {path: "/"})
    this.setState({authToken: ""})
    authTracker.loggedIn = false;
  }

  render() {
    return (
      <div >
        <Router>
          <div>
            {/* TODO: navbar here */}
            <ul>
              {/* <li><Link to="/concerts/upcoming">Upcoming Shows</Link></li> */}
              <li><Link to="/concerts">Shows</Link></li>
              <li onClick={this.logoutUser}>Logout</li>
              {/* <li><Link to="/login">Login</Link></li> */}
            </ul>
              <PrivateRoute path="/concerts" component={Concerts} authToken={this.state.authToken}></PrivateRoute>
              <Route path="/login" render={(props) => <Login loginUser={this.loginUser}/>}></Route>
          </div>
        </Router>
      </div>
    );
  }
}

export default App;
