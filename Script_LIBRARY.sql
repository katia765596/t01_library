--2.
create table public.author(
 	id SERIAL primary key,
 	surname varchar(100) not null,
 	name varchar(100) not null
);
-- 3.  В базе данных t01_library создайте таблицу publishing_house уровня схемы public
create table public.publishing_house (
 id SERIAL primary key,
 name varchar(200) not null,
 city varchar(100) not null);
-- 4.  В базе данных t01_library создайте таблицу book
create table public.book (
 id serial primary key,
 title varchar(300) not null,
 author_id integer references public.author(id),
 publishing_house_id integer references public.publishing_house(id), 
 edition varchar(50),
 year integer,
 print_run integer);
-- 5.  В базе данных t01_library создайте таблицу reader 
create table public.reader (
  ticket_number varchar(20) primary key,
  surname varchar(100) not null,
  name varchar(100) not null,
  birth_date date not null,
  gender char(1) check (gender in ('M','F')),
  registration_date date not null);
-- 6. В базе данных t01_library создайте таблицу book_instance 
create type book_state as enum ('отличное', 'хорошее', 'удовлетворительное', 'ветхое', 'утеряна' );
create type book_status as enum ('в наличии', 'выдана','забронирована');
create table public.book_instance (
 inventory_number varchar(50) primary key,
 book_id integer references public.book(id),
 state book_state not null,
 status book_status not null,
 location varchar(200) not null);
-- 7. В базе данных t01_library создайте таблицу issuance 
create table public.issuance (
	ticket_number varchar(20) references public.reader(ticket_number),
	inventory_number varchar(50) references public.book_instance(inventory_number),
	issue_datetime timestamp(0) not null,
	expected_return_date date not null,
	actual_return_date date,
	primary key (ticket_number, inventory_number));
-- 8. В базе данных t01_library создайте таблицу booking
create table public.booking ( 
	id SERIAL primary key,                
    ticket_number varchar(20) references public.reader(ticket_number),  
    book_id integer references public.book(id),  
    min_state varchar(50) check (min_state in ('отличное', 'хорошее', 'удовлетворительное', 'ветхое', 'утеряна')), 
    booking_datetime timestamp(0) not null);
