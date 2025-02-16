-- 1. Creating the LibraryManagement database and tables 

create database LibraryManagement;
use LibraryManagement;

create table authors ( 
author_id int auto_increment primary key,
author_name varchar(255) not null);

create table genres (
genre_id int auto_increment primary key,
genre_name varchar(255) not null);

create table books ( 
book_id int auto_increment primary key,
title varchar(255) not null,
publication_year year not null,
author_id int,
genre_id int,
foreign key (author_id) references authors(author_id),
foreign key (genre_id) references genres(genre_id));

create table users (
user_id int auto_increment primary key,
username varchar(255) not null,
email varchar(255) not null);

create table borrowed_books (
borrow_id int auto_increment primary key,
book_id int,
user_id int,
borrow_date date not null,
return_date date,
foreign key (book_id) references books(book_id),
foreign key (user_id) references users(user_id));
