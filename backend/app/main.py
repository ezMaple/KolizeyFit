from fastapi import FastAPI, Request, Response
from fastapi.staticfiles import StaticFiles
from .database import Base, engine
from .api import auth, parameters, products, cart, branches, user
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from starlette.middleware.base import BaseHTTPMiddleware

# UTF-8 middleware
class CharsetMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        response: Response = await call_next(request)
        if response.headers.get("content-type", "").startswith("application/json"):
            response.headers["content-type"] = "application/json; charset=utf-8"
        return response

app = FastAPI(title="KolizeyFit Backend")

# Инициализация всех моделей
from . import models  # Импорт чтобы Base знал о моделях

Base.metadata.create_all(bind=engine)

app.mount("/static", StaticFiles(directory="app/static"), name="static")

app.add_middleware(CharsetMiddleware)

app.include_router(auth.router)
app.include_router(parameters.router)
app.include_router(products.router)
app.include_router(cart.router)
app.include_router(branches.router)
app.include_router(user.router)

@app.get("/")
def read_root():
    return {"message": "Добро пожаловать в API Kolizey!"}
