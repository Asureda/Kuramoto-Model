MODULE INTEGRATION

  IMPLICIT NONE
contains
  SUBROUTINE rk4(y,dydx,n,x,h,yout,K,beta_squared,eta,omega)
    INTEGER :: N,i
    REAL*8, DIMENSION(N) :: y,dydx,yout,yt,dyt,dym,omega,eta
    REAL *8 :: h,hh,h6,x,xh,K,beta_squared

    hh = h*0.5
    h6 = h/6.d0
    xh = x+hh
    DO i = 1,N
      yt(i) = y(i) + hh*dydx(i)
    END DO

    CALL derivs(xh,yt,dyt,N,K,eta,omega)
    DO i = 1,N
      yt(i) = y(i) + hh*dyt(i)
    END DO

    CALL derivs(xh,yt,dym,N,K,eta,omega)

    DO i=1,N
      yt(i)=y(i)+h*dym(i)
      dym(i)=dyt(i)+dym(i)
    END DO

    CALL derivs(x+h,yt,dyt,n,K,eta,omega)

    DO i = 1,N
      yout(i)=y(i)+h6*(dydx(i)+dyt(i)+2.d0*dym(i))
    END DO
    RETURN
  END SUBROUTINE rk4

  SUBROUTINE derivs(tau, Theta, dTheta_dtau, N, K, eta, omega)
    INTEGER :: N,i
    REAL* 8, DIMENSION(N) :: Theta,dTheta_dtau,omega,eta
    REAL* 8 :: tau, K,r,phi

    CALL order_parameter(Theta,r,phi,N)
    DO i=1,N
      dTheta_dtau(i) = omega(i) + K*r*sin(phi-Theta(i)) + eta(i)
    END DO
    RETURN
  END SUBROUTINE derivs

  SUBROUTINE order_parameter(Theta,r,phi,N)
    INTEGER :: N,j
    REAL* 8, DIMENSION(N) :: Theta
    REAL* 8 :: r,phi,real_sum,imag_sum

    real_sum=0.d0
    imag_sum=0.d0
    DO j=1,N
      real_sum = real_sum+cos(Theta(j))
      imag_sum = imag_sum+sin(Theta(j))
    END DO
    real_sum = real_sum/dble(N)
    imag_sum = imag_sum/dble(N)

    r = sqrt((real_sum)**2+(imag_sum)**2)
    phi = acos(real_sum/r)
    return
  END SUBROUTINE order_parameter

END MODULE INTEGRATION
