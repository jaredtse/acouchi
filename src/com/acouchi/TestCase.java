package com.acouchi;

import android.test.ActivityInstrumentationTestCase2;
import com.jayway.android.robotium.solo.Solo;

import android.app.Activity;
// import com.example.android.notepad.NotesList;

import com.jayway.android.robotium.solo.Solo;
public class TestCase extends ActivityInstrumentationTestCase2 {
  private Solo solo;
  private Acouchi acouchi;

  public TestCase()
  {
    super(ACTIVITY_UNDER_TEST.class);
    // super("com.example.android.notepad", NotesList.class);
  }

  @Override
    protected void setUp() throws Exception {
      super.setUp();
      solo = new Solo(getInstrumentation(), this.getActivity());
    }

  public void testSomething() throws Exception
  {
    acouchi = new Acouchi(solo);
    acouchi.WaitUntilServerKilled();
    solo.finishOpenedActivities();
  }
}
