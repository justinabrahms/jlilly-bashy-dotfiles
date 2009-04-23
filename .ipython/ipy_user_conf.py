import os
import time
import readline
import ipy_defaults
import IPython.ipapi
import ipy_stock_completers
 
ip = IPython.ipapi.get()
o = ip.options
 
o.autocall = False
o.autoedit_syntax = True
o.autoindent = True
o.automagic = True
o.banner = False
o.confirm_exit = False
o.messages = False
o.autoexec.append('%colors Linux')
 
# Make the prompt a bit more like the standard shell.
o.prompt_in1 = '[\#] >>> '
o.prompt_in2 = ' .\D.: '
o.prompt_out = '[\#] : '
o.separate_out = ''
o.separate_out2 = ''
 
# Set up logging by Y/M/D directories
logdir = os.path.expanduser(time.strftime("~/.ipython/logs/%Y/%m/"))
logfile = os.path.join(logdir, time.strftime("%d.log"))
if not os.path.exists(logdir):
    os.makedirs(logdir)
ip.magic("logstart %s append" % logfile)
