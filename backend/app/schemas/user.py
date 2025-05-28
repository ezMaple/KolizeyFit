from pydantic import BaseModel, EmailStr, StringConstraints
from typing import Annotated

class UserCreate(BaseModel):
    name: str
    email: EmailStr
    phone: Annotated[str, StringConstraints(min_length=10, max_length=15)]
    password: str

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class UserResponse(BaseModel):
    id: int
    name: str
    email: str
    phone: str
    avatar_path: str | None = None

    model_config = {
        "from_attributes": True
    }

class UserUpdate(BaseModel):
    name: str
    email: EmailStr
    phone: Annotated[str, StringConstraints(min_length=10, max_length=15)]
