from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from .. import schemas, crud, models
from ..database import SessionLocal

router = APIRouter(prefix="/branches", tags=["Branches"])

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/", response_model=list[schemas.BranchResponse])
def get_branches(db: Session = Depends(get_db)):
    return crud.branch.get_all_branches(db)

@router.post("/", response_model=schemas.BranchResponse)
def create_branch(data: schemas.BranchCreate, db: Session = Depends(get_db)):
    return crud.branch.create_branch(db, data)

@router.put("/{branch_id}", response_model=schemas.BranchResponse)
def update_branch(branch_id: int, data: schemas.BranchUpdate, db: Session = Depends(get_db)):
    updated = crud.branch.update_branch(db, branch_id, data)
    if not updated:
        raise HTTPException(status_code=404, detail="Филиал не найден")
    return updated

@router.delete("/{branch_id}", response_model=dict)
def delete_branch(branch_id: int, db: Session = Depends(get_db)):
    deleted = crud.branch.delete_branch(db, branch_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="Филиал не найден")
    return {"message": "Филиал удалён"}
