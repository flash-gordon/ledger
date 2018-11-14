# ledger

## Basic installation

Create gemset and install gems:
  ```
  rvm ruby-2.5.1 do rvm gemset create ledger
  rvm use ruby-2.5.1@ledger
  bundle install
  ```

Create .env.test file with:
  ```
  DATABASE_URL="postgres://localhost/ledger"
  ```

Login to postgres:
  ```
  psql postgres
  ```
and create database ```ledger```:
  ```
  postgres=# create database ledger;
  ```

Do migrations:
  ```
  APP_ENV=test rake db:auto_migrate
  ```

Run tests:
  ```
  rspec spec/
  ```
