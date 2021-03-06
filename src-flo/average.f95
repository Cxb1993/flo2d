!------------------------------------------------------------------------------
! Compute vertex values from cell-center values using laplace averaging
!------------------------------------------------------------------------------
      subroutine average(spts, elem, edge, coord, tarea, af, qc, qv)
      implicit none
      include 'param.h'
      integer  :: elem(3,*), edge(2,*), spts(*)
      real(dp) :: coord(2,*), qc(nvar,*), af(3,*), qv(nvar,*), tarea(*)

      integer  :: i, j, v1, v2, v3, e1, e2

      do i=1,np
         do j=1,nvar
            qv(j,i) = 0.0d0
         enddo
      enddo
      do i=1,nt
         v1 = elem(1,i)
         v2 = elem(2,i)
         v3 = elem(3,i)
         call vaverage(coord(1,v1), coord(1,v2), coord(1,v3), &
                       af(1,v1), af(1,v2), af(1,v3), tarea(i),  &
                       qc(1,i), qv(1,v1), qv(1,v2), qv(1,v3))
      enddo
      do i=1,np
         do j=1,nvar
            qv(j,i) = qv(j,i)/af(3,i)
         enddo
      enddo

      if(flow_type /= 'inviscid')then
!        Viscous flow: zero velocity condition
         do i=1,nsp
            j = spts(i)
            qv(2,j) = 0.0d0
            qv(3,j) = 0.0d0
         enddo
      endif

      end
