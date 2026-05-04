## 0NF (Unnormalized Form)

```
Dept#, DeptName, Location, MgrName, MgrID, TelExtn,
{Cust#, CustName, DateOfComplaint, NatureOfComplaint}
```

---

## 1NF (First Normal Form)

Rule: Remove repeating groups (one complaint per row)

Primary Key:
(Dept#, Cust#, DateOfComplaint)

Table:

| Dept# | DeptName      | Location   | MgrName     | MgrID | TelExtn | Cust#  | CustName        | DateOfComplaint | NatureOfComplaint |
| ----- | ------------- | ---------- | ----------- | ----- | ------- | ------ | --------------- | --------------- | ----------------- |
| 11232 | Soap Division | Cincinnati | Mary Samuel | S11   | 7711    | P10451 | Robert Drumtree | 12/01/1998      | Poor Service      |
| 11232 | Soap Division | Cincinnati | Mary Samuel | S11   | 7711    | P10480 | Steven Parks    | 14/01/1998      | Discourteous      |

---

## 2NF (Second Normal Form)

Rule: Remove partial dependencies

Issues:

* Dept attributes depend on Dept#
* CustName depends on Cust#

Tables in 2NF:

DEPARTMENTS

```
(Dept#, DeptName, Location, TelExtn, MgrID)
```

CUSTOMERS

```
(Cust#, CustName)
```

COMPLAINTS

```
(Dept#, Cust#, DateOfComplaint, NatureOfComplaint)
```

---

## 3NF (Third Normal Form)

Rule: Remove transitive dependencies

Issue:

* MgrName depends on MgrID

Final Tables:

DEPARTMENTS

```
(Dept#, DeptName, Location, TelExtn, MgrID)
```

MANAGERS

```
(MgrID, MgrName)
```

CUSTOMERS

```
(Cust#, CustName)
```

COMPLAINTS

```
(Dept#, Cust#, DateOfComplaint, NatureOfComplaint)
```

---

Relationships:

* DEPARTMENTS → MANAGERS (MgrID)
* COMPLAINTS → DEPARTMENTS (Dept#)
* COMPLAINTS → CUSTOMERS (Cust#)
