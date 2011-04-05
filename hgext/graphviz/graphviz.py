# graphviz.py - generate DOT language source to visualize changeset tree

###############################################################################

# Copyright (C) 2007- FUJIWARA Katsunori(foozy@lares.dti.ne.jp)
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

###############################################################################
#
# ChangeLog:
#
# 2008/02/19
#     * [bugfix] use '_' instead of '-' as a part of the key to look opts up.
#                this allows 'graphviz-hook' to be invoked, but not 'graphviz'.
#
# 2007/09/29
#     * [bugfix] hook returns 'False' to tell 'success' to Mercurial
#     * [bugfix] escape line breaking at logging hook information
#
# 2007/09/19
#     * enhance options, and so on
#     * add 'hook' for Mercurial
#     * add 'graphviz-hook' to invoke hook manually
#
# 2007/08/11
#     * first release
#
###############################################################################

'''This document explains detail of graphviz extension other than
command help document.

****
**** User name aliasing:
****

To reduce label length when username is used as part of it, you can
specify alias configuration file. This file should consists lines in
the following format, or lines which start with '#' as comment.

    ========================================
    AliasName=ActualName
    ========================================


****
**** Label/Tooltip formatting:
****

You can specify format of both label and tooltip(shown in client side
image map, for example) for renderred changesets.

You can use keywords shown below in format string, which should be in
Python style formatting. All keywords will be substituted by STRING.

    u: username(may be aliased)
    U: username(not aliased)
    r: changeset revision number
    s: short-form changeset hash (12 digits of hexadecimal)
    h: changeset hash (40 digits of hexadecimal)
    d: datetime of changeset
    t: first line of changeset description text

For example, "%(u)s|%(r)s" causes "commiter|revision#".


****
**** Grouping:
****

Grouping, especially of "by-date", may render changesets at
appropriate location for your sense.

With "group-by-date" option, graphviz extension groups changesets per
date. This grouping causes renderring rectangle per date.

With "group-by-branch" option, graphviz extension groups changesets
per branch, except for "default" one. This grouping causes renderring
rectangle per branche.

Please see "Renderring customization", if you want to hide such rectangles.


****
**** Renderring customization:
****

There are three hook options to control graph renderring.

Each option can accept two format:

    - string, which starts with "lambda ", as instant definition

    - fully qualified Python function name to load *.py file
      (e.g.: "module.name.function")

When hook returns empty string or None, graphviz extension does not
append attribute to renderring target object.

(1) node attribute hook

    This hook can append attributes to each nodes, and should have
    signature shown below:

        ========================================
        def hook(repository, revision, node, changes, getalias):
        ========================================

    Arguments are:

        - repo     : to which target revision belongs
        - rev      : revision number
        - node     : gotten by 'repo.lookup(rev)'
        - changes  : gotten by 'repo.changelog.rev(node)'
        - getalias : 'lambda name:' to get alias name for given name

    For example, you can highlight changesets, which certain user
    made, by code shown below:

        ========================================
        def hook(repo, rev, node, changes, getalias):
            return ((getalias(changes[1]) == 'someone')
                    and 'style = "filled", fontcolor = "white"'
                    or None)
        ========================================

(2) edge attribute hook

    This hook can append attributes to each edges, and should have
    signature shown below:

        ========================================
        def hook(repo, parent, child, first, getalias):
        ========================================

    Arguments are:

        - repo     : to which target revision belongs
        - parent   : form which edge is drawn
        - child    : to which edge is drawn
        - first    : whether parent is 1st one for child or not
        - getalias : 'lambda name:' to get alias name for given name

    Both "parent" and "child" are "(rev, node, changes)", so you can
    also define edge attribute hook as:

        ========================================
        def hook(repo, (pr, pn, pc), (cr, cn, cc), first, getalias):
        ========================================

(3) cluster attribute hook

    This hook can append attributes to each clusters(= grouping
    rectangles), and should have signature shown below:

        ========================================
        def hook(repo, branch, date)
        ========================================

    Arguments are:

        - repo     : to which target revision belongs
        - branch   : branch name
        - date     : date string("YYYYMMDD" format) or ""

    With "group-by-branch", this hook is (also) invoked for each
    branches other than "default". At invocation, "" is specified as
    date.

    With "group-by-date", this hook is invoked for each dates with
    branch name, which may be "default".

    Without "group-by-branch" nor "group-by-date", this hook is never
    invoked.

    For example, you can hide all rectangles by code shown below:

        ========================================
        def hook(repo, branch, date):
            return 'style=invis'
        ========================================

    Or to show rectangles only for branch grouping:

        ========================================
        def hook(repo, branch, date):
            return (date and 'style=invis')
        ========================================

    To fit for Graphviz DOT language specification, this hook should
    return ";" separated values differently from other hooks, which
    should return "," separated values.


****
**** Hook for Mercurial:
****

To update image file automatically, graphviz extension also provides
'hook' function. You can specify this for any hook configurations,
because it does not use any hook type depend arguments. But it may
be useful mostly as 'changegroup'/'commit' hook.

    ========================================
    [hooks]
    changegroup = python:graphviz.hook
    commit = python:graphviz.hook
    ========================================

You can control hook behavior by 'graphviz' section in your hgrc file(s).

    ========================================
    [graphviz]
    # REQUIRED: image file output location
    imagefile=%%(hgroot)s/.hg/revtree.jpg

    # opt.* is equivalent to corresponded option appearance in command line
    opt.revision=
    #opt.datetime=
    #opt.interval=
    opt.aliases=%%(hgroot)s/aliases
    opt.show-tags=
    opt.urlbase=http://localhsot:8000
    opt.format-label=%%(r)s
    opt.format-tooltip=%%(U)s/%%(t)s
    opt.group-by-date=
    opt.group-by-branch=
    #opt.node-attr-hook=
    opt.edge-attr-hook=fully.qualified.python.function
    opt.cluster-attr-hook=lambda repo, branch, date: 'style=invis'

    # limit-spec list
    limitspecs=-50,

    # command line option of Graphviz DOT command.
    dot_opts=-Nfontsize=9 -Grankdir=BT

    # intermediate DOT language source will be saved, if this is given.
    # it is saved in same location of 'imagefile', with '*.dot' suffix.
    dot_source=

    # client side image map file will be created, if this is given.
    # it is saved in same location of 'imagefile', with '*.html' suffix.
    imagemap=

    # prologue(= before '<img> tag') part of image map HTML file.
    prologue=<html><head><title>last updated by %%(r)s</title>....

    # epilogue(= after '<area> tag') part of image map HTML file.
    epilogue=....</html>
    ========================================

As you know from above example, you can specify some keyword
substitution in configuration. But you should use '%%' instead of '%'
in normal Python notation, to prevent Python library from auto
substitution at configuration file reading.

All keywords for "format-label" and "format-tooltip" are available,
and values for them are from tip changeset.

In addtion, keywords shown below are also available.

  - now: datetime at hook invocation
  - hgroot: root of target repository

Keyword substitution is applied for:

  - imagefile
  - opt.aliases
  - prologue
  - epilogue


****
**** Manyally hook invocation:
****

By "graphviz-hook" command, you can invoke graphviz extension hook
manually.

This allows you to examine hook configuration without commit/pull.
'''

###############################################################################

import cgi, errno, os, os.path, popen2, re, string, sys, time, threading

from mercurial.i18n import gettext as _
from mercurial.node import *
from mercurial import cmdutil, hg, util

########################################

dtregexp = re.compile('^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d$')

def escapeDQ(text):
    return text.replace('"', '\\"')

def escapeNL(text):
    return string.join(text.split())

def datetimestr(date):
    dt, zone = date
    return time.strftime('%Y-%m-%dT%H:%M:%S', time.localtime(float(dt)))

def datestr(date):
    dt, zone = date
    return time.strftime('%Y%m%d', time.localtime(float(dt)))
#    return time.strftime('%Y-%m-%d', time.localtime(float(dt)))

def getval(val, defval):
    return (val != "" and val or defval)

def get_1stline(text):
    index = text.find('\n')
    if index < 0:
        return text
    return text[:index]

def get_hook(hookname):
    if hookname.startswith('lambda '):
        return eval(hookname)

    delimit = hookname.rfind('.')
    if delimit < 0:
        raise util.Abort(_('hookname "%s" has no module part') % (hookname))
    try:
        modulename = hookname[:delimit]
        module = __import__(modulename)
        components = modulename.split('.')
        for component in components[1:]:
            module = getattr(module, component)
    except Exception, inst:
        raise util.Abort(_('failed to import hook "%s": %s') %
                         (hookname, inst))
    hook = getattr(module, hookname[delimit+1:], None)
    if (not hook) or (not callable(hook)):
        raise util.Abort(_('callable hook "%s" is not found') % (hookname))
    return hook

########################################

def graphviz(ui,
             repo,

             *limits,

             **opts):
    '''generate DOT language source to visualize changeset tree.

    "limit-spec" should be formatted in one of styles shown below:

        1. Start,End
        2. Start,
        3. ,End

    With "revision" option, "Start" and "End" should be ones which are
    acceptable for "-r" option of other Mercurial commands.
    With "datetime" option, they should be in dateTime format of XML Schema,
    which is known as "YYYY-MM-DDThh:mm:ss".
    With "interval" option, they should be specified as interval from
    invocation time(= "now") in second.

    Both "Start" and "End" are treated as "inclusive".
    '''

    ################

    def between_datetime(node, lower_dt, upper_dt):
        date = datetimestr(repo.changelog.read(node)[2])
        return ((lower_dt <= date) and (date <= upper_dt))

    def accept_by_dt(lower_dt, upper_dt):
        if (not dtregexp.match(lower_dt)):
            raise util.Abort(_('illegal datetime format: %s') % (lower_dt))
        if (not dtregexp.match(upper_dt)):
            raise util.Abort(_('illegal datetime format: %s') % (upper_dt))
        ui.note(('# visualize revision between "%s" - "%s"\n') % 
                (lower_dt, upper_dt))
        return lambda rev, node: between_datetime(node, lower_dt, upper_dt)

    def accept_by_interval(now, lower_interval, upper_interval):
        lower_dt = datetimestr((now - lower_interval, None))
        upper_dt = datetimestr((now - upper_interval, None))
        ui.note(('# visualize revision between "%s" - "%s"\n') % 
                (lower_dt, upper_dt))
        return lambda rev, node: between_datetime(node, lower_dt, upper_dt)

    def accept_by_rev(lower_rev, upper_rev):
        ui.note(('# visualize revision between "%d" - "%d"\n') % 
                (lower_rev, upper_rev))
        return lambda rev, node: ((lower_rev <= rev) and (rev <= upper_rev))

    def getrev(revname):
        return repo.changelog.rev(repo.lookup(revname))

    ui.note('# %s\n' % opts)

    ################
    # check limit type:

    types = 0
    types += (opts['revision'] and 1 or 0)
    types += (opts['datetime'] and 1 or 0)
    types += (opts['interval'] and 1 or 0)

    if 1 < types:
        raise util.Abort(_('-r, -d and -i are mutually exclusive'))

    ################
    # check urlbase options:

    if opts['urlbase']:
        ui.note(('# "-u %s" is specified\n') % (opts['urlbase']))
    urlbase = opts['urlbase'] or ''

    ################
    # check aliases option:

    aliases = {} # (key, val) => (username, alias)
    getalias = lambda name: aliases.get(name, name)

    if opts['aliases']:
        ui.note(('# "-a %s" is specified\n') % opts['aliases'])
        if os.path.isfile(opts['aliases']):
            f = open(opts['aliases'] ,"r")
            for line in f.readlines():
                line = line.strip()
                if '#' != line[0]:
                    alias, actual = line.split('=')
                    aliases[actual] = alias
                    ui.note(('# use "%s" as alias for "%s"\n') % 
                            (alias, actual))
            f.close()
        else:
            ui.warn(('%s: file not found, so skip reading aliases\n') % 
                    (opts['aliases']))

    ################
    # check format:

    ui.note(('# "%s" is recognized as label format\n') % 
            (opts['format_label']))
    ui.note(('# "%s" is recognized as tooltip format\n') % 
            (opts['format_tooltip']))

    ################
    # check attribute renderring hook:

    node_hook = lambda repo, rev, node, changes, alias: None
    if opts['node_attr_hook']:
        hookname = opts['node_attr_hook']
        ui.note(('# try to use "%s" as node attribute hook\n') %
                (escapeNL(hookname)))
        node_hook = get_hook(hookname)

    edge_hook = lambda repo, parent, child, first_parent, alias: None
    # (parentrev, parentnode, parentchanges) = parent
    # (childrev, childnode, childchanges) = child

    if opts['edge_attr_hook']:
        hookname = opts['edge_attr_hook']
        ui.note(('# try to use "%s" as edge attribute hook\n') %
                (escapeNL(hookname)))
        edge_hook = get_hook(hookname)

    cluster_hook = lambda repo, branch, date: None
    if opts['cluster_attr_hook']:
        hookname = opts['cluster_attr_hook']
        ui.note(('# try to use "%s" as cluster attribute hook\n') %
                (escapeNL(hookname)))
        cluster_hook = get_hook(hookname)

    ################
    # check limit specificaitons:

    accepts = [] # list of "lambda: rev, node:"
    def acceptable(rev, node):
        for accept in accepts:
            if accept(rev, node):
                return True
        return False

    if (0 == len(limits)):
        # all revisions will be visualized
        accepts.append(lambda rev, node: True)

    now = long(time.time())

    for limit in limits:
        fields = limit.split(',')
        if ((2 != len(fields)) or ((fields[0] == "") and (fields[1] == ""))):
            raise util.Abort(_('invalid limit specification: "%s"') % (limit))

        if opts['datetime']:
            accepts.append(accept_by_dt(getval(fields[0],
                                               "0001-01-01T00:00:00"), 
                                        getval(fields[1],
                                               "9999-12-31T23:59:59")))
        elif opts['interval']:
            accepts.append(accept_by_interval(now,
                                              int(getval(fields[0], now)),
                                              int(getval(fields[1], '0'))))
        else: # default type is revision
            accepts.append(accept_by_rev(getrev(getval(fields[0], "1")),
                                         getrev(getval(fields[1], "-1"))))

    ################
    # gather target revisions:

    revmap = {} # (key, val) => (rev, (node, changes))

    get = util.cachefunc(lambda r: repo.changectx(r).changeset())
    changeiter, matchfn = cmdutil.walkchangerevs(ui,
                                                 repo,
                                                 pats=None,
                                                 change=get,
                                                 opts={ 'rev': [] })
    for st, rev, b in changeiter:
        if (st == 'iter'):
            node = repo.lookup(rev);
            if acceptable(rev, node):
                revmap[rev] = (node, repo.changelog.read(node))

    ################
    # render source code for DOT language:

    ui.write(("digraph {\n"))

    branches = { }
    branchindex = 0

    group_by_branch = opts['group_by_branch']
    group_by_date = opts['group_by_date']

    for revision, (node, changes) in revmap.items():
        branch = (group_by_branch and changes[5].get("branch") or 'default')
        if not branches.has_key(branch):
            branches[branch] = ({ }, branchindex)
            branchindex += 1
        branchcluster, index = branches[branch]
        date = (group_by_date and datestr(changes[2]) or '')
        datecluster = branchcluster.get(date)
        if not datecluster:
            datecluster = [ ]
            branchcluster[date] = datecluster
        datecluster.append(revision)

    for branch, (branchcluster, index) in branches.items():
        if branch != 'default':
            ui.write(('subgraph cluster_%d {\n') % (index))

        for date, revs in branchcluster.items():
            if '' != date:
                ui.write(('subgraph cluster_%s_%s \n{') % (index, date))
                hooked = cluster_hook(repo, branch, date) or ''
                ui.write(('%s\n') % (hooked))

            for revision in revs:
                node, changes = revmap[revision]

                keywordmap = {
                    'u': getalias(changes[1]),
                    'U': changes[1],
                    'r': str(revision),
                    's': short(node),
                    'h': hex(node),
                    'd': datetimestr(changes[2]),
                    't': get_1stline(changes[4])
                }

                attr = []
                attr.append(('URL = "%s/rev/%s"') % (urlbase, short(node)))
                attr.append(('label = "%s"') % 
                            (escapeDQ(opts['format_label'] % keywordmap)))
                attr.append(('tooltip = "%s"') %
                            (escapeDQ(opts['format_tooltip'] % keywordmap)))
                hooked = node_hook(repo, revision, node, changes, getalias)
                if hooked:
                    attr.append(hooked)
                ui.write(('%d [ %s ]\n') % (revision, string.join(attr, ', ')))

            if '' != date:
                ui.write(('}\n'))

        if branch != 'default':
            hooked = cluster_hook(repo, branch, '') or ''
            ui.write(('%s\n') % (hooked))
            ui.write(('}\n'))

    if opts['show_tags']:
        tagindex = 0
        for tag, node in repo.tagslist():
            revision = repo.changelog.rev(node)
            if revmap.has_key(revision):
                ui.write(('tag_%d [ label="%s" shape=plaintext ]\n' % 
                         (tagindex, escapeDQ(tag))))
                ui.write(('tag_%d -> %s [ arrowhead=none, arrowtail=dot ]' % 
                         (tagindex, revision)))
                tagindex += 1

    for revision, (node, changes) in revmap.items():
        child = (revision, node, changes)
        first_parent = True
        for parentnode in repo.changelog.parents(node):
            parentrev = repo.changelog.rev(parentnode)
            if revmap.has_key(parentrev):
                pnode, pchanges = revmap[parentrev]
                parent = (parentrev, pnode, pchanges)
                hooked = edge_hook(repo, parent, child, first_parent, getalias)
                ui.write(('%d -> %d [ %s ] \n') % 
                         (parentrev, revision, (hooked or ' ')))
            first_parent = False

    ui.write(("}\n"))

########################################

class guardEPIPE:
    def __init__(self, guarded, stream):
        self.guarded = guarded
        self.stream = stream

    def __call__(self):
        try:
            try:
                self.guarded(self.stream)
            except IOError, inst:
                if inst.errno != errno.EPIPE: # other than 'already closed'
                    raise
        finally:
            self.stream.close()

def filtercommand(ui, 
                  command,
                  i_str,
                  o_filename,
                  o_prologue = None,
                  o_epilogue = None):
    pin, pout, perr = popen2.popen3(command, mode='b')
    o_file = open(o_filename, 'wb')

    def data_writer(stream):
        stream.write(i_str)

    def data_decorator(stream):
        if o_prologue:
            o_file.write(o_prologue)
        o_file.write(stream.read())
        if o_epilogue:
            o_file.write(o_epilogue)
        o_file.flush()

    def error_reader(stream):
        error = stream.read()
        if error:
            ui.warn(('error from "%s": %s\n') % (command, error))

    threads = [ threading.Thread(target=guardEPIPE(data_writer, pout)),
                threading.Thread(target=guardEPIPE(error_reader, perr)) ]

    for thread in threads:
        thread.start()

    try:
        guardEPIPE(data_decorator, pin)()
    finally:
        o_file.close()

    for thread in threads:
        thread.join()

####################

def split_path(path):
    dirname, filename = os.path.split(path)

    index = filename.rfind('.')
    if index < 0:
        raise util.Abort(_('path "%s" has no suffix' % (path)))

    basename = filename[:index]
    suffix = filename[index+1:]

    return (dirname, basename, suffix)

####################

default_prologue = '''<html>
<head><title>last updated at %(now)s by %(r)s/%(U)s</title></head>
<body>
<p>last updated at %(now)s by %(r)s/%(U)s</p>
'''

default_epilogue = '''<p>last updated at %(now)s by %(r)s/%(U)s</p>
</body>
</html>
'''

configtable = {
    'imagefile': None,
    'dot_opts': '',
    'prologue': default_prologue,
    'epilogue': default_epilogue,
    'imagemap': False,
    'dot_source': False,
}

########################################

def hook(ui, repo, hooktype, **args):
    ####################
    # get most recent changeset for value of some keywords:

    node = repo.lookup('tip')
    changes = repo.changelog.read(node)

    keywordmap = {
        'U': cgi.escape(changes[1]),
        'r': repo.changelog.rev(node),
        's': short(node),
        'h': hex(node),
        'd': datetimestr(changes[2]),
        't': cgi.escape(get_1stline(changes[4])),

        'now': datetimestr([time.time(), None]),
        'hgroot': repo.root,
    }

    if ui.verbose:
        for name, value in keywordmap.items():
            ui.note(('keyword:%s=%s\n' % (name, value)))

    ####################
    # get properties from 'graphviz' section:

    section = 'graphviz'

    config = {}
    for name, default in configtable.items():
        value = ui.config(section, name)
        if value is not None:
            config[name] = (default is False) or value
        elif default is None:
            raise util.Abort(_('"%s" is required in "%s" section') %
                             (name, section))
        else:
            config[name] = default
        ui.note(('config:%s=%s\n' % (name, config[name])))

    key = 'limitspecs'
    limitspecs = (ui.config(section, key) or '')
    limits = filter(lambda s: 0 != len(s), string.split(limitspecs, ' '))
    if ui.verbose:
        for limit in limits:
            ui.note(('limit:%s\n') % (limit))

    opts = {}
    for c, opt, default, desc in graphviz_optlist:
        name = ('opt.%s' % opt)
        value = ui.config(section, name)
        key = opt.replace('-', '_')
        if value is not None:
            opts[key] = (default is None) or value
        else:
            opts[key] = default
        ui.note(('opt:%s=%s\n' % (opt, opts[key])))

    opts['aliases'] = opts['aliases'] % keywordmap

    dirname, basename, suffix = split_path(config['imagefile'])

    ####################
    # invoke 'graphviz' extension

    ui.pushbuffer()
    graphviz(ui, repo, *limits, **opts)
    dot_source = ui.popbuffer()
    if config['dot_source']:
        dotfile = string.join([ basename, 'dot' ], '.')
        filename = (os.path.join(dirname, dotfile) % keywordmap)
        ui.note(('filename:%s\n') % (filename))
        f = open(filename, 'wb')
        try:
            f.write(dot_source)
            f.flush()
        finally:
            f.close()

    ####################
    # invoke graphviz 'dot' command for image file

    cmd = string.join([ 'dot', ('-T%s' % suffix), config['dot_opts'] ], ' ')
    ui.note(('command:%s\n') % (cmd))
    filename = (config['imagefile'] % keywordmap)
    ui.note(('filename:%s\n') % (filename))
    filtercommand(ui,
                  cmd,
                  dot_source,
                  filename)

    ####################
    # invoke graphviz 'dot' command for image map file

    if not config['imagemap']:
        return

    cmapfile = string.join([ basename, 'html' ], '.')
    imgtag = ('<img src="%s" usemap="_anonymous_0">' % 
              (string.join([ basename, suffix], '.')))

    cmd = string.join([ 'dot', ('-T%s' % 'cmapx'), config['dot_opts'] ], ' ')
    ui.note(('command:%s\n') % (cmd))
    filename = (os.path.join(dirname, cmapfile) % keywordmap)
    ui.note(('filename:%s\n') % (filename))
    filtercommand(ui, 
                  cmd,
                  dot_source,
                  filename,
                  o_prologue=((config['prologue'] % keywordmap) + imgtag),
                  o_epilogue=(config['epilogue'] % keywordmap))

    return False
    # tells 'success' to Mercurial

########################################

def graphviz_hook(ui,
                 repo,
                 **opts):
    '''invoke graphviz hook from command line.

    This is usefull to examine graphviz hook configuration.
    '''
    hook(ui, repo, None, **{})

########################################

graphviz_optlist = [
    ('r', 'revision', None, _('use revision to limit targets(default)')),
    ('d', 'datetime', None, _('use datetime to limit targets')),
    ('i', 'interval', None, _('use interval from NOW to limit targets')),

    ('a', 'aliases', '', _('file with user name aliases')),
    ('', 'show-tags', None, _('show tags in graph')),

    ('u', 'urlbase', '', _('url base for client side image map')),

    ('', 'format-label', '%(r)s', _('format of changeset label')),
    ('', 'format-tooltip', '%(U)s/%(t)s', _('format of changeset tooltip')),

    ('', 'group-by-date', None, _('group changesets per date')),
    ('', 'group-by-branch', None, _('group changesets per branch')),

    ('', 'node-attr-hook', '', _('hook to render node attribute')),
    ('', 'edge-attr-hook', '', _('hook to render edge attribute')),
    ('', 'cluster-attr-hook', '', _('hook to render cluster attribute')),
]

cmdtable = {
    'graphviz':
    (graphviz, 
     graphviz_optlist,
     'hg graphviz [limit-spec ...]'),

    'graphviz-hook':
    (graphviz_hook,
     [ 
     ],
     'hg graphviz-hook'),
    }

########################################
