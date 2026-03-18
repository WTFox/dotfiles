---
name: logging-observability
description: >
  Load when adding logging to application code, setting up structured logging,
  configuring Sentry error tracking, designing log levels, or reviewing code
  for observability gaps. Also load when debugging production issues where
  log output is part of the investigation. Keeps logs useful, consistent,
  and safe (no sensitive data).
---

# Logging and Observability

## The Goal: Logs as a Debugging Tool, Not a Paper Trail

Logs are useful when you can answer "what was the system doing right before this
failed?" from them. Logs are useless when they're either empty (nothing logged)
or noisy (everything logged). The right level is: log events and state that would
help a future you diagnose a production problem at 2am without a debugger.

Never log PII, passwords, tokens, or full request bodies. A useful log event
is: "what happened, to what resource, with what outcome, in how long."

---

## Structured Logging Setup

Use structured (JSON) logging in production so logs are queryable in whatever
log aggregation tool you use (Datadog, Cloudwatch, Loki, etc.). In development,
use a human-readable format.

```python
# backend/app/core/logging.py
import logging
import sys
from app.core.config import settings


def configure_logging() -> None:
    """Call once at application startup, before any loggers are used."""

    if settings.ENVIRONMENT == "production":
        # JSON format in production — structured and queryable
        try:
            import structlog
            structlog.configure(
                processors=[
                    structlog.contextvars.merge_contextvars,
                    structlog.stdlib.add_log_level,
                    structlog.stdlib.add_logger_name,
                    structlog.processors.TimeStamper(fmt="iso"),
                    structlog.processors.JSONRenderer(),
                ],
                logger_factory=structlog.stdlib.LoggerFactory(),
            )
        except ImportError:
            # Fallback: stdlib JSON formatting
            logging.basicConfig(
                level=settings.LOG_LEVEL,
                format='{"time":"%(asctime)s","level":"%(levelname)s","logger":"%(name)s","message":"%(message)s"}',
                stream=sys.stdout,
            )
    else:
        # Human-readable format in development
        logging.basicConfig(
            level=settings.LOG_LEVEL,
            format="%(asctime)s [%(levelname)8s] %(name)s: %(message)s",
            datefmt="%H:%M:%S",
            stream=sys.stdout,
        )

    # Silence noisy third-party loggers
    logging.getLogger("uvicorn.access").setLevel(logging.WARNING)
    logging.getLogger("sqlalchemy.engine").setLevel(logging.WARNING)
    logging.getLogger("httpx").setLevel(logging.WARNING)
```

---

## Log Levels: Use Them Correctly

```python
# DEBUG: Detailed information useful only during development/debugging
# Never leave debug logs in production — they add noise and can leak data
logger.debug("Product lookup", extra={"product_id": str(product_id), "found": result is not None})

# INFO: High-level events that mark significant state transitions
# Think: what would you want to see in a healthy system running normally?
logger.info("Order created", extra={"order_id": str(order.id), "user_id": str(user_id), "total": str(order.total)})

# WARNING: Something unexpected happened but the system recovered
# The system continues, but this is worth investigating
logger.warning("Snowflake query slow", extra={"query": "daily_events", "duration_ms": duration_ms, "threshold_ms": 5000})

# ERROR: An operation failed. A user's request didn't complete.
# Always include exc_info=True so the traceback is logged
logger.error("Failed to send welcome email", exc_info=True, extra={"user_id": str(user_id)})

# CRITICAL: The system is in a state where it cannot function
# Almost always followed by alerting/paging. Use sparingly.
logger.critical("Database connection pool exhausted", extra={"pool_size": pool_size})
```

---

## What to Log: A Practical Pattern

The most useful logs follow the "request lifecycle" pattern: log when an important
operation starts (DEBUG), log when it completes with outcome (INFO or WARNING), log
when it fails (ERROR).

```python
# backend/app/services/order_service.py
import logging
import time
from uuid import UUID
from app.schemas.order import OrderCreate

logger = logging.getLogger(__name__)


class OrderService:

    async def create(self, user_id: UUID, payload: OrderCreate) -> Order:
        """Log the outcome — not every step, but enough to reconstruct what happened."""
        start = time.perf_counter()
        try:
            order = await self._do_create(user_id, payload)
            duration_ms = int((time.perf_counter() - start) * 1000)
            logger.info(
                "order.created",                          # Use dotted event names — queryable
                extra={
                    "order_id": str(order.id),
                    "user_id": str(user_id),
                    "item_count": len(payload.items),
                    "total": str(order.total),
                    "duration_ms": duration_ms,
                }
            )
            return order
        except InsufficientStockError as e:
            # This is a business error — warning, not error. It's expected behavior.
            logger.warning(
                "order.create.insufficient_stock",
                extra={"user_id": str(user_id), "product": e.product_name}
            )
            raise
        except Exception:
            duration_ms = int((time.perf_counter() - start) * 1000)
            logger.error(
                "order.create.failed",
                exc_info=True,                           # Include full traceback
                extra={"user_id": str(user_id), "duration_ms": duration_ms}
            )
            raise
```

---

## What NOT to Log

```python
# NEVER log these — security/privacy violations
logger.info(f"User login: {username} / {password}")       # passwords
logger.info(f"Token: {access_token}")                     # tokens/secrets
logger.info(f"Request body: {request.body()}")            # may contain sensitive fields
logger.info(f"User SSN: {user.ssn}")                      # PII
logger.info(f"Card: {payment.card_number}")               # payment data

# NEVER log entire model objects — they may contain sensitive fields
logger.info(f"User: {user}")    # User.__repr__ might include email, etc.

# DO log only the safe identifiers you need
logger.info("user.login", extra={"user_id": str(user.id), "ip": request.client.host})
```

---

## Request ID Tracing

Every request should carry a unique ID through all log messages so you can
correlate all logs from a single request in production.

```python
# backend/app/core/middleware.py
import uuid
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.requests import Request
import structlog

class RequestIDMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        request_id = request.headers.get("X-Request-ID", str(uuid.uuid4()))

        # Bind request_id to the structlog context — all logs in this request include it
        with structlog.contextvars.bound_contextvars(
            request_id=request_id,
            path=request.url.path,
            method=request.method,
        ):
            response = await call_next(request)
            response.headers["X-Request-ID"] = request_id
            return response
```

---

## Sentry: Error Tracking in Production

Sentry captures exceptions automatically and gives you stack traces, breadcrumbs,
and user context without additional logging code. Set it up once and it works.

```python
# backend/app/core/sentry.py
import sentry_sdk
from sentry_sdk.integrations.fastapi import FastApiIntegration
from sentry_sdk.integrations.sqlalchemy import SqlalchemyIntegration
from app.core.config import settings


def configure_sentry() -> None:
    if not settings.SENTRY_DSN:
        return  # Skip in development if DSN not set

    sentry_sdk.init(
        dsn=settings.SENTRY_DSN,
        environment=settings.ENVIRONMENT,
        release=settings.VERSION,
        integrations=[
            FastApiIntegration(transaction_style="endpoint"),
            SqlalchemyIntegration(),
        ],
        traces_sample_rate=0.1,   # 10% of transactions — adjust based on volume
        profiles_sample_rate=0.1,
        # Don't send PII to Sentry
        send_default_pii=False,
        before_send=_before_send,
    )


def _before_send(event, hint):
    """Scrub sensitive fields before sending to Sentry."""
    if "request" in event:
        # Remove Authorization header from Sentry events
        headers = event["request"].get("headers", {})
        if "Authorization" in headers:
            headers["Authorization"] = "[Filtered]"
    return event
```

```python
# Add Sentry user context in the auth dependency
async def get_current_user(...) -> User:
    user = await ...  # normal auth logic
    # Tag the Sentry scope with the current user so errors include user context
    sentry_sdk.set_user({"id": str(user.id), "email": user.email})
    return user
```

---

## Metrics to Log for Later Analysis

Beyond error tracking, log these quantitative events so you can spot trends:

```python
# Slow queries (anything over 500ms in the API, 5s in Snowflake)
if duration_ms > 500:
    logger.warning("slow_query", extra={"query": query_name, "duration_ms": duration_ms})

# External call latency (Snowflake, any third-party API)
logger.info("snowflake.query", extra={"query": "user_events", "rows": row_count, "duration_ms": duration_ms})

# Background job outcomes
logger.info("job.completed", extra={"job": "process_report", "report_id": report_id, "duration_ms": duration_ms})
logger.error("job.failed", exc_info=True, extra={"job": "process_report", "report_id": report_id, "attempt": attempt})

# Business events worth tracking
logger.info("business.order_placed", extra={"order_id": str(order.id), "total": str(order.total), "item_count": count})
```
