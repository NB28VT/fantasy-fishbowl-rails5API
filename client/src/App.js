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
const ProtectedPage = () => <h3>ProtectedPage</h3>

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
            <Link to="/public">Public Page</Link>
            <Link to="/protected">Protected Page</Link>
            <Link to="/login">Protected Page</Link>

            <Route path="/login" component={Login}></Route>
          </div>
        </Router>
      </div>
    );
  }
}

export default App;
