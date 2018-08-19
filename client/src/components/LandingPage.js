import React, {Component} from "react";
import WelcomeLogo from "./WelcomeLogo";
import '../stylesheets/landing-page.css';

class LandingPage extends Component {

  render() {
    return(
      <div className="landing-page-content">
        <WelcomeLogo />
      </div>
    )
  }
}

export default LandingPage;
