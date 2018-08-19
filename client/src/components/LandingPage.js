import React, {Component} from "react";
import WelcomeLogo from "./WelcomeLogo";
import '../stylesheets/landing-page.css';

class LandingPage extends Component {

  render() {
    return(
      <div className="landing-page-content">
        <WelcomeLogo />
        <p>Fantasy Fishbowl is currently under construction.</p>
        <p>Please contact burgess.nathan28@gmail.com for inquiries about obtaining a login.</p>
      </div>
    )
  }
}

export default LandingPage;
