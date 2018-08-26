import React, {Component} from "react";
import {
  Form,
  FormGroup,
  Col,
  ControlLabel,
  Button
} from 'react-bootstrap';
import SongSelect from "./SongSelect";
import "../stylesheets/prediction-form.css"

class PredictionForm extends Component {
  constructor(props) {
    super(props)
    this.state = {
      predictionCategories: [],
      songs: []
    }

    this.loadPredictionCategories = this.loadPredictionCategories.bind(this);
    this.loadSongList = this.loadSongList.bind(this);
  }

  componentDidMount() {
    // Makre sure this only runs once
    this.loadPredictionCategories();
    this.loadSongList();
  }


  loadPredictionCategories() {
    console.log("Loading prediction categories");
    fetch("/prediction_categories",{
      headers: {"Content-Type": "application/json"}
    })
    .then((res) => res.json())
    .then((responseData) => {
      // TODO: error handling
      this.setState({
        predictionCategories: responseData["prediction_categories"]
      })
    })
  }

  loadSongList() {
    console.log("Loading song list");
    fetch("/songs",{
      headers: {"Content-Type": "application/json"}
    })
    .then((res) => res.json())
    .then((responseData) => {
      this.setState({
        songs: responseData["songs"]
      })
    })
  }

  render() {
    const categories = this.state.predictionCategories.map((category) =>
      <Col className="prediction-category" key={category.id} sm={10} >
        <SongSelect category={category.name} songs={this.state.songs}/>
      </Col>
    )

    return(
      <Form horizontal className="prediction-form">
        <FormGroup>
          {categories}
        </FormGroup>

        <FormGroup>
          <Col smOffset={2} sm={10}>
            <Button className ="sign-in-button" type="submit">Submit</Button>
          </Col>
        </FormGroup>
      </Form>
    )
  }
}

export default PredictionForm;
