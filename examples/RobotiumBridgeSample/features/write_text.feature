Feature: Write Text

  Scenario: Write Text
    When I write the text "this is some text"
    Then I see "this is some text"
    When I clear the text
    Then I do not see "this is some text"
