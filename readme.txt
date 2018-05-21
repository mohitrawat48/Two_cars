*The Game was developed on Altera DE-II.
*For more information read comments within systemverilog files, C files and also read the documentation

*To Run the Game on ALtera DE-II

1) Using "two_cars/DE2_115_ControlPanel_V2.2.0/DE2_115_ControlPanel.exe" write "two_cars/sprites/sram.ram" on SRAM of
   Altera De-II

2) Using "two_cars/DE2_115_ControlPanel_V2.2.0/DE2_115_ControlPanel.exe" write "two_cars/audio/song.ram" on Flash memory of 
   Altera De-II

3) open Lab8.qpf on Quartus and compile with "two_cars/two_cars_top.sv" as top level file

4) Open Eclipse, Generate BSP and run the main.c. 