

class TestcaseInfo:
    def __init__(self, id="", name="", precondition="", steps=None):
        self.id = id
        self.name = name
        self.steps = steps
        self.precondition = precondition

    def get_id(self):
        return self.id

    def get_name(self):
        return self.name

    def get_steps(self):
        return self.steps

    def set_id(self, id):
        self.id = id

    def set_name(self, name):
        self.name = name

    def set_steps(self, steps):
        self.steps = steps

    def set_precondition(self, precondition):
        self.precondition = precondition

    def get_precondition(self):
        return self.precondition
