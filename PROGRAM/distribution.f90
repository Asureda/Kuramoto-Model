MODULE DISTRIBUTION
  IMPLICIT NONE

contains
  SUBROUTINE lorentzian(gamma,N,omega)
    INTEGER :: N,d
    REAL* 8, DIMENSION(N) ::  omega
    REAL* 8 :: pi, gamma, random1, random2, p, p_max

    call random_seed

    pi = 4.d0*atan(1.d0)
    p_max = 1/(pi*gamma)

    DO d = 1,N
       !call random_number(random1)
      50 call random_number(random1)!random1=RAND()
      random1 = random1*20.d0*gamma - 10.d0*gamma
      p = gamma/(pi*(gamma*gamma + random1*random1))
      !call random_number(random2)
      !random2=RAND()
      call random_number(random2)
      random2=random2*p_max
    if (random2>p)  go to 50
      omega(d) = random1

    !  end do
    END DO
    RETURN
  END SUBROUTINE lorentzian

  SUBROUTINE normal_random(x)
    REAL* 8 :: x,pi,p,p_max,random1,random2
    pi = 4.d0*atan(1.d0)
    p_max = 1/sqrt(2*pi)
    666 call random_number(random1)
    random1 = random1*20.d0 - 10.d0
    p = exp(-(random1*random1)/2)/sqrt(2*pi)
    call random_number(random2)
    random2=random2*p_max
    if (random2>p) go to 666
    x = random1

    return
  END SUBROUTINE normal_random

  SUBROUTINE random_noise(array,N,width)
    INTEGER :: N, i
    REAL*8, DIMENSION(N) :: array
    REAL*8 :: width
    DO i = 1,N
      call normal_random(array(i))
      array(i) = sqrt(width)*array(i)
    END DO
    RETURN
  END SUBROUTINE random_noise
END MODULE DISTRIBUTION
