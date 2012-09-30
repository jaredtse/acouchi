package com.robotiumbridge;

import android.test.ActivityInstrumentationTestCase2;
import com.jayway.android.robotium.solo.Solo;

import android.app.Activity;
import com.example.android.notepad.NotesList;

public class TestCase extends
ActivityInstrumentationTestCase2<NotesList> {

  private Solo solo;

  public TestCase() {
    super(NotesList.class);
  }

  public void setUp() throws Exception {
    solo = new Solo(getInstrumentation(), getActivity());
  }

  public void testSomething() throws Exception {
    solo.sendKey(Solo.MENU);

    solo.clickOnText("More");
  }

  @Override
    public void tearDown() throws Exception {
      solo.finishOpenedActivities();
    }
}
