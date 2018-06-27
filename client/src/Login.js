import React, { Component } from 'react';
import { Form } from 'react-bootstrap';
import { FormGroup } from 'react-bootstrap';
import { Col } from 'react-bootstrap';
import { ControlLabel } from 'react-bootstrap';
import { FormControl } from 'react-bootstrap';
import { Checkbox } from 'react-bootstrap';
import { Button } from 'react-bootstrap';
class Login extends Component {

    render() {
      return (
        <div>
          LOGIN
        </div>
      )

      // return(
      //   <Form horizontal>
      //     <FormGroup controlId="formHorizontalEmail">
      //       <Col componentClass={ControlLabel} sm={2}>
      //         Email
      //       </Col>
      //       <Col sm={10}>
      //         <FormControl type="email" placeholder="Email" />
      //       </Col>
      //     </FormGroup>
      //
      //     <FormGroup controlId="formHorizontalPassword">
      //       <Col componentClass={ControlLabel} sm={2}>
      //         Password
      //       </Col>
      //       <Col sm={10}>
      //         <FormControl type="password" placeholder="Password" />
      //       </Col>
      //     </FormGroup>

          {/* <FormGroup>
            <Col smOffset={2} sm={10}>
              <Checkbox>Remember me</Checkbox>
            </Col>
          </FormGroup> */}

      //     <FormGroup>
      //       <Col smOffset={2} sm={10}>
      //         <Button type="submit">Sign in</Button>
      //       </Col>
      //     </FormGroup>
      //   </Form>
      // )
    }

}

export default Login;
