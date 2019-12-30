import datetime as dt
import time

class LWWElementSet:
    def __init__(self, bias):
        assert bias in ['add', 'remove'], "bias can only be 'add' or 'remove'"
        self.add_set = {}
        self.remove_set = {}
        if bias == 'add':
            self.bias_add = True
        elif bias == 'remove':
            self.bias_add = False
        else:
            Exception()
        return

    def get_add_set(self):
        return self.add_set

    def get_remove_set(self):
        return self.remove_set

    def add(self, e, add_time=None): # only last added time is useful
        if add_time == None: add_time = time.time()
        self.add_set[e] = add_time
        return

    def remove(self, e, remove_time=None): # only last removed time is useful
        if remove_time == None: remove_time = time.time()
        self.remove_set[e] = remove_time
        return

    def merge(self, lww2):
        self.add_set = {**self.add_set, **lww2.add_set}
        self.remove_set = {**self.remove_set, **lww2.remove_set}
        return

    def __contains__(self, item):
        if item not in self.add_set:
            return False
        else:
            if item not in self.remove_set:
                return True
            else:
                if self.add_set[item] > self.remove_set[item]:
                    return True
                elif self.add_set[item] == self.remove_set[item]:
                    return True if self.bias_add else False
                else:
                    return False

