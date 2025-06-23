from fastapi import FastAPI, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
import models, schemas, crud
from database import SessionLocal, engine

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# You can define specific origins or use "*" to allow all
origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Customer Routes
@app.get("/customers", response_model=list[schemas.Customer])
def read_customers(db: Session = Depends(get_db)):
    return crud.get_customers(db)

@app.post("/customers", response_model=schemas.Customer)
def create_customer(customer: schemas.CustomerCreate, db: Session = Depends(get_db)):
    return crud.create_customer(db, customer)

@app.put("/customers/{id}", response_model=schemas.Customer)
def update_customer(id: int, customer: schemas.CustomerCreate, db: Session = Depends(get_db)):
    return crud.update_customer(db, id, customer)

@app.delete("/customers/{id}")
def delete_customer(id: int, db: Session = Depends(get_db)):
    crud.delete_customer(db, id)
    return {"ok": True}

# Product Routes
@app.get("/products", response_model=list[schemas.Product])
def read_products(db: Session = Depends(get_db)):
    return crud.get_products(db)

@app.post("/products", response_model=schemas.Product)
def create_product(product: schemas.ProductCreate, db: Session = Depends(get_db)):
    return crud.create_product(db, product)

@app.put("/products/{id}", response_model=schemas.Product)
def update_product(id: int, product: schemas.ProductCreate, db: Session = Depends(get_db)):
    return crud.update_product(db, id, product)

@app.delete("/products/{id}")
def delete_product(id: int, db: Session = Depends(get_db)):
    crud.delete_product(db, id)
    return {"ok": True}
