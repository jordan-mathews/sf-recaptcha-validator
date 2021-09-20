public inherited sharing class RecaptchaValidationService {
  public ResponseWrapper validateV2Checkbox(String recaptchaResponse) {
    CalloutController controller = new CalloutController();
    controller.initRequest('GOOGLE_reCAPTCHA', 'VALIDATE_V2_INVISIBLE');
    controller.setBody('secret=' + '{!$Credential.Password}' + '&response=' + recaptchaResponse);
    controller.sendRequest();

    ResponseWrapper response = new ResponseWrapper();

    if (controller.getResponse().getStatusCode() == 200) {
      String responseBody = controller.getResponse().getBody();
      response = parse(responseBody);
    } else {
      response.success = false;
      response.error = controller.getResponse().getBody();
    }
    return response;
  }

  public class ResponseWrapper {
    @AuraEnabled
    public Boolean success;
    @AuraEnabled
    public String hostname;
    @AuraEnabled
    public String challenge_ts;
    @AuraEnabled
    public String error;
  }

  private static ResponseWrapper parse(String json) {
    ResponseWrapper response = (ResponseWrapper) System.JSON.deserialize(json, ResponseWrapper.class);
    return response;
  }
}
