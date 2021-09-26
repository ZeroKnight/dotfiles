"""ZeroKnight's Ultisnips utilities

Helper functions and classes for use with the Ultisnips Vim plugin. Similar to
honza's vimsnippets.py.
"""

import vim
import vimsnippets as vs

def get_csv(line: str):
    """Expand a string containing simple comma-separated values into a list.

    Can be used as a generic "get arguments" function.
    """
    args = (arg.lstrip() for arg in line.split(',') if line)
    return [arg for arg in filter(lambda x: x, args)]

def get_args(line: str):
    """Expand a string containing Python function parameters into a list.

    Returns a list of tuples holding the parameter name and its annotation.
    """
    args = []
    if line:
        for arg in map(lambda x: x.lstrip(), line.split(',')):
            temp = arg.split('=')[0].split(':')
            attr = temp[0]
            anno = temp[1].lstrip() if len(temp) > 1 else None
            if attr and attr != 'self':
                args.append((attr, anno))
    return args

def gen_list_of_tabstops(snip, n, delim=', '):
    """Generates `n` tabstops in a delimited list format.

    This function should be called via `post_jump` and triggered on a specific
    tabstop that marks where the generated tabstops should be inserted, e.g.

      post_jump "if snip.tabstop == 3: gen_list_of_tabstops(snip, 5, '|')"

    Given ``n = 3`` and ``delim = ', '``, the snippet will then behave as if the
    following was part of its definition:

      $1, $2, $3
    """
    # Create one fewer tabstops and manually append a final ', ' since the
    # initial tabstop in the snippet is preserved even after post_jump unless
    # the line is nuked.
    snip.expand_anon(delim.join([f'${i}' for i in range(1, n)]) + delim)

def close_docstring(tabstop, snip, standalone: bool=False):
    """Closes the docstring in the given tabstop.

    Ensures proper closure by automatically adding a newline and proper
    indentation when the docstring becomes a multi-line docstring.

    Set `standalone` to ``True`` for free-standing docstrings not immediately
    following any ``class`` or ``def`` statement. This works around an inability
    to detect the proper indentation level for the closing quotes.
    """
    if '\n' in tabstop:
        if not standalone:
            snip >> 1
        snip += '"""'
    else:
        snip.rv = '"""'

def if_ts(tabstop, snip, text):
    """Sets ``snip.rv`` to `text` if the specified `tabstop` is not empty.

    Tabstops are also considered empty if they contain only whitespace."""
    snip.rv = text if tabstop and not tabstop.isspace() else ''

def maybe_surround(tabstop, snip, text, opening, closing):
    """Surround `text` if the specified `tabstop` is not empty.

    Wraps `text` in the `opening` and `closing` surroundings as long as
    `tabstop` is not empty or `None`, then sets ``snip.rv`` equal to `text`.
    Otherwise, ``snip.rv`` is set to the empty string. Useful for optional
    components within parentheses or brackets. For example::

        maybe_surround(t[2], snip, 'foobar', opening='(', closing=')')

    Would expand to ``(foobar)`` *only if* ``t[2]`` was not empty or `None`.
    """
    snip.rv = f'{opening}{text}{closing}' if text else ''


def comment_tag(tag: str, snip):
    """Insert a comment tag."""
    snip.rv = f'{vs.get_comment_format()[0]} {tag.upper()}:'
