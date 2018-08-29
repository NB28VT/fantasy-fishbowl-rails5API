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
      songs: [],
      categorySelections: []
    }
    this.fetchPredictionCategories = this.fetchPredictionCategories.bind(this)
    this.fetchSongList = this.fetchSongList.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
    this.updateSelection = this.updateSelection.bind(this)
  }

  componentDidMount() {
    this.fetchPredictionCategories();
    this.fetchSongList();
  }

  fetchPredictionCategories() {
    fetch("/prediction_categories",{
      headers: {"Content-Type": "application/json"}
    })
    .then((res) => res.json())
    .then((responseData) => {
      // TODO: error handling
      const categorySelections = {}
      responseData["prediction_categories"].map((category) =>
        categorySelections[category.id] = {song_id: 1}
      )

      this.setState({
        predictionCategories: responseData["prediction_categories"],
        categorySelections: categorySelections
      })
    })
  }

  fetchSongList() {
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

  buildPredictionSubmission() {
    const predictionBody = {concert_prediction: {
        song_predictions_attributes: []
      }
    }
    // TODO: build body for prediciton using the category selections
  }

  updateSelection(songID, categoryID) {
    // Possibly tie to state in selection for each. But does React Bootstrap take care of that for us?

    const categorySelections = {...this.state.categorySelections}
    categorySelections[categoryID]["song_id"] = Number(songID)
    this.setState({
      categorySelections: categorySelections
    })
  }

  handleSubmit() {
    // TODO: allow editing submissions (track in state)
    const endpoint = `concerts/${this.props.concertID}/predictions`;
    const predictionData = this.buildPredictionSubmission();

    fetch(endpoint, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": this.props.authToken
      },
      body: predictionData

    }).then((res) => {
      if (res.status === 401) {
        throw Error(res.statusText);
      }
      return res.json();
    })
    .then((responseData) => {
      // Notify user prediction submitted
      alert("Aw yeah prediction submitted!");
      }
    ).catch((error)=> {
      // TODO: Display some type of sign in error
      // this.setState({displaySignInError: true})
    })
  }

  render() {
    const categories = this.state.predictionCategories.map((category) =>
      <Col className="prediction-category" key={category.id} sm={10} >
        <SongSelect categoryName={category.name} categoryID={category.id} updateSelectionForm={this.updateSelection} songs={this.state.songs}/>
      </Col>
    )

    return(
      <Form horizontal className="prediction-form" onSubmit={this.handleSubmit}>
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
