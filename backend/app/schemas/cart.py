from pydantic import BaseModel
from .product import ProductResponse

class CartItemBase(BaseModel):
    product_id: int

class CartItemCreate(CartItemBase):
    pass

class CartItemResponse(BaseModel):
    id: int
    user_id: int
    product: ProductResponse  # <- вся информация о товаре

    model_config = {
        "from_attributes": True
    }
