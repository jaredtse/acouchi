package com.android.robotiumbridge;

import android.test.ActivityInstrumentationTestCase2;
import com.jayway.android.robotium.solo.Solo;
import com.example.android.notepad.NotesList;

@SuppressWarnings("unchecked")
public class TestCase extends ActivityInstrumentationTestCase2 {

  private static final String TARGET_PACKAGE_ID="com.example.android.notepad";
  private static final String LAUNCHER_ACTIVITY_FULL_CLASSNAME="com.example.android.notepad.NotesList";
  private static Class launcherActivityClass;

  static {
    try
    {
      launcherActivityClass = Class.forName(LAUNCHER_ACTIVITY_FULL_CLASSNAME);
    } catch (ClassNotFoundException e){
      throw new RuntimeException(e);
    }
  }

  public TestCase() throws ClassNotFoundException{
    super(TARGET_PACKAGE_ID,launcherActivityClass);
  }

  private Solo solo;

  @Override
    protected void setUp() throws Exception
    {
      solo = new Solo(getInstrumentation(),getActivity());
    }

  public void testDisplayBlackBox() {
    //Enter any integer/decimal value for first editfield, we are writing 10
    solo.enterText(0, "10");

    //Enter any interger/decimal value for first editfield, we are writing 20
    solo.enterText(1, "20");

    //Click on Multiply button
    solo.clickOnButton("Multiply");

    //Verify that resultant of 10 x 20
    assertTrue(solo.searchText("200"));
  }

  @Override
    public void tearDown() throws Exception {
      solo.finishOpenedActivities();
    }

}
// import com.example.android.notepad.NotesList;
// import com.jayway.android.robotium.solo.Solo;
// import android.test.ActivityInstrumentationTestCase2;

// public class TestCase extends
// ActivityInstrumentationTestCase2<NotesList> {

//   private Solo solo;

//   public TestCase() {
//     super(EditorActivity.class);
//   }

//   public void setUp() throws Exception {
//     solo = new Solo(getInstrumentation(), getActivity());
//   }

//   public void testPreferenceIsSaved() throws Exception {

//     solo.sendKey(Solo.MENU);
//     solo.clickOnText("More");
//     solo.clickOnText("Preferences");
//     solo.clickOnText("Edit File Extensions");
//     Assert.assertTrue(solo.searchText("rtf"));

//     solo.clickOnText("txt");
//     solo.clearEditText(2);
//     solo.enterText(2, "robotium");
//     solo.clickOnButton("Save");
//     solo.goBack();
//     solo.clickOnText("Edit File Extensions");
//     Assert.assertTrue(solo.searchText("application/robotium"));

//   }

//   @Override
//     public void tearDown() throws Exception {
//       solo.finishOpenedActivities();
//     }
// }
