import time
import datetime as dt
from LWWElementSet import LWWElementSet

def passed(test_name):
    print('Passed: {}'.format(test_name))

def failed(test_name):
    raise Exception('Failed: {}'.format(test_name))

def sleep(t=0.001):
    time.sleep(t)

def test_init(bias):
    try:
        test = LWWElementSet(bias)
    except:
        if bias in ['add', 'remove']:
            failed('init')
        else:
            pass

    passed('init')

def test_add(e, bias='add'):
    lww = LWWElementSet(bias)
    try:
        lww.add(e)
    except:
        failed('add')

    passed('add')

def test_remove(e, bias='add'):
    lww = LWWElementSet(bias)
    try:
        lww.remove(e)
    except:
        failed('remove')

    passed('remove')

def test_lookup(e=1, bias='remove'):
    lww = LWWElementSet(bias)

    lww.add(e)
    if e not in lww: failed('lookup')
    sleep()
    lww.remove(e)
    if e in lww: failed('lookup')
    
    lww.add(e)
    sleep()
    lww.remove(e)
    sleep()
    lww.add(e)
    if e not in lww: failed('lookup')
    sleep()
    lww.remove(e)
    
    lww.add(e)
    sleep()
    lww.add(e)
    sleep()
    if e not in lww: failed('lookup')
    lww.remove(e)


def test_merge(e=1, bias='add'):
    lww = LWWElementSet(bias)
    lww2 = LWWElementSet(bias)

    lww2.add(e)

    try:
        assert e not in lww
        lww.merge(lww2)
        if e not in lww: failed('merge')
    except:
        failed('merge')
    passed('merge')

def test_bias(e=1):
    now = dt.datetime.now()
    lww1 = LWWElementSet('add')
    lww2 = LWWElementSet('remove')

    lww1.add(e, add_time=now)
    lww1.remove(e, remove_time=now)
    if e not in lww1: failed('bias')

    lww2.add(e, add_time=now)
    lww2.remove(e, remove_time=now)
    if e in lww2: failed('bias')
    
    passed('bias')
     
if __name__ == '__main__':
    for b in ['add', 'remove', 'asdf']:
        test_init(b)
    test_bias()

    elements = [1,'a']
    for e in elements:
        test_add(e)
        test_remove(e)
        test_lookup(e)
        test_merge(e)
        


    