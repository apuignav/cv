#!/usr/bin/env python
# -*- coding: utf-8 -*-
# =============================================================================
# @file   make.py
# @author Albert Puig (albert.puig@cern.ch)
# @date   17.09.2014
# =============================================================================
"""Make the CV by adding and removing sections."""

import os
import argparse

template = r"""%%!TEX TS-program = xelatex
\documentclass[%s]{cv}

%% Section config
\usepackage{ifthen}
\newboolean{includeprogramming}\setboolean{includeprogramming}{%s}
\newboolean{includeconferences}\setboolean{includeconferences}{%s}
\newboolean{includeteaching}\setboolean{includeteaching}{%s}

\input{cv_content}

%% EOF
"""

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--no-programming', action='store_true', default=False)
    parser.add_argument('--no-conf', action='store_true', default=False)
    parser.add_argument('--no-teaching', action='store_true', default=False)
    parser.add_argument('-p', '--print-format', action='store_true', default=False)
    parser.add_argument('--dry-run', action='store_true', default=False)
    args = parser.parse_args()
    # Get values
    programming = 'false' if args.no_programming else 'true'
    conferences = 'false' if args.no_conf else 'true'
    teaching = 'false' if args.no_teaching else 'true'
    print_format = 'print' if args.print_format else ''
    # Write file
    text = template % (print_format, programming, conferences, teaching)
    if os.path.exists('cv_modified.tex'):
        os.remove('cv_modified.tex')
    with open('cv_modified.tex', 'w') as cv_file:
        cv_file.write(text)
    if not args.dry_run:
        if print_format:
            print_format = '_print'
        os.system('xelatex -jobname=cv cv_modified.tex && xelatex -jobname=cv%s cv_modified.tex' % print_format)
        os.remove('cv_modified.tex')

# EOF
