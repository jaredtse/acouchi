Constants
---------

com.jayway.android.robotium.solo.Solo
public static final int	CLOSED	0
public static final int	DELETE	67
public static final int	DOWN	20
public static final int	ENTER	66
public static final int	LANDSCAPE	0
public static final int	LEFT	21
public static final int	MENU	82
public static final int	OPENED	1
public static final int	PORTRAIT	1
public static final int	RIGHT	22
public static final int	UP	19

Methods
-------

 void	assertCurrentActivity(String message, Class expectedClass) Asserts that the expected Activity is the currently active one.
 void	assertCurrentActivity(String message, Class expectedClass, boolean isNewInstance) Asserts that the expected Activity is the currently active one, with the possibility to verify that the expected Activity is a new instance of the Activity.
 void	assertCurrentActivity(String message, String name) Asserts that the expected Activity is the currently active one.
 void	assertCurrentActivity(String message, String name, boolean isNewInstance) Asserts that the expected Activity is the currently active one, with the possibility to verify that the expected Activity is a new instance of the Activity.

 void	assertMemoryNotLow() Asserts that the available memory in the system is not low.

* void	clearEditText(android.widget.EditText editText) Clears the value of an EditText.
* void	clearEditText(int index) Clears the value of an EditText.

 ArrayList<android.widget.TextView>	clickInList(int line) Clicks on a given list line and returns an ArrayList of the TextView objects that the list line is showing.
 ArrayList<android.widget.TextView>	clickInList(int line, int index) Clicks on a given list line on a specified list and returns an ArrayList of the TextView objects that the list line is showing.

 ArrayList<android.widget.TextView>	clickLongInList(int line) Long clicks on a given list line and returns an ArrayList of the TextView objects that the list line is showing.
 ArrayList<android.widget.TextView>	clickLongInList(int line, int index) Long clicks on a given list line on a specified list and returns an ArrayList of the TextView objects that the list line is showing.
 ArrayList<android.widget.TextView>	clickLongInList(int line, int index, int time) Long clicks on a given list line on a specified list and returns an ArrayList of the TextView objects that the list line is showing.

 void	clickLongOnScreen(float x, float y) Long clicks a given coordinate on the screen.
 void	clickLongOnScreen(float x, float y, int time) Long clicks a given coordinate on the screen for a given amount of time.

 void	clickLongOnText(String text) Long clicks on a given View.
 void	clickLongOnText(String text, int match) Long clicks on a given View.
 void	clickLongOnText(String text, int match, boolean scroll) Long clicks on a given View.
 void	clickLongOnText(String text, int match, int time) Long clicks on a given View.

 void	clickLongOnTextAndPress(String text, int index) Long clicks on a given View and then selects an item from the context menu that appears.

 void	clickLongOnView(android.view.View view) Long clicks on a given View.
 void	clickLongOnView(android.view.View view, int time) Long clicks on a given View for a given amount of time.

 void	clickOnButton(int index) Clicks on a Button with a given index.
 void	clickOnButton(String name) Clicks on a Button with a given text.

 void	clickOnCheckBox(int index) Clicks on a CheckBox with a given index.

 void	clickOnEditText(int index) Clicks on an EditText with a given index.

 void	clickOnImage(int index) Clicks on an ImageView with a given index.

 void	clickOnImageButton(int index) Clicks on an ImageButton with a given index.

 void	clickOnMenuItem(String text) Clicks on a MenuItem with a given text.
 void	clickOnMenuItem(String text, boolean subMenu) Clicks on a MenuItem with a given text.

 void	clickOnRadioButton(int index) Clicks on a RadioButton with a given index.

 void	clickOnScreen(float x, float y) Clicks on a given coordinate on the screen.

 void	clickOnText(String text) Clicks on a View displaying a given text.
 void	clickOnText(String text, int match) Clicks on a View displaying a given text.
 void	clickOnText(String text, int match, boolean scroll) Clicks on a View displaying a given text.

 void	clickOnToggleButton(String name) Clicks on a ToggleButton with a given text.

 void	clickOnView(android.view.View view) Clicks on a given View.

 void	drag(float fromX, float toX, float fromY, float toY, int stepCount) Simulate touching a given location and dragging it to a new location.

* void	enterText(android.widget.EditText editText, String text) Enters text into a given EditText.
* void	enterText(int index, String text) Enters text into an EditText with a given index.

 void	finalize() Finalizes the solo object and removes the ActivityMonitor.

 void	finishOpenedActivities() All activities that have been active are finished.

 android.app.Instrumentation.ActivityMonitor	getActivityMonitor() Returns the ActivityMonitor used by Robotium.

 ArrayList<android.app.Activity>	getAllOpenedActivities() Returns an ArrayList of all the opened/active activities.

 android.widget.Button	getButton(int index) Returns a Button with a given index.
 android.widget.Button	getButton(String text) Returns a Button which shows a given text.
 android.widget.Button	getButton(String text, boolean onlyVisible) Returns a Button which shows a given text.

 android.app.Activity	getCurrentActivity() Returns the current Activity.

 ArrayList<android.widget.Button>	getCurrentButtons() Returns an ArrayList of the Button objects currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.CheckBox>	getCurrentCheckBoxes() Returns an ArrayList of the CheckBox objects currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.DatePicker>	getCurrentDatePickers() Returns an ArrayList of the DatePicker objects currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.EditText>	getCurrentEditTexts() Returns an ArrayList of the EditText objects currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.GridView>	getCurrentGridViews() Returns an ArrayList of the GridView objects currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.ImageButton>	getCurrentImageButtons() Returns an ArrayList of the ImageButton objects currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.ImageView>	getCurrentImageViews() Returns an ArrayList of the ImageView objects currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.ListView>	getCurrentListViews() Returns an ArrayList of the ListView objects currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.ProgressBar>	getCurrentProgressBars() Returns an ArrayList of the ProgressBar objects currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.RadioButton>	getCurrentRadioButtons() Returns an ArrayList of the RadioButton objects currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.ScrollView>	getCurrentScrollViews() Returns an ArrayList of the ScrollView objects currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.SlidingDrawer>	getCurrentSlidingDrawers() Returns an ArrayList of the SlidingDrawer objects currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.Spinner>	getCurrentSpinners() Returns an ArrayList of the Spinner objects (drop-down menus) currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.TextView>	getCurrentTextViews(android.view.View parent) Returns an ArrayList of the TextView objects currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.TimePicker>	getCurrentTimePickers() Returns an ArrayList of the TimePicker objects currently shown in the focused Activity or Dialog.

 ArrayList<android.widget.ToggleButton>	getCurrentToggleButtons() Returns an ArrayList of the ToggleButton objects currently shown in the focused Activity or Dialog.

 ArrayList<android.view.View>	getCurrentViews() Returns an ArrayList of the View objects currently shown in the focused Activity or Dialog.

 android.widget.EditText	getEditText(int index) Returns an EditText with a given index.
 android.widget.EditText	getEditText(String text) Returns an EditText which shows a given text.
 android.widget.EditText	getEditText(String text, boolean onlyVisible) Returns an EditText which shows a given text.

 android.widget.ImageView	getImage(int index) Returns an ImageView with a given index.

 android.widget.ImageButton	getImageButton(int index) Returns an ImageButton with a given index.  String	getString(int resId) Returns a localized string.

 android.widget.TextView	getText(int index) Returns a TextView with a given index.
 android.widget.TextView	getText(String text) Returns a TextView which shows a given text.
 android.widget.TextView	getText(String text, boolean onlyVisible) Returns a TextView which shows a given text.

 android.view.View	getTopParent(android.view.View view) Returns the absolute top parent View for a given View.

<T extends android.view.View> android.view.View getView(Class<T> viewClass, int index) Returns a View of a given class and index.  android.view.View	getView(int id) Returns a View with a given id.

 ArrayList<android.view.View>	getViews() Returns an ArrayList of all the View objects located in the focused Activity or Dialog.
 ArrayList<android.view.View>	getViews(android.view.View parent) Returns an ArrayList of the View objects contained in the parent View.

 void	goBack() Simulates pressing the hardware back key.
 void	goBackToActivity(String name) Returns to the given Activity.

 boolean	isCheckBoxChecked(int index) Checks if a CheckBox with a given index is checked.
 boolean	isCheckBoxChecked(String text) Checks if a CheckBox with a given text is checked.

 boolean	isRadioButtonChecked(int index) Checks if a RadioButton with a given index is checked.
 boolean	isRadioButtonChecked(String text) Checks if a RadioButton with a given text is checked.

 boolean	isSpinnerTextSelected(int index, String text) Checks if a given text is selected in a given Spinner.
 boolean	isSpinnerTextSelected(String text) Checks if a given text is selected in any Spinner located in the current screen.

 boolean	isTextChecked(String text) Checks if the given text is checked.

 boolean	isToggleButtonChecked(int index) Checks if a ToggleButton with a given index is checked.
 boolean	isToggleButtonChecked(String text) Checks if a ToggleButton with a given text is checked.

 void	pressMenuItem(int index) Presses a MenuItem with a given index.
 void	pressMenuItem(int index, int itemsPerRow) Presses a MenuItem with a given index.

 void	pressSpinnerItem(int spinnerIndex, int itemIndex) Presses on a Spinner (drop-down menu) item.
 boolean	scrollDown() Scrolls down the screen.
 boolean	scrollDownList(int index) Scrolls down a list with a given index.
 void	scrollToSide(int side) Scrolls horizontally.
 boolean	scrollUp() Scrolls up the screen.
 boolean	scrollUpList(int index) Scrolls up a list with a given index.

 boolean	searchButton(String text) Searches for a Button with the given text string and returns true if at least one Button is found.
 boolean	searchButton(String text, boolean onlyVisible) Searches for a Button with the given text string and returns true if at least one Button is found.
 boolean	searchButton(String text, int minimumNumberOfMatches) Searches for a Button with the given text string and returns true if the searched Button is found a given number of times.
 boolean	searchButton(String text, int minimumNumberOfMatches, boolean onlyVisible) Searches for a Button with the given text string and returns true if the searched Button is found a given number of times.

 boolean	searchEditText(String text) Searches for a text string in the EditText objects currently shown and returns true if found.

 boolean	searchText(String text) Searches for a text string and returns true if at least one item is found with the expected text.
 boolean	searchText(String text, boolean onlyVisible) Searches for a text string and returns true if at least one item is found with the expected text.
 boolean	searchText(String text, int minimumNumberOfMatches) Searches for a text string and returns true if the searched text is found a given number of times.
 boolean	searchText(String text, int minimumNumberOfMatches, boolean scroll) Searches for a text string and returns true if the searched text is found a given number of times.
 boolean	searchText(String text, int minimumNumberOfMatches, boolean scroll, boolean onlyVisible) Searches for a text string and returns true if the searched text is found a given number of times.

 boolean	searchToggleButton(String text) Searches for a ToggleButton with the given text string and returns true if at least one ToggleButton is found.
 boolean	searchToggleButton(String text, int minimumNumberOfMatches) Searches for a ToggleButton with the given text string and returns true if the searched ToggleButton is found a given number of times.

* void	sendKey(int key) Sends a key: Right, Left, Up, Down, Enter, Menu or Delete.

 void	setActivityOrientation(int orientation) Sets the Orientation (Landscape/Portrait) for the current activity.

 void	setDatePicker(android.widget.DatePicker datePicker, int year, int monthOfYear, int dayOfMonth) Sets the date in a given DatePicker.
 void	setDatePicker(int index, int year, int monthOfYear, int dayOfMonth) Sets the date in a DatePicker with a given index.

 void	setProgressBar(int index, int progress) Sets the progress of a ProgressBar with a given index.
 void	setProgressBar(android.widget.ProgressBar progressBar, int progress) Sets the progress of a given ProgressBar.

 void	setSlidingDrawer(int index, int status) Sets the status of a SlidingDrawer with a given index.
 void	setSlidingDrawer(android.widget.SlidingDrawer slidingDrawer, int status) Sets the status of a given SlidingDrawer.

 void	setTimePicker(int index, int hour, int minute) Sets the time in a TimePicker with a given index.
 void	setTimePicker(android.widget.TimePicker timePicker, int hour, int minute) Sets the time in a given TimePicker.

 void	sleep(int time) Robotium will sleep for a specified time.

 boolean	waitForActivity(String name) Waits for the given Activity.
 boolean	waitForActivity(String name, int timeout) Waits for the given Activity.

 boolean	waitForDialogToClose(long timeout) Waits for a Dialog to close.

* boolean	waitForText(String text) Waits for a text to be shown.
* boolean	waitForText(String text, int minimumNumberOfMatches, long timeout) Waits for a text to be shown.
* boolean	waitForText(String text, int minimumNumberOfMatches, long timeout, boolean scroll) Waits for a text to be shown.
* boolean	waitForText(String text, int minimumNumberOfMatches, long timeout, boolean scroll, boolean onlyVisible) Waits for a text to be shown.

<T extends android.view.View> boolean waitForView(Class<T> viewClass) Waits for a View of a certain class to be shown.
<T extends android.view.View> boolean waitForView(Class<T> viewClass, int minimumNumberOfMatches, int timeout) Waits for a View of a certain class to be shown.
<T extends android.view.View> boolean waitForView(Class<T> viewClass, int minimumNumberOfMatches, int timeout, boolean scroll) Waits for a View of a certain class to be shown.
<T extends android.view.View> boolean waitForView(android.view.View view) Waits for a View to be shown.
<T extends android.view.View> boolean waitForView(android.view.View view, int timeout, boolean scroll) Waits for a View to be shown.
