from pydantic import BaseModel

class ParametersBase(BaseModel):
    chest: float
    hips: float
    height: float
    neck: float
    biceps: float
    weight: float

class ParametersCreate(ParametersBase):
    pass

class ParametersUpdate(ParametersBase):
    pass

class ParametersResponse(ParametersBase):
    id: int

    model_config = {
        "from_attributes": True
    }
