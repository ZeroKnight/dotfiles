#!/usr/bin/env python3

def running_divmod(initial, iterable):
    """A generator that repeatedly applies `divmod`, yielding each quotient.

    Yields a quotient for each divisor in `iterable`. The first dividend is the
    value given by `initial`, and all subsequent dividends will use the
    remainder from the `divmod` operation.
    """
    remainder = initial
    for divisor in iterable:
        quotient, remainder = divmod(remainder, divisor)
        yield quotient


def output(n, unit):
    if n > 1:
        unit = f'{unit}s'
    print(int(n), unit)


if __name__ == '__main__':
    with open('/proc/uptime') as proc:
        uptime = float(proc.readline().split()[0])
    days, hours, minutes = running_divmod(uptime, [86400, 3600, 60])
    if days:
        output(days, 'day')
    elif hours:
        output(hours, 'hour')
    elif minutes:
        output(minutes, 'minute')
    else:
        print('<1 minute')
