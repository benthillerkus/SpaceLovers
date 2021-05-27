enum EventStatus {
    Before, OnEvent, After;
}

class Event extends Layer {
    EventStatus status;
    int eventStart;

    Event() {
        super();
        reset();
    }

    @Override
    protected void reset() {
        status = EventStatus.Before;
        eventStart = -1;
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
                if (eventStart != frameCount)
                    status = EventStatus.After;
        }

        if (status != EventStatus.After && eventCondition()) {
            setEvent();
        }
    }

    boolean isNow() {
        return status == EventStatus.OnEvent;
    }

    void setEvent() {
        status = EventStatus.OnEvent;
        eventStart = frameCount;
    }

    protected boolean eventCondition() { return false; };

    protected void beforeEvent() {};
    protected void onEvent() {};
    protected void afterEvent() {};
}
