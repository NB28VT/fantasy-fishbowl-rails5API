import React, { Component } from "react";
import Downshift from "downshift";

class SongSelect extends Component {
  component(props) {
    this.state = {
      songID: null,
      songName: ""
    }

    this.updateSelection = this.updateSelection.bind(this)
  }

  updateSelection(selection) {
    console.log("Updating shit")
    this.setState({
      songID: selection.id,
      songName: selection.name
    })
  }



  render() {
    return(
      <Downshift
        onChange={selection => this.updateSelection(selection)}
        itemToString={item => (item ? item.value : '')}
      >
        {({
          getInputProps,
          getItemProps,
          getLabelProps,
          isOpen,
          inputValue,
          highlightedIndex,
          selectedItem,
        }) => (
          <div>
            <label {...getLabelProps()}>{this.props.category}</label>
            <input {...getInputProps()} />
            {isOpen ? (
              <div>
                {this.props.songs
                  .filter(item => !inputValue || item.name.toLowerCase().includes(inputValue.toLowerCase()))
                  .map((item, index) => (
                    <div
                      {...getItemProps({
                        key: item.name,
                        id: item.id,
                        index,
                        item,
                        style: {
                          backgroundColor:
                            highlightedIndex === index ? 'lightgray' : 'white',
                          fontWeight: selectedItem === item ? 'bold' : 'normal',
                          color: "black"
                        },
                      })}
                    >
                      {item.name}
                    </div>
                  ))}
              </div>
            ) : null}
          </div>
        )}
      </Downshift>
    )
  }
}



export default SongSelect;
