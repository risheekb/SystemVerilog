This example is for the uvm_component_param_utils macro.

Run the example with:
	% make

The class usb_env is parameterized with the type of agent, so it
starts with the following two lines.

class usb_env #(type AGT=int) extends uvm_env;
  `uvm_component_param_utils (usb_env #(AGT) )

Notice that the macro only takes one argument, the class name plus parameters.

This class is used in the usb_test class. It declare the env handle,
specialized with the usb_agent class name.

   usb_env #(usb_agent) env;

When the test builds the environment, it needs to add the usb_agent
class name.

      env = usb_env#(usb_agent)::type_id::create("env", this);
