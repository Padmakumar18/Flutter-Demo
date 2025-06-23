from sqlalchemy import Column, Integer, String, Text, DateTime, Numeric, Date
from sqlalchemy.sql import func
from database import Base

class Customer(Base):
    __tablename__ = "customers"
    id = Column(Integer, primary_key=True, index=True)
    customer_name = Column(String)
    phone_number = Column(String)
    address = Column(Text)
    email_address = Column(String)
    age = Column(Integer)
    date_created = Column(DateTime(timezone=True), server_default=func.now())

class Product(Base):
    __tablename__ = "products"
    id = Column(Integer, primary_key=True, index=True)
    food_name = Column(String)
    price = Column(Numeric)
    date = Column(Date)
    quantity = Column(Integer)
