import React, {Component} from 'react';

class SongSearch extends Component {
  constructor(props) {
    super(props)
    this.state = ({
      songs: [],
      value: ""

    })
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(event) {
    this.setState(this.setState({value: event.target.value}))

    if (this.state.value.length > 2) {
      this.searchSongs();
    } else {
      this.setState({songs: []})
    }
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

    return(
      <div>
        <input type="text" list="songlist" value={this.state.value} onChange={this.handleChange}></input>
        <datalist id="songlist">
          {songs}
        </datalist>
      </div>
    )

  }
}

export default SongSearch;
