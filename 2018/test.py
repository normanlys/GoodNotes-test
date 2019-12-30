import time
import datetime as dt
from unittest import TestCase
from LWWElementSet import LWWElementSet

class MyTest(TestCase):
    def sleep(self, t=0.000001):
        time.sleep(t)

    def test_setup(self):
        self.lwwa = LWWElementSet('add')
        self.lwwr = LWWElementSet('remove')

    def test_add(self, e=1):
        self.lwwa.add(e)
        self.assertIn(e, self.lwwa)

    def test_remove(self, e=1):
        self.lwwa.add(e)
        self.sleep()
        self.lwwa.remove(e)
        self.assertNotIn(e, self.lwwa)

    def test_lookup(self, e=1):
        self.lwwa.add(e)
        self.sleep()
        self.lwwa.remove(e)
        self.sleep()
        self.lwwa.add(e)
        self.assertIn(e, self.lwwa)

     
if __name__ == '__main__':
    test = MyTest()
    test.test_setup()
    test.test_add()
    test.test_remove()
    test.test_lookup()