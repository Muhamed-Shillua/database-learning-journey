## 0NF (Unnormalized Form)

Initial flat file with repeating groups:

```
OrderNo, Date, CustNo, CustName, CustAddr, ClerkNo, ClerkName,
{ItemNo, Description, Qty, Price}
```

---

## 1NF (First Normal Form)

Rule: Eliminate repeating groups so all values are atomic

Primary Key:
(OrderNo, ItemNo)

Table:

| OrderNo | Date     | CustNo | CustName | CustAddr   | ClerkNo | ClerkName | ItemNo | Description | Qty | Price |
| ------- | -------- | ------ | -------- | ---------- | ------- | --------- | ------ | ----------- | --- | ----- |
| 405     | 2/1/2000 | 1001   | ABC Co   | 100 Points | 210     | Martin    | 800    | widget      | 40  | 60    |
| 405     | 2/1/2000 | 1001   | ABC Co   | 100 Points | 210     | Martin    | 801    | tingi       | 20  | 20    |
| 405     | 2/1/2000 | 1001   | ABC Co   | 100 Points | 210     | Martin    | 805    | thingi      | 10  | 100   |

---

## 2NF (Second Normal Form)

Rule: Remove partial dependencies

Issue:

* Description and UnitPrice depend only on ItemNo

Tables in 2NF:

ORDERS

```
(OrderNo, OrderDate, CustNo, ClerkNo)
```

ORDER_DETAILS

```
(OrderNo, ItemNo, Quantity)
```

ITEMS

```
(ItemNo, Description, UnitPrice)
```

CUSTOMERS

```
(CustNo, CustName, CustAddr)
```

CLERKS

```
(ClerkNo, ClerkName)
```

---

## 3NF (Third Normal Form)

Rule: Remove transitive dependencies

Final Tables:

CUSTOMERS

```
(CustNo, CustName, CustAddr)
```

CLERKS

```
(ClerkNo, ClerkName)
```

ITEMS

```
(ItemNo, Description, UnitPrice)
```

ORDERS

```
(OrderNo, OrderDate, CustNo, ClerkNo)
```

ORDER_DETAILS

```
(OrderNo, ItemNo, Quantity)
```

---

Relationships:

* ORDERS → CUSTOMERS (CustNo)
* ORDERS → CLERKS (ClerkNo)
* ORDER_DETAILS → ORDERS (OrderNo)
* ORDER_DETAILS → ITEMS (ItemNo)
