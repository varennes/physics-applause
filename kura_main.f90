program kuraclap

use utility

!!! allocate variables !!!
implicit none
integer :: i, j, k, l, t
integer :: tmax

real(b8) :: groupI, q, time, t0
real(b8), allocatable :: osc(:), oscFreq(:), ntrlFreq(:)


!!! set inital parameter values !!!
tmax = 6000


!!! allocate array size !!!
allocate( osc(Ntotal))
allocate( ntrlFreq(Ntotal))
allocate( oscFreq(Ntotal))


call cpu_time(t0)
call init_random_seed()


osc      = 0.0000_b8
oscFreq  = 0.0000_b8
ntrlFreq = 0.0000_b8

! set oscillator angles and frequencies
do i = 1, Ntotal
    osc(i) = 2.0000_b8*pi*ran1()
    ntrlFreq(i) = normal( meanFreq, sqrt(D))
    oscFreq(i)  = ntrlFreq(i)
    write(100,*) oscFreq(i)
enddo

! set oscillator natural frequencies
! do i = 1, Ntotal
!     ntrlFreq(i) = normal( meanFreq, sqrt(D))
!     write(100,*) ntrlFreq(i)
! enddo

time = 0.0_b8

do t = 1, tmax
    if ( real(t)*dt == real(tmax/3)*dt ) then
        ! oscFreq  = oscFreq / 2.0_b8
        ntrlFreq = ntrlFreq / 2.0_b8
    end if

    ! calculate oscillator frequencies
    do i = 1, Ntotal
        oscFreq(i) = getOscFreq( i, ntrlFreq(i), osc)
        osc(i)     = osc(i) + oscFreq(i)

        ! make sure oscillator phase stays between 0 and 2*pi
        if ( osc(i) > 2.0000_b8*pi ) then
            osc(i) = osc(i) - 2.0000_b8*pi
        end if
    enddo

    if ( mod(t,10) == 0 ) then
        groupI = 0.0_b8
        do i = 1, Ntotal
            groupI = groupI + oscFreq(i) / dt
        enddo
        groupI = groupI / meanFreq
        q = orderQ( osc)
        write(102,*) real(t)*dt, groupI, q
        write(103,*) real(t)*dt, osc(1), oscFreq(1) / dt
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
