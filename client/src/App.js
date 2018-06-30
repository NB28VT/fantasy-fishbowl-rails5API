import React, { Component } from 'react';
import {
  BrowserRouter as Router,
  Route,
  Link,
  Redirect
} from 'react-router-dom';
import Login from './Login';

import logo from './logo.svg';
import './App.css';

// Fake Auth service to get replaced with real auth
// once this is all hooked up
const fakeAuth = {
  isAuthenticated: false,
  authenticate(callback) {
    this.isAuthenticated = true;
    // Fake an async call to login
    setTimeout(callback, 100);
  },
  signOut(callback) {
    this.isAuthenticated = false;
    setTimeout(callback, 100);
  }
}

const PublicPage = () => <h3>PublicPage</h3>
const Protected = () => <h3>ProtectedPage</h3>

const PrivateRoute = ({component: Component, ...rest}) => (
  // This is a crap solution React Router, TODO: find a better auth paradigm
  <Route {...rest} render={(props) =>(
    fakeAuth.isAuthenticated === true
    ? <Component {...props}/>
    : <Redirect to="/login" />
  )}/>
)

class App extends Component {
  // componentDidMount() {
  //   window.fetch("concerts")
  //   .then(response => response.json())
  //   .then(json => console.log(json))
  //   .catch(error => console.log(error))
  // }



  render() {
    return (
      <div >
        <Router>
          <div>
            <ul>
              <li><Link to="/public">Public Page</Link></li>
              <li><Link to="/protected">Protected Page</Link></li>
              <li><Link to="/login">Login</Link></li>
            </ul>

            <Route path="/public" component={Login}></Route>
            <Route path="/login" component={Login}></Route>
            <PrivateRoute path="/protected" component={Protected} />
          </div>
        </Router>
      </div>
    );
  }
}

export default App;
