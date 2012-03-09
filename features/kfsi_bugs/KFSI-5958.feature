Feature: KFSI-5958

  Background:
    Given I am up top

  @jira @incomplete
  Scenario: When a credit memo is processed, resulting payment is correctly ACH

    Given I am logged in
    And I am on the "main_menu" tab
    When I click the "Requisition" portal link
    And I sleep for "10" seconds
    And I set the "Description" to something like "testing: KFSI-5958"
    And I check "Receiving Required"
    And I start a lookup for "Building"
    And I set the "Building Code" to "10"
    And I click "search"
    And I return with the first result
    And I start a lookup for "Room"
    And I set the "Building Room Number" to "0001"
    And I click "search"
    And I return with the first result
    And I start a lookup for "Suggested Vendor"
    And I set the "Vendor Name" to "Benjamin Plumbing Supply"
    And I click "search"
    And I return with the first result
    #And I fill out a new Item with default values
    And I set a new Item's "Item Type" to "QUANTITY TAXABLE"
    And I set a new Item's "Quantity" to "100"
    And I set a new Item's "UOM" to "ea"
    And I set a new Item's "Description" to "a 5958 widget"
    And I set a new Item's "Unit Cost" to "5"
    And I add that "Item"
    And I show the first Item's "Accounting Lines"
    And I fill out the first Item's "Accounting Lines" with the following new Source Line:
      | Chart          | UA      |
      | Account Number | 1639100 |
      | Object         | 5320    |
      | Percent        | 100     |
    And I add that first Item's new Source Line
    And I set the "Requestor Email" to "kfsi-5460@email.arizona.edu" if blank
    And I click "calculate"
    And I click "submit"
    Then I should see "Document was successfully submitted."

    When I record this document number
    When I record this "Requisition #"
    And I backdoor as "watersp"
    And I open my Action List to the last page
    And I open that document
    And I click "approve"
    Then I should see my Action List

    When I backdoor as "kfs-test-sec40"
    And I am on the "main_menu" tab
    And I sleep for "10" seconds
    And I click the "Contract Manager Assignment" portal link
    And I fill out the following for that "Requisition #":
      | Contract Manager | 10 |
    And I click "submit"
    Then I should see "Document was successfully submitted."

    When I open a doc search
    And I click "search"
    And I open the first one
    And I switch to the new window
    And I set the "Vendor Choice" to "Other"
    And I click "calculate"
    And I click "submit"
    Then I should see "Document was successfully submitted."

    When I close that window
    And I open a doc search
    And I click "search"
    And I open the first one
    And I switch to the new window
    And I record this "Purchase Order #" (the number)
    And I click "print"

    When I close that window
    And I backdoor as "kfs-test-sec36"
    And I am on the "central_admin" tab
    And I click the "Payment Request" portal link
    And I set the "Purchase Order #" to that "Purchase Order #"
    And I set the "Invoice Number" to now (%H%M%S)
    And I set the "Invoice Date" to now (%m/%d/%Y)
    And I set the "Vendor Invoice Amount" to "1000"
    And I click "continue"
    And I check "Immediate Pay"
    And I set the first Item's "Qty Invoiced" to "1"
    And I click "calculate"
    And I click "submit"
    Then I should see "Payment Request Initiation"

    When I am on the "main_menu" tab
    And I click the "Receiving" portal link under "Transactions"
    And I set the "Purchase Order #" to that "Purchase Order #"
    And I set the "Vendor Date" to now (%m/%d/%Y)
    And I click "continue"
    And I set the first Item's "Qty Received" to "1"
    And I click "submit"
