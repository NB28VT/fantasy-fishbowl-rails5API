import React, {Component} from 'react';
import {
  Form,
  FormGroup,
  ControlLabel,
  FormControl
} from 'react-bootstrap';

class SongSearch extends Component {
  constructor(props) {
    super(props)
    this.state = ({
      songs: [],
      value: ""

    })
    this.handleChange = this.handleChange.bind(this);
  }

  // componentWillMount() {
  //   this.fetchSongs;
  // }


  handleChange(event) {
    this.setState(this.setState({value: event.target.value}))
    if (this.state.value.length > 2) {
      this.searchSongs();
    }
  }

  searchSongs() {
    fetch("/songs/search?query=" + this.state.value, {
      headers: {
        "Content-Type": "application/json",
        "Authorization": this.props.authToken
      }
    })
    .then((res) => res.json())
    .then((responseData) => {
        this.setState({songs: responseData["songs"]})
      }
    )
  }

  render() {
    const songs = this.state.songs.map((song) =>
      <li key={song.id}>{song.name}</li>
    );

    return(
      <div>
        <form>
         <FormGroup controlId="formBasicText">
           <ControlLabel>Set One Opener</ControlLabel>
           <FormControl
             type="text"
             value={this.state.value}
             placeholder="Enter Song Name"
             onChange={this.handleChange}
           />
         </FormGroup>
       </form>
       <ul>
         {songs}
       </ul>

      </div>

    )
  }
}




export default SongSearch;
