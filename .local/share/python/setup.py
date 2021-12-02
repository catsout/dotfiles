import atexit
import os
import sys
import readline

if hasattr(sys, '__interactivehook__'):
    del sys.__interactivehook__

if 'PYTHONHISTFILE' in os.environ:
    history = os.path.expanduser(os.environ['PYTHONHISTFILE'])
elif 'XDG_DATA_HOME' in os.environ:
    history = os.path.join(os.path.expanduser(os.environ['XDG_DATA_HOME']),
                           'python', 'python_history')
else:
    history = os.path.join(os.path.expanduser('~'),
                           '.python_history')
atexit.register(readline.write_history_file, history)
