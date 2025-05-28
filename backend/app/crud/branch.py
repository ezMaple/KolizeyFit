from sqlalchemy.orm import Session
from .. import models, schemas

def create_branch(db: Session, branch: schemas.BranchCreate):
    new_branch = models.Branch(**branch.dict())
    db.add(new_branch)
    db.commit()
    db.refresh(new_branch)
    return new_branch

def get_all_branches(db: Session):
    return db.query(models.Branch).all()

def get_branch(db: Session, branch_id: int):
    return db.query(models.Branch).filter(models.Branch.id == branch_id).first()

def update_branch(db: Session, branch_id: int, data: schemas.BranchUpdate):
    branch = get_branch(db, branch_id)
    if not branch:
        return None
    for key, value in data.dict().items():
        setattr(branch, key, value)
    db.commit()
    db.refresh(branch)
    return branch

def delete_branch(db: Session, branch_id: int):
    branch = get_branch(db, branch_id)
    if branch:
        db.delete(branch)
        db.commit()
    return branch
