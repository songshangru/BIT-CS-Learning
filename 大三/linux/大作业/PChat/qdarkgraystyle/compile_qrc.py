#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# The MIT License (MIT)
#
# Copyright (c) <2013-2014> <Colin Duquesnoy>
# Copyright (c) <2017-2018> <Michell Stuttgart>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
"""
Utility scripts to compile the qrc file. The script will
attempt to compile the qrc file using the following tools:
    - pyrcc5

Delete the compiled files that you don't want to use 
manually after running this script.
"""
import os
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)


def compile_all():
    """
    Compile style.qrc  pyrcc5
    """
    logger.info('Compiling for PyQt5: style.qrc -> pyqt5_style_rc.py')
    os.system('pyrcc5 style.qrc -o pyqt5_style_rc.py')


if __name__ == '__main__':
    compile_all()
