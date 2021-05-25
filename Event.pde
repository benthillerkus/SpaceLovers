enum EventStatus {
    Before, OnEvent, After;
}

abstract class Event extends Layer {
    EventStatus status;

    Event() {
        super();
        reset();
    }

    @Override
    protected void reset() {
        status = EventStatus.Before;
    }

    @Override
    protected void update() {
        switch (status) {
            case Before:
                beforeEvent();
                break;
            case After:
                afterEvent();
                break;
            case OnEvent:
                status = EventStatus.After;
        }

        if (status != EventStatus.After && eventCondition()) {
            status = EventStatus.OnEvent;
            onEvent();
        }
    }

    abstract protected boolean eventCondition();

    abstract protected void beforeEvent();
    abstract protected void onEvent();
    abstract protected void afterEvent();
}