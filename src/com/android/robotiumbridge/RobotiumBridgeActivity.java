package com.android.robotiumbridge;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

public class RobotiumBridgeActivity extends Activity {
  @Override
    protected void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      Intent intent = new Intent();
      intent.setClassName("com.android.robotiumbridge", "com.android.robotiumbridge.RobotiumBridgeService");
      bindService(intent, null, Context.BIND_AUTO_CREATE);
      this.startService(intent);
    }
}
