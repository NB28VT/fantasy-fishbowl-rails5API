import React from 'react';
import "../stylesheets/welcome-logo.css"
import vertLogo from "../images/yellow-logo-vertical.png"

const WelcomeLogo = () => {
  return(
    <div className="welcome-message">
      <img alt="logo" width="100%" src={vertLogo}></img>
      <p>The Setlist Prediction Game</p>
    </div>
  )
}
export default WelcomeLogo;
