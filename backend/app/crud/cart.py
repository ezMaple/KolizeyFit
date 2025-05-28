from sqlalchemy.orm import Session
from .. import models, schemas

def get_cart_for_user(db: Session, user_id: int):
    return db.query(models.Cart).filter(models.Cart.user_id == user_id).all()

def add_to_cart(db: Session, user_id: int, product_id: int):
    # Проверка на дубликат
    existing = db.query(models.Cart).filter_by(user_id=user_id, product_id=product_id).first()
    if existing:
        return existing  # Не добавляем повторно
    item = models.Cart(user_id=user_id, product_id=product_id)
    db.add(item)
    db.commit()
    db.refresh(item)
    return item

def remove_from_cart(db: Session, user_id: int, product_id: int):
    item = db.query(models.Cart).filter_by(user_id=user_id, product_id=product_id).first()
    if item:
        db.delete(item)
        db.commit()
    return item
