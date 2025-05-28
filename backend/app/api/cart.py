from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from .. import schemas, crud, models
from ..database import SessionLocal
from .auth import get_current_user
from datetime import datetime

router = APIRouter(prefix="/cart", tags=["Cart"])

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/", response_model=list[schemas.CartItemResponse])
def get_user_cart(
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    return crud.cart.get_cart_for_user(db, current_user.id)

@router.post("/", response_model=schemas.CartItemResponse)
def add_to_cart(
    item: schemas.CartItemCreate,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    return crud.cart.add_to_cart(db, current_user.id, item.product_id)

@router.delete("/", response_model=dict)
def remove_from_cart(
    item: schemas.CartItemCreate,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    deleted = crud.cart.remove_from_cart(db, current_user.id, item.product_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="Товар не найден в корзине")
    return {"message": "Удалено из корзины"}

@router.post("/pay", response_model=dict)
def pay_cart(
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    # Получаем корзину пользователя
    cart_items = db.query(models.Cart).filter(models.Cart.user_id == current_user.id).all()

    if not cart_items:
        raise HTTPException(status_code=404, detail="Корзина пуста")

    # Вычисляем общую стоимость
    total_amount = 0.0
    for item in cart_items:
        if not item.product:
            raise HTTPException(status_code=400, detail=f"Товар с id {item.product_id} не найден")
        total_amount += item.product.price  # предполагается, что у Product есть поле price

    # Здесь можно сохранить транзакцию (если есть таблица, например Transaction)
    # transaction = models.Transaction(user_id=current_user.id, amount=total_amount, timestamp=datetime.utcnow())
    # db.add(transaction)

    # Очищаем корзину
    db.query(models.Cart).filter(models.Cart.user_id == current_user.id).delete()
    db.commit()

    return {"status": "success", "total": total_amount}