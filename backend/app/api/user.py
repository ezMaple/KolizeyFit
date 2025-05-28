import os
from uuid import uuid4
from fastapi import APIRouter, Depends, UploadFile, File, Form, HTTPException
from sqlalchemy.orm import Session
from .. import schemas, crud, models
from ..database import SessionLocal
from .auth import get_current_user

router = APIRouter(prefix="/profile", tags=["Profile"])

UPLOAD_DIR = "app/static/images"
os.makedirs(UPLOAD_DIR, exist_ok=True)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/", response_model=schemas.UserResponse)
def get_profile(current_user: models.User = Depends(get_current_user)):
    return current_user

@router.put("/", response_model=schemas.UserResponse)
def update_profile(
    name: str = Form(None),
    email: str = Form(None),
    phone: str = Form(None),
    avatar: UploadFile = File(None),
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    avatar_path = None
    if avatar:
        filename = f"{uuid4().hex}_{avatar.filename}"
        file_location = os.path.join(UPLOAD_DIR, filename)
        with open(file_location, "wb") as f:
            f.write(avatar.file.read())
        avatar_path = f"/static/images/{filename}"

    update_data = {
        "name": name,
        "email": email,
        "phone": phone,
    }

    return crud.user.update_user(db, current_user.id, update_data, avatar_path)

@router.get("/qr-data")
def get_user_qr_data(current_user: models.User = Depends(get_current_user)):
    return {
        "id": current_user.id,
        "name": current_user.name,
        "email": current_user.email,
        "phone": current_user.phone,
    }
