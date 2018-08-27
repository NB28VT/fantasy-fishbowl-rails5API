import React, {Component} from "react";
import {
  FormGroup,
  ControlLabel,
  FormControl
} from 'react-bootstrap';

class SongSelect extends Component {
  render() {
    const songOptions = this.props.songs.map((song) => {
      return(<option key={song.id} value={song.id}>{song.name}</option>)
    })

    return(
      <FormGroup>
        <ControlLabel>{this.props.categoryName}</ControlLabel>
        <FormControl componentClass="select" placeholder="Select">
          {songOptions}
        </FormControl>
      </FormGroup>
    )
  }
}

export default SongSelect;
