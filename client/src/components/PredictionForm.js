import React, {Component} from "react";
import {
  Form,
  FormGroup,
  Col,
  ControlLabel,
  Button
} from 'react-bootstrap';
import SongSearch from "./SongSearch";
import "../stylesheets/prediction-form.css"

class PredictionForm extends Component {
  constructor(props) {
    super(props)
    this.state = {
      predictionCategories: []
    }
  }

  componentDidMount() {
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

  render() {
    const categories = this.state.predictionCategories.map((category) =>
      <Col className="prediction-category" key={category.id} sm={10} >
        <ControlLabel>{category.name}</ControlLabel>
        <SongSearch categoryName={category.name}/>
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
