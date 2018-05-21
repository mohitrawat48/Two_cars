*The Game was developed on Altera DE-II.
*For more information read comments within systemverilog files, C files and also read the documentation


**********************************************************
*To Run the Game on ALtera DE-II

1) Using "two_cars/DE2_115_ControlPanel_V2.2.0/DE2_115_ControlPanel.exe" write "two_cars/sprites/sram.ram" on SRAM of
   Altera De-II

2) Using "two_cars/DE2_115_ControlPanel_V2.2.0/DE2_115_ControlPanel.exe" write "two_cars/audio/song.ram" on Flash memory of 
   Altera De-II

3) open Lab8.qpf on Quartus and compile with "two_cars/two_cars_top.sv" as top level file

4) Open Eclipse, Generate BSP and run the main.c.

********************************************************** 


**********************************************************
*Writing Sprites

We wanted to write our sprites on SRAM, such that one particular pixel is saved at one particular address. 
Since a word on SRAM is 16 bits. Only 16 bits can be saved at a single address.

However, we know an RGB color is 24 bits. For this reason we have to
get rid of some bits such that we don't lose 
much of the color accuracy.

So first separate the 8bits for each group (R,G and B).
From Red take 5 Most significant bits.
From Green take 6 Most significant bits.
From Blue take 5 Most significant bits.
And then Concatenate these 16 bits.


However, "two_cars/sprites/pngToHex.py" already does this. It can take .png file
and convert it to .ram while converting 24 to 16 bits per pixel.

"two_cars/sprites/pngToHex.py" can also convert .png to a .txt file
while converting 24 to 16 bits per pixel. Which can be used for 
onchip memory (M9K memory block). Converting 24 to 16bits for onchip 
memory can save you space and compile time.

**********************************************************

**********************************************************
*Writing audio

we fist use "two_cars/audio/Downsampler.py" to downsample "two_cars/audio/song2.wav"
to "two_cars/audio/downsampled.wav"
which downsamples 44khz to 16Khz.
And then "two_cars/audio/wavToBytes.py" to convert "two_cars/audio/downsampled.wav"
to "two_cars/audio/song.ram". song.ram should be then uploaded on flash memory
using "two_cars/DE2_115_ControlPanel_V2.2.0/DE2_115_ControlPanel.exe"

Here is something to note, in "two_cars/audio_interface.vhd" the bitrate is
set to 32Khz. Meaning your music should be in 32khz in order sound just perfect.
However, our music is in 16Khz, but still it sounds perfect.

So either our python script is incorrect where it is actually downsampling to 32khz
instead of 16khz.
Or
there is a problem somewhere is audio system, where it is actually playing the 
music at 16khz.  


**********************************************************










    