# Kuramoto Model Simulations

These simulations investigate a Kuramoto model system of oscillators. All oscillators interact via a phase-minimizing coupling term.

This project aims to replicate and expand on the simulations performed in the research paper [“Physics of the Rhythmic Applause”](http://journals.aps.org/pre/abstract/10.1103/PhysRevE.61.6987) by Néda, Z., E. Ravasz, T. Vicsek, Y. Brechet, and A. L. Barabási. This [review on Kurthe amoto model](http://journals.aps.org/rmp/abstract/10.1103/RevModPhys.77.137) is also a useful resource.

Numerical simulations were implemented using the Euler method for time integration.

## Simulation Outline

Parameters:
 - `K` coupling strength
 - `D` variance in natural frequency (`omegaNtr`) distribution
 - `N` number of oscillators

Initial Conditions in most cases are a uniform distribution in initial oscillator phase,

``` matlab
for i = 1:N;
    theta(i) = rand*2.0*pi;
end
```
and a normal distribution in oscillator natural frequency
``` matlab
for i = 1:N;
    omegaNtr(i) = sqrt(D)*randn + omegaMean;
end
```

### Files

### `kura1.m`

Outputs the time evolution of the order parameter `r`.

### `plot_kura1.m`

Must run `kura1` before this script. Plots the simulation results from `kura1.m` alongside figure 10 from the aforementioned Kuramoto review for comparison.

### `kura2.m`

Run a simulation which is an attempt to recreate the behavior seen in the simulations performed in the *Physics of Rythmic Applause* paper.

Useful Outputs:
- `momega` oscillator frequency at each recorded point in time
- `int` mean oscillator frequency, also referred to as intensity
- `r` order parameter
- `mi`, `mr` time-averaged intensity and order parameter corresponding to times `mt`

### `ordertest1.m`

Parameter scan over different values of the coupling strength. For each value of `K` the order parameter is calculated.

Useful Outputs:
- `Kmat` all scanned `K` values
- `rRun` order parameter values corresponding to each `K`
