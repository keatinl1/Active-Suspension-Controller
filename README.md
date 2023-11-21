# Active-Suspension-Controller
Design and analysis of controller for active car suspension

## 1 - Transfer Function Derivation
Figure 1 shows the free body diagram of the car suspension where $M_s$ is the mass of a quarter of the car, $M_u$ is the mass of the wheel. The actuator generates a force that minimises the error between where $M_s$ is requested to be and where it is.

<p align="center">
  <kbd>
    <img src="https://raw.githubusercontent.com/keatinl1/Active-Suspension-Controller/main/images/fbd.png">
  </kbd>
</p>
<p align="center">
Figure 1: Free body diagram of suspension
</p>

$$~~~~~$$

Letting the sum of the forces equal zero, two equations were derived as shown below.

$$(M_1s^2+cs+K_1+K_2)X_1(s) - (cs+K_2)X_2(s) = F(s)$$

$$-(cs+K_2)X_1(s) - (M_2s^2+cs+K_2)X_2(s) = 0$$

$$~~~~~$$

To get the relation between $X_2(s)/F(s)$,

$$~~~~~$$

$$Ax=b$$

$$\begin{bmatrix} M_1s^2+cs+K_1+K_2 & -(cs+K_2) \\\ -(cs+K_2) & -(M_2s^2+cs+K_2) \end{bmatrix} \begin{bmatrix} X_1(s) \\\ X_2(s) \end{bmatrix} = \begin{bmatrix} F(s) \\\ 0 \end{bmatrix} $$


$$~~~~~$$

Then Cramers rule was used,

$$
X_2(s) = 
\frac{det\left( \begin{matrix} M_1s^2+cs+K_1+K_2 & F(s) \\\ -(cs+K_2) & 0 \end{matrix} \right)}{det\left( \begin{matrix} M_1s^2+cs+K_1+K_2 & -(cs+K_2) \\\ -(cs+K_2) & -(M_2s^2+cs+K_2) \end{matrix} \right)}
$$

$$~~~~~$$

After substituting in values the transfer function became:

$$
G(s) = \frac{X_2(s)}{F(s)}= \frac{250s + 4203}{3750s^4 + 8.75 \times 10^4s^3 + 1.572 \times 10^7s^2 + 4.75 \times 10^7s + 7.986 \times 10^8}
$$

$$~~~~~$$

## 2 - Root Locus

Next root locus was used to determine a suitable gain to set a desireable operating point

<p align="center">
  <kbd>
    <img src="https://raw.githubusercontent.com/keatinl1/Active-Suspension-Controller/main/images/root_locus.jpg">
  </kbd>
</p>
<p align="center">
Figure 2: Root Locus of G(s)
</p>

An overshoot of 30% is desired for this system, the damping ratio $\zeta$ is found with the following formula

$$~~~~~$$

$$
 \zeta = \frac{-\ln\left(\frac{PO}{100}\right)}{\sqrt{\pi^2 + \ln^2\left(\frac{PO}{100}\right)}} = \frac{-\ln\left(\frac{30}{100}\right)}{\sqrt{\pi^2 + \ln^2\left(\frac{30}{100}\right)}} = 0.3579
$$

$$~~~~~$$

<p align="center">
  <kbd>
    <img src="https://raw.githubusercontent.com/keatinl1/Active-Suspension-Controller/main/images/gain.jpg">
  </kbd>
</p>
<p align="center">
Figure 3: Operating point
</p>

The operating point is where the line at an angle of $cos^{-1}(0.3579)$ intersects the root locus. A gain of 377616 sets this operating point.

## 3 - Stability Margins using Bode plot

In order to examine the closed loop stability, the equivalent closed loop transfer function need to be derived using the equation. The system is unity feedback so there is no H(s).

$$
T(s) = 
\frac{KG(s)}{1+KG(s)}
$$

$$~~~~~$$

There is a function which does this for you in Octave

```
T = feedback(377616*G, 1);
```

Then using the margins function to display the Bode plot with stability margins overlayed,

```
margins(T);
```

Yields the following plot:

<p align="center">
  <kbd>
    <img src="https://raw.githubusercontent.com/keatinl1/Active-Suspension-Controller/main/images/bode.jpg">
  </kbd>
</p>
<p align="center">
Figure 4: Bode plot of closed-loop system
</p>
