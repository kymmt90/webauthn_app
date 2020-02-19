import { Controller } from 'stimulus'
import { create } from '@github/webauthn-json'
import { csrfToken } from '@rails/ujs'

export default class extends Controller {
  static targets = ['uid']

  createCredential(event) {
    const [data, status, xhr] = event.detail

    const uid = this.uidTarget.value

    const response = create({ publicKey: data }).then(function(credential) {
      fetch('/users', {
        method: 'post',
        body: JSON.stringify({ user: { 'uid': uid, 'public_key_credential': credential } }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-CSRF-Token': csrfToken()
        },
        credentials: 'same-origin'
      }).then(function(response) {
        if (response.status === 201) {
          console.log('Sign up succeeded')
          console.log(response)

          window.location = `/users/${uid}`
        } else {
          console.log('Sign up failed')
          console.log(response)
        }
      })
    }).catch(function(error) {
      console.log('Credential creation failed')
      console.log(error)
    })
  }
}
