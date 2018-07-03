import React, { Component } from 'react';
import {
  BrowserRouter as Router,
  Route,
  Link,
  Redirect,
  Switch
} from 'react-router-dom';
import Login from './Login';
import Concerts from './Concerts'
import Concert from './Concert'


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
    };
    this.loginUser = this.loginUser.bind(this)
  }

  loginUser(token) {
    this.setState({authToken: token})
    authTracker.loggedIn = true;
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
              {/* <li><Link to="/login">Login</Link></li> */}
            </ul>
            <Switch>
              <PrivateRoute path="/concerts" component={Concerts} authToken={this.state.authToken}></PrivateRoute>
              <PrivateRoute path="/concerts/:id" component={Concert}></PrivateRoute>
              <Route path="/login" render={(props) => <Login loginUser={this.loginUser}/>}></Route>
            </Switch>
          </div>
        </Router>
      </div>
    );
  }
}

export default App;
