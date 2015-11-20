program kuraclap

use utility

!!! allocate variables !!!
implicit none
integer :: i, j, k, l, t
integer :: tmax

real(b8) :: groupI, q, time, t0
real(b8), allocatable :: theta(:), omega(:), ntrlOmega(:)


!!! set inital parameter values !!!
tmax = 6000


!!! allocate array size !!!
allocate( theta(Ntotal))
allocate( ntrlOmega(Ntotal))
allocate( omega(Ntotal))


call cpu_time(t0)
call init_random_seed()


theta      = 0.0000_b8
omega  = 0.0000_b8
ntrlOmega = 0.0000_b8

! set thetaillator angles and frequencies
do i = 1, Ntotal
    theta(i) = 2.0000_b8*pi*ran1()
    ntrlOmega(i) = normal( meanFreq, sqrt(D))
    omega(i)  = ntrlOmega(i)
    write(100,*) omega(i)
enddo

! set thetaillator natural frequencies
! do i = 1, Ntotal
!     ntrlOmega(i) = normal( meanFreq, sqrt(D))
!     write(100,*) ntrlOmega(i)
! enddo

time = 0.0_b8

do t = 1, tmax
    ! if ( real(t)*dt == real(tmax/3)*dt ) then
    !     ! omega  = omega / 2.0_b8
    !     ntrlOmega = ntrlOmega / 2.0_b8
    ! end if

    ! update using 4th order Rung3e-Kutta
    do i = 1, Ntotal

        t1 = real(t)*dt
        t2 = t1 + dt / 2.0_b8
        t3 = t1 + dt / 2.0_b8
        t4 = t1 + dt

        x1 = theta(i)
        x2 = x1 + getOmega()

        theta(i) = theta(i) + ( f1 + 2.0_b8*f2 + 2.0_b8*f3 + f4) * dt / 6.0_b8
        ! make sure thetaillator phase stays between 0 and 2*pi
        if ( theta(i) > 2.0000_b8*pi ) then
            theta(i) = theta(i) - 2.0000_b8*pi
        end if
    enddo

    if ( mod(t,10) == 0 ) then
        groupI = 0.0_b8
        do i = 1, Ntotal
            groupI = groupI + omega(i) / dt
        enddo
        groupI = groupI / meanFreq
        q = orderQ( theta)
        write(102,*) real(t)*dt, groupI, q
        write(103,*) real(t)*dt, theta(1), omega(1) / dt
    end if

enddo

end program


! initialize RANDOM_SEED
subroutine init_random_seed()
    integer :: values(1:8), k
    integer, dimension(:), allocatable :: seed
    real(8) :: r

    call date_and_time(values=values)
    call random_seed(size=k)
    allocate(seed(1:k))
    seed(:) = values(8)
    call random_seed(put=seed)
end subroutine init_random_seed
