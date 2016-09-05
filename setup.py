#!/usr/bin/python

import os
import subprocess
import sipconfig
import PyQt5.QtCore

from setuptools import setup, Extension
from setuptools.command.build_ext import build_ext


class BuildExt(build_ext):
    def run(self):
        for path in files_to_moc:
            moc = path_of_moc_file(path)
            cmd = 'moc-qt5 -o %s %s' % (moc, path)
            print(cmd)
            subprocess.check_call(cmd.split())

        os.chdir(os.path.join(base_dir, 'src'))
        subprocess.call(sip_cmd.split())

        os.chdir(base_dir)
        build_ext.run(self)


os.chdir(os.path.abspath(os.path.dirname(__file__)))
base_dir = os.getcwd()

sip_config = sipconfig.Configuration()

sip_cmd = ' '.join([
    sip_config.sip_bin,
    '-c .',
    '-I /usr/share/sip/PyQt5',
    PyQt5.QtCore.PYQT_CONFIGURATION['sip_flags'],
    'pygqrx.sip'
])


cflags = [
    '-g',
    '-Wall',
    '-std=c++14',
    '-fPIC',
    '-mtune=generic',
    '-O2',
    '-fstack-protector-strong',
    '-I.',
    '-I/usr/include/python2.7'
]
cflags.extend(subprocess.check_output('pkg-config --cflags Qt5Core Qt5Widgets'.split()).split())

ldflags = [
    '-lpython2.7',
    '-shared',
    '-Wl,-O1,--sort-common,--as-needed,-z,relro'
]
ldflags.extend(subprocess.check_output('pkg-config --libs Qt5Core Qt5Widgets'.split()).split())

files_to_moc = [
    'src/bookmarks.h',
    'src/bookmarkstablemodel.h',
    'src/bookmarkstaglist.h',
    'src/freqctrl.h',
    'src/meter.h',
    'src/plotter.h',
]

def path_of_moc_file(path):
    fname = os.path.splitext(os.path.basename(path))[0]
    basedir = os.path.dirname(path)
    return os.path.join(basedir, 'moc_%s.cpp' % fname)

mocked_files = list(map(path_of_moc_file, files_to_moc))

pygqrx = Extension(
    name = 'pygqrx',
    sources = [
        'src/bookmarks.cpp',
        'src/bookmarkstablemodel.cpp',
        'src/bookmarkstaglist.cpp',
        'src/freqctrl.cpp',
        'src/meter.cpp',
        'src/plotter.cpp',
        'src/sippygqrxCFreqCtrl.cpp',
        'src/sippygqrxCMeter.cpp',
        'src/sippygqrxCPlotter.cpp',
        'src/sippygqrxBookmarks.cpp',
        'src/sippygqrxTagInfo.cpp',
        'src/sippygqrxBookmarkInfo.cpp',
        'src/sippygqrxcmodule.cpp',
        'src/sippygqrxQList0100BookmarkInfo.cpp',
        'src/sippygqrxQList0100TagInfo.cpp',

    ] + mocked_files,
    include_dirs = ['src'],
    extra_compile_args=cflags,
    extra_link_args=ldflags
)

setup(name='pygqrx',
    version='0.1',
    description='Python wrapper for Qt widgets used by Gqrx',
    long_description='Uses SIP to export the CFreqCtrl, CPlotter and CMeter widget used by Gqrx',
    author='Alexander Fasching',
    author_email='fasching.a91@gmail.com',
    maintainer='Alexander Fasching',
    maintainer_email='fasching.a91@gmail.com',
    url='https://github.com/alexf91/pygqrx',
    license='GPL',
    cmdclass={'build_ext': BuildExt},
    ext_modules=[pygqrx]
)
