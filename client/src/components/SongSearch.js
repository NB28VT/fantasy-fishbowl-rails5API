import React, {Component} from 'react';
import { debounce } from "debounce";

class SongSearch extends Component {
  constructor(props) {
    super(props)
    this.state = ({
      songs: [],
      value: ""

    })
    this.handleChange = this.handleChange.bind(this);
    this.checkSongInput = this.checkSongInput.bind(this);
  }

  checkSongInput() {
    if (this.state.value.length > 2) {
      this.searchSongs();
    } else {
      this.setState({songs: []})
    }
  }

  handleChange(event) {
    this.setState({value: event.target.value});
    debounce(this.checkSongInput(), 200, true);
  }

  searchSongs() {
    fetch("/songs/search?query=" + this.state.value, {
      headers: {
        "Content-Type": "application/json"
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
      <option key={song.id} value={song.name}/>
    );

    const listID = "songlist-" + this.props.categoryName;

    return(
      <div>
        <input type="text" list={listID} value={this.state.value} onChange={this.handleChange}></input>
        <datalist id={listID}>
          {songs}
        </datalist>
      </div>
    )

  }
}

export default SongSearch;
