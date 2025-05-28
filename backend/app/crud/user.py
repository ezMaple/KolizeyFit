from sqlalchemy.orm import Session
from fastapi import HTTPException
from .. import models, schemas
from ..utils.auth import hash_password, verify_password, create_access_token

def create_user(db: Session, user: schemas.UserCreate):
    existing_user = db.query(models.User).filter(
        (models.User.email == user.email) | (models.User.phone == user.phone)
    ).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="Email или телефон уже зарегистрированы")

    hashed_pwd = hash_password(user.password)
    db_user = models.User(
        name=user.name,
        email=user.email,
        phone=user.phone,
        password=hashed_pwd
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def authenticate_user(db: Session, email: str, password: str):
    user = db.query(models.User).filter(models.User.email == email).first()
    if not user or not verify_password(password, user.password):
        return None
    return user

def update_user(db: Session, user_id: int, data: dict, avatar_path: str | None = None):
    user = db.query(models.User).filter(models.User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="Пользователь не найден")

    for field, value in data.items():
        if value is not None:
            setattr(user, field, value)

    if avatar_path:
        user.avatar_path = avatar_path

    db.commit()
    db.refresh(user)
    return user
