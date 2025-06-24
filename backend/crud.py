from sqlalchemy.orm import Session
import models, schemas

# Customers
def get_customers(db: Session):
    return db.query(models.Customer).all()

def create_customer(db: Session, customer: schemas.CustomerCreate):
    db_customer = models.Customer(**customer.dict())
    db.add(db_customer)
    db.commit()
    db.refresh(db_customer)
    return db_customer

def update_customer(db: Session, id: int, customer: schemas.CustomerCreate):
    db_customer = db.query(models.Customer).filter(models.Customer.id == id).first()
    for key, value in customer.dict().items():
        setattr(db_customer, key, value)
    db.commit()
    return db_customer

def delete_customer(db: Session, id: int):
    db_customer = db.query(models.Customer).filter(models.Customer.id == id).first()
    db.delete(db_customer)
    db.commit()

# Products
def get_products(db: Session):
    return db.query(models.Product).all()

def create_product(db: Session, product: schemas.ProductCreate):
    db_product = models.Product(**product.dict())
    db.add(db_product)
    db.commit()
    db.refresh(db_product)
    return db_product

def update_product(db: Session, id: int, product: schemas.ProductCreate):
    db_product = db.query(models.Product).filter(models.Product.id == id).first()
    for key, value in product.dict().items():
        setattr(db_product, key, value)
    db.commit()
    return db_product

def delete_product(db: Session, id: int):
    db_product = db.query(models.Product).filter(models.Product.id == id).first()
    db.delete(db_product)
    db.commit()
