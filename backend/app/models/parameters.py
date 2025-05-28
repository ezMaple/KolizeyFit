from sqlalchemy import Column, Integer, Float, ForeignKey
from ..database import Base

class Parameters(Base):
    __tablename__ = "parameters"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), unique=True, nullable=False)

    chest = Column(Float)
    hips = Column(Float)
    height = Column(Float)
    neck = Column(Float)
    biceps = Column(Float)
    weight = Column(Float)
