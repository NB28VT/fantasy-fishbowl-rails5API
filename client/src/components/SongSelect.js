import React, { Component } from "react";
import Select from "react-select";
class SongSelect extends Component {
  constructor(props) {
    super(props)
    this.state = {
      selectedOption: null,
      songOptions: []
    }
  }

  componentDidMount() {
    console.log("did mount")
    if (this.props.songs.length > 0) {
      const options = this.props.songs.map((song) =>
        ({value: song.id, label: song.name})
      )

      this.setState({songOptions: options})
    }

  }

  handleChange = (selectedOption) => {
     this.setState({ selectedOption });
     console.log(`Option selected:`, selectedOption);
   }

   render() {
     const { selectedOption, songOptions } = this.state;

     return (
       <Select
         value={selectedOption}
         onChange={this.handleChange}
         options={songOptions}
       />
     );
   }
}

// import Downshift from "downshift";
//
// class SongSelect extends Component {
//   component(props) {
//     this.state = {
//       songID: null,
//       songName: ""
//     }
//
//     this.updateSelection = this.updateSelection.bind(this)
//   }
//
//   updateSelection(selection) {
//     console.log("Updating shit")
//     this.setState({
//       songID: selection.id,
//       songName: selection.name
//     })
//   }
//
//
//
//   render() {
//     return(
//       <Downshift
//         onChange={selection => this.updateSelection(selection)}
//         itemToString={item => (item ? item.value : '')}
//       >
//         {({
//           getInputProps,
//           getItemProps,
//           getLabelProps,
//           isOpen,
//           inputValue,
//           highlightedIndex,
//           selectedItem,
//         }) => (
//           <div>
//             <label {...getLabelProps()}>{this.props.category}</label>
//             <input {...getInputProps()} />
//             {isOpen ? (
//               <div>
//                 {this.props.songs
//                   .filter(item => !inputValue || item.name.toLowerCase().includes(inputValue.toLowerCase()))
//                   .map((item, index) => (
//                     <div
//                       {...getItemProps({
//                         key: item.name,
//                         id: item.id,
//                         index,
//                         item,
//                         style: {
//                           backgroundColor:
//                             highlightedIndex === index ? 'lightgray' : 'white',
//                           fontWeight: selectedItem === item ? 'bold' : 'normal',
//                           color: "black"
//                         },
//                       })}
//                     >
//                       {item.name}
//                     </div>
//                   ))}
//               </div>
//             ) : null}
//           </div>
//         )}
//       </Downshift>
//     )
//   }
// }



export default SongSelect;
