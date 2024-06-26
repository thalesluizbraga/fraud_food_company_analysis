I'm working as a BI analyst for the fraud prevention department in a tech food company.

To prevent some inappropriate behaviors from our delivery personnel, we have adopted a biometric identification solution. When the delivery person sends us biometric information, this data can go through up to 3 algorithms to check for a ‘MATCH’ between the information sent by the delivery person and the reference we have in our database. If the algorithm of Service A fails for some reason, we send it to Service B, and if it fails, we send it to Service C. Services B and C are what we call here fallback or, in plain English, our ‘Plan B’.

If this MATCH happens in any of the 3 services, the delivery person is allowed to continue working. If not, they proceed to another analysis flow. The ‘MATCH’ is attributed to that session if the similarity calculated by the algorithm between the collected information and the reference is greater than 0.80.

In the table called biometry, we have one biometric session per row with the final result of the entire biometric validation process, whether it ended in service A, B, or C - these rows contain the final decision about the delivery person, who is allowed to work only if the column status = MATCH. In the biometry_execution table, we have up to 3 rows per session, informing the status returned from each of the services A, B, and C.

Based on this scenario, some analysis are demanded from. They are related below:

a) Which service fails the most? (status = PROVIDER_FAILED)
b) Which category of delivery person has the highest failure rate in biometric identification? (status = NOT_MATCH)
c) Calculate what the overall MATCH rate would be (in the biometry table) if we increased the minimum similarity of the MATCH to 0.90.
d) Would you say there is any relationship between the volume of canceled orders (status = CANCELLED) by a delivery person and their final biometric identification status? Justify your answer.
e) On which days did we likely see an increase in the inappropriate behavior of “account loan”?

Metadata:
Tables: biometry | biometry_execution | orders | drivers

Table: biometry

| Column      | Description                                                 |
|-------------|-------------------------------------------------------------|
| Session_Dt  | Date the biometric session ended                            |
| Driver_ID   | Unique key – delivery person ID                             |
| Session_ID  | Unique key - biometric session                              |
| Similarity  | % similarity between collected information and reference    |
| Status      | Final status of the biometric process                       |

Table: biometry_execution

| Column     | Description                                       |
|------------|---------------------------------------------------|
| Event_Dt   | Date the provider completed the analysis          |
| Driver_ID  | Unique key – delivery person ID                   |
| Session_ID | Unique key - biometric session                    |
| Status     | Status provided by the provider                   |
| Provider   | Biometric Solution Provider [A, B, C]             |

Table: orders

| Column      | Description                                      |
|-------------|--------------------------------------------------|
| Order_Dt    | Date of the order                                |
| Order_ID    | Unique key – order ID                            |
| Driver_ID   | Unique key – delivery person ID                  |
| Category    | Delivery person category according to segmentation |
| Modal       | Mode of transport used by the delivery person    |
| Status      | Indicates whether the order was completed or canceled |
| Value       | Total amount paid by the customer for the order  |

Table: drivers

| Column      | Description                                      |
|-------------|--------------------------------------------------|
| Driver_ID   | Unique key – delivery person ID                  |
| Register_Dt | Date the delivery person registered to work with us |
| Action      | Action to be taken with the driver [OK, FLUXO_STACK] |
| Device_ID   | Unique key – delivery person’s device            |


Based on what has been given, the answers to the business problems are below:

# 1 - Fail by Provider

![Fail by Provider](image.png)

The provider which fails the most is the provider C with an index of 33%. The provider B is the second with an index of 20%.
The bigest concern about the provider C is that even with a low quantity of sessions (9), 3 of them failed.

Actions: Identify the main causes of fail in provider C. Understand if these causes are related to a fraud attempt or a problem with the provider user itself.

# 2 - Fail by Provider
a