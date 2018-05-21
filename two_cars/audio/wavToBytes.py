import wave
import sys
import struct

sf = wave.open(sys.argv[1],'r')

of = open("song.ram",'ab')

print("Channels:",sf.getnchannels())
print("SampleWidth:", sf.getsampwidth())
print("FrameRate:",sf.getframerate())
print("Converting to MonoChannel ram file")

length = sf.getnframes()
byte_counter = 0
for i in range(length):
    frame = sf.readframes(1)
    frame_values = struct.unpack("HH",frame)
   # print("FrameData:",frame,frame_values,struct.pack("<H",frame_values[0]))
    of.write(struct.pack("<H",frame_values[0]))
    byte_counter = byte_counter+2

print("Bytes Written =",int(byte_counter),hex(byte_counter))