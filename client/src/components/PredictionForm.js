import React, {Component} from "react";
import {
  Form,
  FormGroup,
  Col,
  FormControl,
  ControlLabel,
  Button
} from 'react-bootstrap';
import SongSearch from "./SongSearch";

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

    // this.fetchPredictionCategories();
  }

  // fetchPredictionCategories() {
  //   fetch("/prediction_categories",{
  //     headers: {"Content-Type": "application/json"}
  //   })
  //   .then((res) => res.json())
  //   .then((responseData) => {
  //     // TODO: error handling
  //     this.setState({
  //       predictionCategories: responseData["prediction_categories"]
  //     })
  //   })
  // }


  render() {
    const categories = this.state.predictionCategories.map((category) =>
      <Col sm={10}>
        <ControlLabel>{category.name}</ControlLabel>
        <SongSearch/>
        {/* <FormControl label="test" type="text" placeholder="Enter Song" name={category.id}/> */}
      </Col>
    )

    return(
      <Form horizontal>
        <FormGroup controlId="formHorizontalEmail">
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
