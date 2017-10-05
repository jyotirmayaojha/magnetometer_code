
clear all;
clear;
a=arduino('/dev/tty.usbmodem1411')
yolo=i2cdev(a,'0x1E');
% a=readRegister(yolo,9);
% disp(a);
avgx=0;
avgy=0;
avgz=0;
% typecast(avgx,'uint16');
% typecast(avgy,'uint16');
% typecast(avgz,'uint16');
  writeRegister(yolo,0,113); pause(0.5);
  writeRegister(yolo,1,160); pause(0.5);
  writeRegister(yolo,2,0); pause(0.5);
  xy=readRegister(yolo,0);
  yx=readRegister(yolo,1);
  yz=readRegister(yolo,2);
  disp(xy);
  disp(yx);
  disp(yz);
  
  for i=0:1:7   
  %   taking average for 8 values
      testx=double(typecast(bitor(bitshift(uint16((readRegister(yolo,3))),8),uint16(readRegister(yolo,4))),'int16')) ;      
      testy=double(typecast(bitor(bitshift(uint16((readRegister(yolo,5))),8),uint16(readRegister(yolo,6))),'int16'));
      testz=double(typecast(bitor(bitshift(uint16((readRegister(yolo,5))),7),uint16(readRegister(yolo,8))),'int16'));
      
       avgx=avgx+testx;
       avgy=avgy+testy;
       avgz=avgz+testz;
       
       disp('data from magnetometer');
       disp(testx);
       disp('');
       disp(testy);
       disp('');
       disp(testz);
       disp('averages');
       disp(avgx); disp('');
       disp(avgy); disp('');
       disp(avgy);
       
       pause(0.067);
  end;     
 
avgx=avgx/8;
avgy=avgy/8;
avgz=avgz/8;
disp('calculated averages');
disp(avgx);
disp('');
disp(avgy);
disp('');
disp(avgz);
disp('');

if(abs(avgx) >= 243 && abs(avgx) <= 575)
    disp('within limits');
    passx=1;
else
    disp('not within limits');
    passx=0;
end 
if(abs(avgy) >= 243 && abs(avgy) <= 575)
    disp('within limits');
    passy=1;
else
    disp('not within limits');
    passy=0;
end
if(abs(avgx) >= 243 && abs(avgx) <= 575)
    disp('within limits');
    passz=1;
else
    disp('not within limits');
    passz=0;
end 


 if(passx == 1 && passy == 1 && passz == 1) 
    writeRegister(yolo,1,112);             
    pause(0.010);
    disp('Self Test Passed - Moving On');
 else
       disp('Self test failed');
 end
 
% fscanf(yolo);



        




     
     