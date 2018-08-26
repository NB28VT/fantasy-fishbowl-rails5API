import React, {Component} from "react";
import {Route, Switch} from 'react-router-dom';
import ConcertList from './ConcertList'
import Concert from './Concert'


class Concerts extends Component {
  render() {
    return(
      <div>
        <Switch>
          <Route exact path="/concerts" render={(props) => <ConcertList upcomingOnly={false}/>}></Route>
          <Route path="/concerts/upcoming" render={(props) => <ConcertList upcomingOnly={true}/>}></Route>
          <Route exact path="/concerts/:id" render={(props) => <Concert authToken={this.props.authToken} loggedIn={this.props.loggedIn} {...props}/>}></Route>
        </Switch>
      </div>
    )
  }
}

export default Concerts;
