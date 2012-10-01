package com.robotiumbridge;

import android.test.ActivityInstrumentationTestCase2;
import com.jayway.android.robotium.solo.Solo;

import android.app.Activity;
// import com.example.android.notepad.NotesList;

import com.jayway.android.robotium.solo.Solo;
public class TestCase extends ActivityInstrumentationTestCase2 {
  private Solo solo;
  private RobotiumBridge robotiumBridge;

  public TestCase()
  {
    super(com.robotiumbridge.sample.StartupActivity.class);
    // super("com.example.android.notepad", NotesList.class);
  }

  @Override
    protected void setUp() throws Exception {
      super.setUp();
      solo = new Solo(getInstrumentation(), this.getActivity());
    }

  public void testSomething() throws Exception
  {
    robotiumBridge = new RobotiumBridge(solo);
    robotiumBridge.WaitUntilServerKilled();
    solo.finishOpenedActivities();
  }
}
