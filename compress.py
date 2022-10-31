import lz4framed
import numpy as np

# my_file = open('my_array.lz4', 'wb')
# my_array = np.random.randint(1000000, size=1000)
my_array_0 = np.array([8, 13, 3, 1])
my_array_1 = np.array([18, 23, 4, 2])
my_array_2 = np.array([7, 33, -1, 10])
arrays = list()
arrays.append(my_array_0)
arrays.append(my_array_1)
arrays.append(my_array_2)
# my_array = b'abcde'
# compressed = lz4framed.compress(b'binary data')
# compressed = lz4framed.compress(my_array)
# print(compressed)
# my_file.write(compressed)
# my_file.close()

with open('my_array.lz4', 'wb') as f:
	with lz4framed.Compressor(f) as c:
		try:
			for my_array in arrays:
				c.update(my_array)
		except lz4framed.Lz4FramedNoDataError:
			print('arcmsh::Lz4FramedNoDataError')

# my_file_r = open('my_array.lz4', 'rb')

decoded = list()
with open('my_array.lz4', 'rb') as f:
	try:
		for chunk in lz4framed.Decompressor(f):
			decoded.append(chunk)
	except lz4framed.Lz4FramedNoDataError:
		print('arcmsh::Lz4FramedNoDataError')

# decompressed = lz4framed.decompress(my_file_r.read())
import pdb; pdb.set_trace()
# print(decompressed)
# my_file_r.close()
