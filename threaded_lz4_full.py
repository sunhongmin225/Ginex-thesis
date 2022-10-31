#!/usr/bin/env python3

"""Illustrates (de)compression of multiple lz4framed files/streams"""

from time import monotonic
from sys import argv
from os import cpu_count
from io import BytesIO, SEEK_END
from concurrent.futures import ThreadPoolExecutor

from lz4framed import Decompressor, Compressor, Lz4FramedNoDataError


# Maximum read size in bytes during compression
READ_SIZE = 4 * 1024 * 1024


def decompress_file(filename):
    decompressed = BytesIO()
    with open(filename, 'rb') as raw:
        try:
            for chunk in Decompressor(raw):
                decompressed.write(chunk)
        except Lz4FramedNoDataError:
            # Data incomplete error case. In this example we simply ignore the data
            return b''
    decompressed.seek(0)
    # Returning filename also so produce mapping
    return (filename, decompressed)


def compress_file(filename):
    compressed = BytesIO()

    with open(filename, 'rb') as raw, Compressor(fp=compressed) as compressor:
        try:
            while True:
                compressor.update(raw.read1(READ_SIZE))
        except Lz4FramedNoDataError:
            # End of input file reached
            pass
    return (filename, compressed)


def main():
    # Try setting to 1 to see difference
    workers = cpu_count() or 1
    # workers = 1

    # Whether to test compression or decompression
    method = compress_file
    # method = decompress_file

    print('Will (de)compress with %d workers' % workers)

    pool = ThreadPoolExecutor(max_workers=workers)
    start = monotonic()

    # (De)compress all given files and produce of mapping file name to BytesIO instance. Alternatively could request
    processed = dict(pool.map(method, argv[1:]))

    print('Completed in %.2fs' % (monotonic() - start))

    for name, data in processed.items():
        if data:
            data.seek(0, SEEK_END)
            print('Size of %s: %d' % (name, data.tell()))
        else:
            print('Failed to (de)compress %s' % name)


if __name__ == '__main__':
    main()
