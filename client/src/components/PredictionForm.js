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
    debugger;
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
    const endpoint = `concerts/${this.props.concertID}/predictions`;
    // Need auth header for token (backend assigns token ID)
    




    debugger;
    // post "/concerts/#{concert.id}/predictions", params: {
    //   concert_prediction: {
    //     song_predictions_attributes: [
    //       {
    //         song_id: songs.first.id,
    //         prediction_category_id: prediction_category.id
    //       }
    //     ]
    //   }
    // debugger;
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
