from sqlalchemy import Column, Integer, String
from ..database import Base

class Branch(Base):
    __tablename__ = "branches"

    id = Column(Integer, primary_key=True, index=True)
    address = Column(String, nullable=False)
    phone = Column(String, nullable=False)
