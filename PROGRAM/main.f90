PROGRAM KURAMOTO_NOISE
  use INTEGRATION
  use DISTRIBUTION

  IMPLICIT NONE
  include 'r1279block.h'
  INTEGER, PARAMETER :: N = 1000
  REAL*8, DIMENSION(N) :: Theta,dTheta_dtau,omega,Theta_out,eta
  REAL*8 :: tau,Delta_tau,K,Delta_K,r,phi,gamma,pi,beta_squared,Delta_beta,tau2,r_avg
  INTEGER :: timesteps,i,j,t,tt,num_K,l,n_samples,n_samp
  LOGICAL :: print_dyn
  K = 1.5d0          ! initial coupling
  Delta_K = 0.1d0    ! K step size
  Delta_tau = 0.01d0  ! time step size
  timesteps = 5e5   ! number of time steps until we calculate r
  num_K = 1        ! number of K values to test
  gamma = 0.5d0      ! defines the width of the distribution g(omega)
  beta_squared = 0.5d0  ! strength of noise

  !Delta_beta = 0.5d0
  pi = 4.d0*datan(1.d0)

  open(40, file='r_vs_t.dat')
  open(50, file='Omega_vs_DTheta.dat')
  open(60, file='Omega_vs_Theta.dat')
  open(70, file='order_parameter.dat')
  print_dyn = (.TRUE.)

  call lorentzian(gamma,N,omega)


  call random_seed

  ! call order_parameter(Theta,r,phi,N)
  ! write(*,*) K,r
  ! write(70,*) K,"  ", r

  DO i = 1,num_K
    tau = 0.d0
    DO t = 1,N
      call random_number(Theta(t))
      Theta(t)=Theta(t)*2.d0*pi
    END DO

    DO t = 1, timesteps
      call random_noise(eta,N,beta_squared/Delta_tau)
      call derivs(tau, Theta, dTheta_dtau,N,K,eta,omega)
      call rk4(Theta,dTheta_dtau,N,tau,Delta_tau,Theta_out,K,beta_squared,eta,omega)
      Theta = Theta_out
      tau = tau + Delta_tau
      call order_parameter(Theta,r,phi,N)
      !write(40,*) tau,"   ", r
    END DO


    write(*,*) K,r
    write(70,*) K,"  ", r

    !K = K + Delta_K

END DO

if(print_dyn.eqv.(.TRUE.)) then
do j =1,N
  call derivs(tau, Theta, dTheta_dtau,N,K,eta,omega)
  !write(50,*) omega(j), "     ", dTheta_dtau(j)
  write(50,*) j, "     ", dTheta_dtau(j)

  write(60,*) omega(j), "     ", MOD(Theta(j),2*pi)


END DO
  end if

END PROGRAM KURAMOTO_NOISE
