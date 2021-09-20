public with sharing class RecaptchaValidatorController {
  @AuraEnabled
  public static Boolean validate(String recaptchaResponse) {
    RecaptchaValidationService.ResponseWrapper response = new RecaptchaValidationService.ResponseWrapper();

    try {
      RecaptchaValidationService service = new RecaptchaValidationService();
      response = service.validateV2Checkbox(recaptchaResponse);
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }

    return response.success;
  }
}
