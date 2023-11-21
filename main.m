clc; clear all; close all;

# 0 - Setup

pkg load control;
s = tf('s');


# 1 - Define transfer function

G = (250*s+4203)/(2*(1875*s^4+43750*s^3+7860525*s^2+23750000*s+399285000));


# 2 - Root locus

rlocusx(G);


# 3 - Bode

T = feedback(1159344*G, 1);
bode(T);


