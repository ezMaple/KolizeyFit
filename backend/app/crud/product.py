from sqlalchemy.orm import Session
from .. import models, schemas

def create(db: Session, product: schemas.ProductCreate, image_path: str = None):
    new_product = models.Product(**product.dict(), image_path=image_path)
    db.add(new_product)
    db.commit()
    db.refresh(new_product)
    return new_product

def get_all(db: Session):
    return db.query(models.Product).all()

def get_by_id(db: Session, product_id: int):
    return db.query(models.Product).filter(models.Product.id == product_id).first()

def update_partial(db: Session, product_id: int, data: schemas.ProductUpdate, image_path: str | None = None):
    product = get_by_id(db, product_id)
    if not product:
        return None
    update_data = data.dict(exclude_unset=True)
    for key, value in update_data.items():
        setattr(product, key, value)
    if image_path is not None:
        product.image_path = image_path
    db.commit()
    db.refresh(product)
    return product

def delete(db: Session, product_id: int):
    product = get_by_id(db, product_id)
    if not product:
        return None
    db.delete(product)
    db.commit()
    return product
