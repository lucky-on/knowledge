#!/usr/bin/env python2.7

import subprocess as subp
import os.path
import sys
import re
from collections import defaultdict


def psaxo():
    cmd = ['ps', 'axo', 'ppid,pid,comm']
    proc = subp.Popen(cmd, stdout=subp.PIPE)
    proc.stdout.readline()
    for line in proc.stdout:
        yield line.rstrip().split(None,2)


def hieraPrint(pidpool, pid, prefix=''):
    if os.path.exists(pidpool[pid]['cmd']):
        pname = os.path.basename(pidpool[pid]['cmd'])
    else:
        pname = pidpool[pid]['cmd']
    ppid = pidpool[pid]['ppid']
    pppid = pidpool[ppid]['ppid']
    try:
        if pidpool[pppid]['children'][-1] == ppid:
            prefix = re.sub(r'^(\s+\|.+)[\|`](\s+\|- )$', '\g<1> \g<2>', prefix)
    except IndexError:
        pass
    try:
        if pidpool[ppid]['children'][-1] == pid:
            prefix = re.sub(r'\|- $', '`- ', prefix)
    except IndexError:
        pass
    sys.stdout.write('{0}{1}({2}){3}'.format(prefix, pname, pid, os.linesep))
    if len(pidpool[pid]['children']):
        prefix = prefix.replace('-', ' ')
        for idx, spid in enumerate(pidpool[pid]['children']):
            hieraPrint(pidpool, spid, prefix+' |- ')

if __name__ == '__main__':
    pidpool = defaultdict(lambda: {"cmd": "", "children": [], 'ppid': None})
    for ppid, pid, command in psaxo():
        ppid = int(ppid)
        pid = int(pid)
        pidpool[pid]["cmd"] = command
        pidpool[pid]['ppid'] = ppid
        pidpool[ppid]['children'].append(pid)

    hieraPrint(pidpool, 1, '')
