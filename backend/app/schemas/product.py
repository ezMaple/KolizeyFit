from pydantic import BaseModel
from typing import Optional

class ProductBase(BaseModel):
    title: str
    price: float
    description: str

class ProductCreate(ProductBase):
    pass

class ProductUpdate(BaseModel):
    title: Optional[str] = None
    price: Optional[float] = None
    description: Optional[str] = None

class ProductResponse(ProductBase):
    id: int
    image_path: str | None = None

    model_config = {
        "from_attributes": True
    }