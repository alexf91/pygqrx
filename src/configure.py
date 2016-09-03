import subprocess

import sipconfig
import PyQt5.QtCore

config = sipconfig.Configuration()

sip_cmd = ' '.join([
    config.sip_bin,
    '-c .',
    '-I /usr/share/sip/PyQt5',
    PyQt5.QtCore.PYQT_CONFIGURATION['sip_flags'],
    'pygqrx.sip'
])

print(sip_cmd)
subprocess.call(sip_cmd.split())
