import { LightningElement, api } from 'lwc';
import verifyRecaptcha from '@salesforce/apex/RecaptchaValidatorController.validate';

export default class RecaptchaValidator extends LightningElement {
  recaptchaValidationStatus;

  connectedCallback() {
    document.addEventListener('grecaptchaVerified', (e) => {
      verifyRecaptcha({ recaptchaResponse: e.detail.response })
        .then((result) => {
          this.recaptchaValidationStatus = result;
        })
        .catch((error) => {
          console.error(error);
        });
    });
    document.addEventListener('grecaptchaExpired', () => {
      this.recaptchaValidationStatus = false;
    });
  }

  renderedCallback() {
    var divElement = this.template.querySelector('div.recaptchaV2Checkbox');
    var payload = { element: divElement, badge: 'bottomright' };
    document.dispatchEvent(new CustomEvent('grecaptchaRender', { detail: payload }));
  }

  @api
  get isValid() {
    return this.recaptchaValidationStatus;
  }
}