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

![Fail by Provider](../images/fail_by_provider.png)

The provider which fails the most is the provider C with a rate of 33%. The provider B is the second with a rate of 20%.
The bigest concern about the provider C is that even with a low quantity of sessions (9), 3 of them failed.

Actions: Identify the main causes of fail in provider C. Understand if these causes are related to a fraud attempt or a problem with the provider user itself.

# 2 - Fail by Driver Category

![Fail by Driver Category](../images/fail_by_driver_category.png)

The deliver category which pursuits the biggest biometry fail rate is the bronze, with 40% of fails from the total. It's an expected behavior, considering the fact that the most of drivers are in this category, more fails can occur. The fact that this category is the is the second level of less experienced drivers is a matter to be considered as well. 

Actions: Contribute with these findings to the onboard department for better understanding of the platform usage and monitoring of behavior.


# 3 - Real Similarity  x Projected Similarity 

![Similarity](../images/similarity.png)

Adjusting the similarity rate to > 0.8 the percentage of drivers who have match wih the platform drop from 87% to 56%, a difference of 31%.

Impacts: a higher similarity rate would tend to lower the number of fraud cases. Nevertheless, it would cause a disengagement on the platform and in the worst scenario, drivers would leave it. 

Actions: To test this new rate in a part of the population of drivers and follow its behavior to understand if tere will be an adoption or not to drive to forward decisions.


# 4 - Relation Between the Number of Cancelled Orders by Biometry Status 

![Cancelled Orders by Driver ](../images/canceled_orders_by_driver.png)

![Correlation](../images/correlation.png)

Considering the number of orders by drivers and status, there is a relationship between the number of cancelled orders by drivers and the status of biometry. In this case, drivers with 'NOT_MATCH' status have a higher number of cancelled orders. By the statistic point of view, there is a negative correlation betwee the number of drivers to the number of cancelled orders by drivers and the number of orders to number of cancelled orders by drivers as well. Basically, the higher the number of drivers or orders, the lower will be the number of cancelled orders by drivers. 

Nesse caso, entregadores com status ‘NOT_MATCH’ tem um índice maior do que os demais. Estatisticamente falando, a correlação das variáveis indica que quanto maior a quantidade de entregadores ou pedidos, menor a quantidade de pedidos cancelados por entregador. 

Action: deploy this kpi and     monitor its behavior to check if there will be any uncommon behavior.


# 5 - Access Denied Behavior 

![Denied Access](../images/denied_acess.png)

 A peak of denied accesses was seen in the days 15, 16, 17 and 31. These days must be considered for further analysis to understand if it happend due to an instability on the platform or any other reason.

Actions: Transform the average calculus into a moving average and then monitor its behavior to check unusual movements.


![Number of Drivers Above Average](../images/number_of_drivers_above_average.png)

Diving into a deeper analysis, from the total of 24 denied accesses in the period, 9 are related to drivers from the silver cluster (38%). However, the oldest  in the databaase are from begginer and bronze clusters, what is a fraud evidence. 

Action: Send these users to the stack flow for a detailed individual analysis.
