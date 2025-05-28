from pydantic import BaseModel

class BranchBase(BaseModel):
    address: str
    phone: str

class BranchCreate(BranchBase):
    pass

class BranchUpdate(BranchBase):
    pass

class BranchResponse(BranchBase):
    id: int

    model_config = {
        "from_attributes": True
    }
