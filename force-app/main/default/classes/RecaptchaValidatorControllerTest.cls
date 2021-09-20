@isTest
public class RecaptchaValidatorControllerTest {
  @isTest
  static void success() {
    CalloutMock mock = new CalloutMock();
    mock.setMock(200, 'OK', 'VALIDATE_V2_INVISIBLE');

    Boolean success;

    Test.startTest();
    success = RecaptchaValidatorController.validate('FAKE RESPONSE');
    Test.stopTest();

    System.assertEquals(true, success, 'Successfull validation');
  }
}
