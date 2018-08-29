import React, {Component} from "react";
import {
  FormGroup,
  ControlLabel,
  FormControl
} from 'react-bootstrap';

class SongSelect extends Component {
  constructor(props) {
    super(props)
    this.updateSelection = this.updateSelection.bind(this)
  }

  updateSelection(e) {
    const songID = e.target.value;
    this.props.updateSelectionForm(songID, this.props.categoryID);
  }

  // TODO: keep track of selected here, keep state in prediction form component
  render() {
    const songOptions = this.props.songs.map((song) => {
      return(<option key={song.id} value={song.id}>{song.name}</option>)
    })

    return(
      <FormGroup>
        <ControlLabel>{this.props.categoryName}</ControlLabel>
        <FormControl componentClass="select" placeholder="Select" onChange={this.updateSelection}>
          {songOptions}
        </FormControl>
      </FormGroup>
    )
  }
}

export default SongSelect;
