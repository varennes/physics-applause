module utility


    ! b8 will be used to define reals with 14 digits
    integer, parameter:: b8 = selected_real_kind(14)

    !!! set parameter values !!!
    integer,  parameter :: Ntotal = 70

    real(b8), parameter :: pi   = 3.14159265359_b8
    ! real(b8), parameter :: dt   = 0.1000_b8
    ! real(b8), parameter :: D    = 0.0400_b8
    ! real(b8), parameter :: Kmin = 1.4000_b8
    ! real(b8), parameter :: meanFreq = 0.0000_b8

    real(b8), parameter :: dt   = 0.0100_b8
    real(b8), parameter :: D    = 2.0000_b8 * pi / 6.900_b8
    real(b8), parameter :: Kmin = 0.8000_b8
    real(b8), parameter :: meanFreq = 2.0000_b8*pi


contains


! frequency minimizing interaction
real(b8) function Wmin( k, osc)
    implicit none
    integer,  intent(in) :: k
    real(b8), intent(in), dimension(:) :: osc

    integer  :: i
    real(b8) :: x

    x = 0.0_b8

    do i = 1, Ntotal
        x = x + sin( osc(i) - osc(k))
    enddo

    Wmin = Kmin * x / real(Ntotal)

end function Wmin


! calculate order parameter
real(b8) function orderQ( osc)
    implicit none
    real(b8), intent(in), dimension(:) :: osc

    integer  :: i
    real(b8) :: x, y

    x = 0.0_b8
    y = 0.0_b8

    do i = 1, Ntotal
        x = x + cos( osc(i))
        y = y + sin( osc(i))
    enddo

    orderQ = sqrt( x*x + y*y) / real(Ntotal)

end function orderQ


! update oscillator
real(b8) function getOscFreq( k, ntrlFreq, osc)
    implicit none
    integer,  intent(in) :: k
    real(b8), intent(in) :: ntrlFreq
    real(b8), intent(in), dimension(:) :: osc

    getOscFreq = (ntrlFreq + Wmin( k, osc))*dt + normal( 0.0000_b8, sqrt(1.0000_b8/dt))

end function getOscFreq


! returns random number between 0 - 1
function ran1()
    implicit none
    real(b8) ran1,x
    call random_number(x) ! built in fortran 90 random number function
    ran1=x
end function ran1

! returns a normal distribution
function normal(mean,sigma)
    implicit none
    real(b8) normal,tmp
    real(b8) mean,sigma
    integer flag
    real(b8) fac,gsave,rsq,r1,r2
    save flag,gsave
    data flag /0/
    if (flag.eq.0) then
    rsq=2.0_b8
        do while(rsq.ge.1.0_b8.or.rsq.eq.0.0_b8) ! new from for do
            r1=2.0_b8*ran1()-1.0_b8
            r2=2.0_b8*ran1()-1.0_b8
            rsq=r1*r1+r2*r2
        enddo
        fac=sqrt(-2.0_b8*log(rsq)/rsq)
        gsave=r1*fac
        tmp=r2*fac
        flag=1
    else
        tmp=gsave
        flag=0
    endif
    normal=tmp*sigma+mean
    return
end function normal


end module
