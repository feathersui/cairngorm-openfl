package com.feathersui.cafetownsend.view;

import com.adobe.cairngorm.control.CairngormEventDispatcher;
import com.feathersui.cafetownsend.control.LoginEvent;
import com.feathersui.cafetownsend.model.AppModelLocator;
import feathers.controls.Button;
import feathers.controls.Form;
import feathers.controls.FormItem;
import feathers.controls.Header;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.Panel;
import feathers.controls.TextInput;
import feathers.events.TriggerEvent;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;

class EmployeeLogin extends LayoutGroup {
	private var model = AppModelLocator.getInstance();
	private var login_frm:Form;
	private var username:TextInput;
	private var password:TextInput;
	private var login_btn:Button;

	public function new() {
		super();
	}

	override private function initialize():Void {
		super.initialize();

		layout = new AnchorLayout();

		var panel = new Panel();
		panel.layoutData = AnchorLayoutData.center();
		panel.layout = new AnchorLayout();
		panel.header = new Header("Cafe Townsend Login");
		addChild(panel);

		login_frm = new Form();
		login_frm.layoutData = AnchorLayoutData.fill(10.0);
		panel.addChild(login_frm);

		username = new TextInput();
		var usernameItem = new FormItem("Username:", username, true);
		usernameItem.horizontalAlign = JUSTIFY;
		login_frm.addChild(usernameItem);

		password = new TextInput();
		password.displayAsPassword = true;
		var passwordItem = new FormItem("Password:", password, true);
		passwordItem.horizontalAlign = JUSTIFY;
		login_frm.addChild(passwordItem);

		login_btn = new Button();
		login_btn.text = "Login";
		login_btn.addEventListener(TriggerEvent.TRIGGER, login_btn_triggerHandler);
		login_frm.addChild(login_btn);

		var footer = new LayoutGroup();
		footer.variant = LayoutGroup.VARIANT_TOOL_BAR;
		var instructions = new Label();
		instructions.text = "Username: Feathers   Password: Cairngorm";
		footer.addChild(instructions);
		panel.footer = footer;
	}

	// mutate the loginBtn's click event into a cairngorm event
	private function loginEmployee():Void {
		// validate the fields
		var noUsername = username.text == null || username.text.length == 0;
		var noPassword = password.text == null || password.text.length == 0;
		if (noUsername || noPassword) {
			return;
		} else {
			// if everything validates, broadcast an event containing the username & password
			var cgEvent = new LoginEvent(username.text, password.text);
			CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);

			// now that the fields are sent in the event, blank out the login form fields
			// otherwise they'll still be populated whenever the user returns here
			// (if the user does not get the uid/passwd correct or when the user logs out)
			username.text = "";
			password.text = "";
		}
	}

	private function login_btn_triggerHandler(event:TriggerEvent):Void {
		loginEmployee();
	}
}
