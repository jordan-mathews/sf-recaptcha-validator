# Salesforce reCAPTCHA Validator

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## Dependencies
- sf-integration-base


## Configuration / Setup

### Google Setup

1. Google Configuration
2. Go to [https://www.google.com/recaptcha](https://www.google.com/recaptcha)
3. Click on the ‘Admin console’ button
4. Click the ‘+’ create icon if you already have sites configured
5. Enter a Label and select reCAPTCHA v2 Checkbox.
6. Add your custom or force.com community domain. (You can also add 
7. additional domains so that it will function in Experience Builder)
8. Accept the terms of service and click the Submit button

Add the following script to the header markup in your community. Be sure to replace the "reCAPTCHA_site_key" with the site key from google. 

### Named Credential Setup

Add the secret key from google to the password field in the "reCAPTCHA" Named Credential.

### Experience Cloud Setup

~~~~
<!--reCaptcha v2 Checkbox-->
<script>
    var grecaptchaReady = false;
    var onloadCallback = function(){ grecaptchaReady = true; };
    var verifyCallback = function(token) {
        document.dispatchEvent(new CustomEvent('grecaptchaVerified', {'detail': {response: token}}));
    };
    var expireCallback = function() {
        document.dispatchEvent(new Event('grecaptchaExpired'));
    };
    var errorCallback = function() {
        document.dispatchEvent(new Event('grecaptchaError'));
    };
    document.addEventListener('grecaptchaRender', function(e) {
        onloadCallback = function() {
            grecaptchaReady = true;
            grecaptcha.render(e.detail.element, {
                'sitekey': 'reCAPTCHA_site_key',
                'callback': verifyCallback,
                'expired-callback': expireCallback,
                'error-callback': errorCallback
            });
        };
        if (grecaptchaReady) {
            onloadCallback();
        }
    });
    document.addEventListener('grecaptchaReset', function() {
        grecaptcha.reset();
    }); 
</script>
<script src='https://www.google.com/recaptcha/api.js?render=explicit&onload=onloadCallback' async defer></script>
~~~~

You will see Content Security Policy (CSP) errors as you implement reCAPTCHA. In Experience Builder → Settings → Security, add the trusted sites shown below and click the ‘Whitelist’ button as items show in the ‘CSP Errors’ list.

## Usage

The `recaptchaValidator` component can be used in other Ligtning components. 
```
<c-recaptcha-validator></c-recaptcha-validator>
```

Before submitting a form the reCAPTCHA validation satus can be checked by accessing the isValid property.

~~~~

  handleSubmit(event) {
    event.preventDefault();

    if (this.template.querySelector('c-recaptcha-validator').isValid) {
      // insert record
    } else {
      // handle invalid reCAPTCHA
    }
  }

~~~~