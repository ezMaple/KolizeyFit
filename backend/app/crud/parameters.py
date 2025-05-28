from sqlalchemy.orm import Session
from fastapi import HTTPException
from .. import models, schemas

def get_by_user(db: Session, user_id: int):
    return db.query(models.Parameters).filter(models.Parameters.user_id == user_id).first()

def create(db: Session, user_id: int, params: schemas.ParametersCreate):
    existing = get_by_user(db, user_id)
    if existing:
        raise HTTPException(status_code=400, detail="Параметры уже созданы")

    new_params = models.Parameters(user_id=user_id, **params.dict())
    db.add(new_params)
    db.commit()
    db.refresh(new_params)
    return new_params

def update(db: Session, user_id: int, params: schemas.ParametersUpdate):
    existing = get_by_user(db, user_id)
    if not existing:
        raise HTTPException(status_code=404, detail="Параметры не найдены")

    for key, value in params.dict().items():
        setattr(existing, key, value)

    db.commit()
    db.refresh(existing)
    return existing
