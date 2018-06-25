import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';

class App extends Component {
  componentDidMount() {
    window.fetch("concerts")
    .then(response => response.json())
    .then(json => console.log(json))
    .catch(error => console.log(error))
  }


  render() {
    return (
      <div >

      </div>
    );
  }
}

export default App;
