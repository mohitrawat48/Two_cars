import sys
from PIL import Image
import binascii
import struct
import numpy as np

im = Image.open(sys.argv[2])
newImage = Image.new("RGB",(im.size[0],im.size[1]))
newPix = newImage.load()


if(sys.argv[1]=='1'):
    f = open("ImageOutput.ram",'wb')
    #pix = im.load()
    rgb_pix = im.convert('RGB')
    print ("Image Resolution" + str(im.size))

    for j in range(im.size[1]):
        print ("row",j)
        for i in range(im.size[0]):
            #print (rgb_pix.getpixel((i,j)),end=" ")
            r,g,b = rgb_pix.getpixel((i,j))
            new_r = (r&0xFF) >> 3
            new_g = (g&0xFF) >> 2
            new_b = (b&0xFF) >> 3
            pixel_value = (new_r << 11) | (new_g <<5) | (new_b)
            #print ("(",new_r,new_g,new_b,")",'16-bit Hex_value','{:04X}'.format(pixel_value))
            packedData = struct.pack("<H",pixel_value)    
            #binstr = binascii.unhexlify('{:04X}'.format(pixel_value))
            f.write(packedData)
            #pix[i,j] = (new_r<<3,new_g<<2,new_b<<3,255)
            newPix[i,j] = (((pixel_value&0xF800)>>11)<<3,((pixel_value&0x07E0)>>5)<<2,(pixel_value&0x1F)<<3)
            #im.save("out.bmp")
    newImage.save("16bitout.bmp")
elif(sys.argv[1]=='2'):
    if(sys.argv[3] == 'new'):
        f = open("sprite_char.txt",'w')
    elif(sys.argv[3] == 'append'):
         f = open("sprite_char.txt",'a')
    rgb_pix = im.convert('RGB')

    print ("Image Resolution" + str(im.size))
    for j in range(im.size[1]):
        print ("row",j)
        for i in range(im.size[0]):
            r,g,b = rgb_pix.getpixel((i,j))
            #print (r,g,b)
            if(b<10):
                f.write('3\n')
            elif(r>=250 and g>=250 and b>=250):
                f.write('1\n')
            elif(b>=239):
                f.write('2\n')
            else:
               f.write('0\n')
        #f.write('0\n') #Special only for numbers