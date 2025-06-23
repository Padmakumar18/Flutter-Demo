from pydantic import BaseModel
from datetime import datetime, date

class CustomerBase(BaseModel):
    customer_name: str
    phone_number: str
    address: str
    email_address: str
    age: int

class CustomerCreate(CustomerBase): pass

class Customer(CustomerBase):
    id: int
    date_created: datetime
    class Config: orm_mode = True

class ProductBase(BaseModel):
    food_name: str
    price: float
    date: date
    quantity: int

class ProductCreate(ProductBase): pass

class Product(ProductBase):
    id: int
    class Config: orm_mode = True
