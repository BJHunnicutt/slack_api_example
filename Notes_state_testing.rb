
More specifics about what I found for the 'response' variable in the controller test:

  (http://api.rubyonrails.org/v4.2/classes/ActionController/TestCase.html)
  "The ActionController::TestCase will also automatically provide the following instance variables for use in the tests:"
      @controller - The controller processing the request
      @request - The request object
      @response - The response object

      (http://api.rubyonrails.org/classes/ActionDispatch/Response.html)
      That link explains response in more detail (which you have access to with or without the @ symbol, unlike @controller and @request)

  To see all the things you can access with these variables, require 'awesome_print' in your controller test and put one of these inside a test:
      ap @controller.methods
      ap @response.methods
      ap @request.methods

  Things I found super useful:
      @response.status
      @controller.params
        OR for one:  @controller.params[:pet]
      @controller.instance_variables
        OR for one: @controller.instance_variable_get(:@total)

I found all that in a rabbit hole I went into after reading this stackoverflow question:
  http://stackoverflow.com/questions/8160284/how-to-test-params-passed-into-a-controller-in-rails-3-using-rspec
