@isTest
public class RecaptchaValidationServiceTest {
  @isTest
  static void validateSuccess() {
    CalloutMock mock = new CalloutMock();
    mock.setMock(200, 'OK', 'VALIDATE_V2_INVISIBLE');

    RecaptchaValidationService service = new RecaptchaValidationService();
    RecaptchaValidationService.ResponseWrapper response = new RecaptchaValidationService.ResponseWrapper();

    Test.startTest();
    response = service.validateV2Checkbox('fake reCAPTCHA response');
    Test.stopTest();

    System.assertEquals(true, response.success, 'Successfull validation');
  }

  @isTest
  static void validateError() {
    CalloutMock mock = new CalloutMock();
    mock.setMock(500, 'Internal Server Error', 'VALIDATE_V2_INVISIBLE');

    RecaptchaValidationService service = new RecaptchaValidationService();
    RecaptchaValidationService.ResponseWrapper response = new RecaptchaValidationService.ResponseWrapper();

    Test.startTest();
    response = service.validateV2Checkbox('fake reCAPTCHA response');
    Test.stopTest();

    System.assertEquals(false, response.success, 'Unsuccessful validation');
  }
}
