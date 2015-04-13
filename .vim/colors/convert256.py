#!/usr/bin/python
# vim: tabstop=4 expandtab shiftwidth=4 fileencoding=utf8
# Peter Todd <pete@petertodd.org>

"""
Convert standard gvim color scheme to programmatic function approximation.
"""

import sys

for l in sys.stdin:
    l = l.strip().split()
    if l and l[0] == 'hi':
        color_name = l[1]
        if l[2:]:
            pairs = {}
            for n,v in map(lambda s: s.split('='),l[2:]):
                pairs[n] = v

            pairs['color_name'] = color_name
            pairs['guifg'] = pairs.get('guifg','#')[1:] # strip leading #
            pairs['guibg'] = pairs.get('guibg','#')[1:]
            pairs['gui'] = pairs.get('gui','')
            print 'call <SID>X("%(color_name)s","%(guifg)s","%(guibg)s","%(gui)s")' % pairs
