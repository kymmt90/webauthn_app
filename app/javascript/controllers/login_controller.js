import { Controller } from 'stimulus'
import { get } from '@github/webauthn-json'
import { csrfToken } from '@rails/ujs'

export default class extends Controller {
  static targets = ['uid']

  authenticate(event) {
    const [data, status, xhr] = event.detail
    const uid = this.uidTarget.value

    const response = get({ publicKey: data }).then(function(credential) {
      fetch('/session', {
        method: 'post',
        body: JSON.stringify({ session: { 'uid': uid, 'public_key_credential': credential } }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-CSRF-Token': csrfToken()
        },
        credentials: 'same-origin'
      }).then(function(response) {
        if (response.status === 204) {
          window.location = '/credentials'
        } else {
          console.log('Log in failed')
          console.log(response)
        }
      })
    }).catch(function(error) {
      console.log('Credential creation failed')
      console.log(error)
    })
  }
}
