create table role (
  id bigint primary key,
  name varchar not null
);

create table post (
  id bigint primary key,
  name varchar not null
);

create table employee (
  id bigint primary key,
  full_name varchar not null,
  phone_number varchar not null,
  birth_date date not null default current_date,
  login varchar not null,
  password varchar not null,
  roled_id bigint not null,
  post_id bigint not null,
  constraint fk_employee_roled_id foreign key (roled_id) references role(id),
  constraint fk_employee_post_id foreign key (post_id) references post(id)
);

create table category (
  id bigint primary key,
  name varchar not null,
  image varchar not null
);

create table electronic_type (
  id bigint primary key,
  name varchar not null,
  category_id bigint not null,
  constraint fk_electronic_type_category_id foreign key (category_id) references category(id)
);

create table manufacturer (
  id bigint primary key,
  name varchar not null
);

create table electronic (
  id bigint primary key,
  model varchar not null,
  description varchar not null,
  price numeric not null default 1,
  discount numeric not null default 0,
  manufacturer_id bigint not null,
  type_id bigint not null,
  image varchar not null,
  manufacturer_Country varchar not null,
  color varchar not null,
  weight numeric not null default 1,
  constraint fk_electronic_manufacturer_id foreign key (manufacturer_id) references manufacturer(id),
  constraint fk_electronic_type_id foreign key (type_id) references electronic_type(id)
);

create table status (
  id bigint primary key,
  name varchar not null
);

create table order (
  id bigint primary key,
  order_number bigint not null,
  registration_date date default now(),
  status_id bigint not null,
  constraint fk_order_status_id foreign key (status_id) references status(id)
);

create table order_audit {
  change_status_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  status_id bigint not null, 
  order_id bigint not null, 
  constraint fk_order_audit_status_id foreign key (status_id) references status(id),
  constraint fk_order_audit_order_id foreign key (order_id) references order(id)
}

create table order_electronic (
  electronic_id bigint not null,
  order_id bigint not null,
  count bigint not null default 1,
  constraint fk_order_electronic_electronic_id foreign key (electronic_id) references electronic(id),
  constraint fk_order_electronic_order_id foreign key (order_id) references order(id)
);

create table storage (
  id bigint primary key,
  name varchar not null
);

create table supplier (
  id bigint primary key,
  name varchar not null,
  Address varchar not null
);

create table delivery (
  id bigint primary key,
  storage_id bigint not null,
  supplier_id bigint not null,
  delivery_date date default now(),
  employee_id bigint not null,
  constraint fk_delivery_storage_id foreign key (storage_id) references storage(id),
  constraint fk_delivery_supplier_id foreign key (supplier_id) references supplier(id),
  constraint fk_delivery_employee_id foreign key (employee_id) references employee(id)
);

create table electronic_delivery (
  electronic_id bigint not null,
  delivery_id bigint not null,
  quantity bigint not null,
  constraint fk_electronic_delivery_electronic_id foreign key (electronic_id) references electronic(id),
  constraint fk_electronic_delivery_delivery_id foreign key (delivery_id) references delivery(id)
);

create table electronic_storage (
  electronic_id bigint not null,
  storage_id bigint not null,
  quantity bigint not null,
  constraint fk_electronicTostorage_electronic_id foreign key (electronic_id) references electronic(id),
  constraint fk_electronicTostorage_storage_id foreign key (storage_id) references storage(id)
);