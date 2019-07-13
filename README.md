#  Read me, please

The entire program relies on the ability to run sql files in transactions for at least 4 major SQL RDBMS in the same way:
- MySQL
- PostgreSQL
- MS SQL
- Oracle SQL

::WARNING: The provided solution is fully tested for MySQL at 8.0@. It can provide strange bugs for other versions and engines.::

We can try to rely on this behaviour.
For each run the system will create the new database with unique name.
The idea relies on finding the possible solution using FIFO-queues.

Use:
* `-type="mysql"` - please provide the type of the underlying engine. Currently it only checks the possible ability to work with this type without a lot of validation
* `-path="/Users/gorloff/Documents/Files"` - please provide the relative (according to launchpath of script) or absolute path to target dir. WARNING: on macOS and its derivatives it will not work with paths as `~/Documents` from the box
* `-cli-path="/usr/local/Cellar/mysql/8.0.16/bin/mysql"` - please provide the path to cli of your SQL system. You can use the name of interpreter according to $PATH of your shell environment. As a result the program actually doesn't make any checks about existence of this system
* `-user="root"` - please provide the root credentials here
* `-password="password"`

Assumptions and weak points:
- Some series of successful sequential transactions can get the system to incosistent state in any case
- It is possible to get the inconsistent state for some combination in any way
- We assume that there is `sh` shell in system
- `.sql` files are provided in UTF8-encoding
- To run faster now we map all the underlying data into memory. As a result at big volume use we will get really nice crash. To avoid it we can just recursevily process files
- The database is located on the same host for simplicity
- Because the state machine can work infinitely we added the max iteration constant as `10000`. It can be insufficient for some situation.

Please look at provided screenshot to understand basic test option.
