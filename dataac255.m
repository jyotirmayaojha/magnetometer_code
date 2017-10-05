clear all;
clc;

a=arduino('/dev/tty.usbmodem1411')
%instrhwinfo('i2c')
yolo=i2cdev(a,'0x1E');
writeRegister(yolo,0,16);
pause(0.5);
a=readRegister(yolo,0);
writeRegister(yolo,1,224); % configuring the register B in for the +- 2.5 G
b=readRegister(yolo,1);
writeRegister(yolo,2,0);
c=readRegister(yolo,2);

disp(a);
disp(b);
disp(c);

bx=[];
by=[];
bz=[];
rnet=[];
zolo=clock;
c=1;

%      bx(c)=readRegister(yolo,3,'uint8');
%      by(c)=bitshift(readRegister(yolo,3),8);
%      disp(bx(c));
%      disp(by(c));

for i=zolo(5):0.0000016667:zolo(5)+2
bx(c)=double((typecast(bitor(bitshift(uint16(readRegister(yolo,3)),8),uint16(readRegister(yolo,4))),'int16')*4.35))/1000; 
by(c)=double((typecast(bitor(bitshift(uint16(readRegister(yolo,5)),8),uint16(readRegister(yolo,6))),'int16')*4.35))/1000;
bz(c)=double((typecast(bitor(bitshift(uint16(readRegister(yolo,7)),8),uint16(readRegister(yolo,8))),'int16')*4.35))/1000;
    m(c)=i;
    rnet(c)=(bx(c)*bx(c)+by(c)*by(c)+bz(c)*bz(c));
    pause(0.01);
      plot(m,bx);hold on;
      plot(m,by);hold on;
      plot(m,bz); hold on;
      plot(m,sqrt(rnet)); hold on;
    c=c+1;
 end;    