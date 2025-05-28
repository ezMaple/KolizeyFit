import os
from uuid import uuid4
from fastapi import APIRouter, UploadFile, File, Form, Depends, HTTPException, status, Response
from sqlalchemy.orm import Session
from .. import schemas, crud
from ..database import SessionLocal

router = APIRouter(prefix="/products", tags=["Products"])

UPLOAD_DIR = "app/static/images"

os.makedirs(UPLOAD_DIR, exist_ok=True)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/", response_model=schemas.ProductResponse)
def create_product(
    title: str = Form(...),
    price: float = Form(...),
    description: str = Form(...),
    image: UploadFile = File(None),
    db: Session = Depends(get_db)
):
    image_path = None
    if image:
        filename = f"{uuid4().hex}_{image.filename}"
        file_location = os.path.join(UPLOAD_DIR, filename)
        with open(file_location, "wb") as f:
            f.write(image.file.read())
        image_path = f"/static/images/{filename}"

    data = schemas.ProductCreate(title=title, price=price, description=description)
    return crud.product.create(db, data, image_path=image_path)

@router.get("/", response_model=list[schemas.ProductResponse])
def get_products(db: Session = Depends(get_db)):
    return crud.product.get_all(db)

@router.get("/{product_id}", response_model=schemas.ProductResponse)
def get_product(product_id: int, db: Session = Depends(get_db)):
    product = crud.product.get_by_id(db, product_id)
    if not product:
        raise HTTPException(status_code=404, detail="Продукт не найден")
    return product

@router.patch("/{product_id}", response_model=schemas.ProductResponse)
def partial_update_product(
    product_id: int,
    title: str = Form(None),
    price: float = Form(None),
    description: str = Form(None),
    image: UploadFile = File(None),
    db: Session = Depends(get_db)
):
    product = crud.product.get_by_id(db, product_id)
    if not product:
        raise HTTPException(status_code=404, detail="Продукт не найден")

    image_path = product.image_path
    if image:
        filename = f"{uuid4().hex}_{image.filename}"
        file_location = os.path.join(UPLOAD_DIR, filename)
        with open(file_location, "wb") as f:
            f.write(image.file.read())
        image_path = f"/static/images/{filename}"

    # Создаём словарь только из переданных значений (исключаем None)
    update_data = {}
    if title is not None:
        update_data["title"] = title
    if price is not None:
        update_data["price"] = price
    if description is not None:
        update_data["description"] = description

    data = schemas.ProductUpdate(**update_data)

    updated_product = crud.product.update_partial(db, product_id, data, image_path)
    return updated_product

@router.delete("/{product_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_product(product_id: int, db: Session = Depends(get_db)):
    product = crud.product.delete(db, product_id)
    if not product:
        raise HTTPException(status_code=404, detail="Продукт не найден")
    return Response(status_code=status.HTTP_204_NO_CONTENT)
