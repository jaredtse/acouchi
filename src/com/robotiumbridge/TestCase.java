package com.robotiumbridge;

import android.test.ActivityInstrumentationTestCase2;
import com.jayway.android.robotium.solo.Solo;

import android.app.Activity;
import com.example.android.notepad.NotesList;

public class TestCase extends ActivityInstrumentationTestCase2<NotesList> {
  public TestCase()
  {
    super(NotesList.class);
  }

  public void testSomething() throws Exception
  {
    RobotiumBridge robotiumBridge = new RobotiumBridge(getInstrumentation(), getActivity());
    robotiumBridge.WaitUntilServerKilled();
  }
}
