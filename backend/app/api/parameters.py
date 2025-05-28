from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from .. import schemas, crud, models
from ..database import SessionLocal
from .auth import get_current_user

router = APIRouter(prefix="/parameters", tags=["Parameters"])

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/", response_model=schemas.ParametersResponse)
def get_my_parameters(
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    params = crud.parameters.get_by_user(db, current_user.id)
    if not params:
        raise HTTPException(status_code=404, detail="Параметры не найдены")
    return params

@router.post("/", response_model=schemas.ParametersResponse)
def create_parameters(
    data: schemas.ParametersCreate,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    return crud.parameters.create(db, current_user.id, data)

@router.put("/", response_model=schemas.ParametersResponse)
def update_parameters(
    data: schemas.ParametersUpdate,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    return crud.parameters.update(db, current_user.id, data)
