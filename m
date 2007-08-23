From: "jiaqi zhang" <zation.busy@gmail.com>
Date: Thu, 23 Aug 2007 01:11:13 +0000
Subject: Re: Problems of PREFETCH instruction on UltraSparc T1
Message-Id: <a8e8903d0708221811r41f9463bo96f45420971ae310@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a8e8903d0708211701j47e6246eu57147ab1ab55e397@mail.gmail.com>
In-Reply-To: <a8e8903d0708211701j47e6246eu57147ab1ab55e397@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Thanks very much for this thorough explaination. It is really of great
help. I changed the program as you have instructed, and it is
obviously better than the former one. However, it still performs a
little bit worse than the one without prefetchs (simply delete all the
prefetch statements). So I again added the "foo bar" loop, and to
prevent the optimization of compiler, I printed the result at the end
of program( again, whole program below). And this makes the one with
prefetch run faster than the one without. Also, a careful tunning
indicates that a "foo bar" loop of 6 iterations will achieve the best
performance.

However, the problem is the performance gain is so tiny even after
great efforts of tunning: the whole program runs about 60 seconds and
it runs only 3 seconds faster with prefetches, more excatly, 4.3%
faster. I don't know if this is really the case. Because the cycles
cost by a memory access is ten times more than a L2 cache access, I
suppose the performance gain should be more significant.

Also, if I simply delete "*(buf+48)=3Di;" and change "buf+d" to
"buf+H", the performance gain would drop markedly (about a half).
Does it indicate that this prefetch work is so tricky that I shouldn't
consider it when I don't know the workload of a real application?

Thanks!

--testprefetch.c--

#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>

#define MEGA 1024*1024
#define TIMES 100
#define LASTITEM 100*MEGA-1

int main(){
        struct timeval begin,end;
        register int i,j;
        int foo,bar;

        int *data=3D(int *)malloc(100*sizeof(int)*MEGA);
        register int *buf, *lastone;
        lastone=3D&data[LASTITEM];

        gettimeofday(&begin,NULL);
        for(i=3D0;i<TIMES;i++){
                buf=DAta;
                __asm__ __volatile__("prefetch\t[%0], #n_writes\n\t"
                                     "prefetch\t[%0+64], #n_writes\n\t"
                                     "prefetch\t[%0+128], #n_writes"
                                     ::"r"(buf));
                while(buf<lastone){
                        for(j=3D0;j<6;j++)foo+=3Dj;
                        bar+=3Dfoo;
                        *buf=3Di;
                        *(buf+16)=3Di;
                        *(buf+32)=3Di;
                      *(buf+48)=3Di;
                        buf+d;
                        __asm__ __volatile__("prefetch\t[%0],
#n_writes"::"r"(buf+128));
                }
        }
        gettimeofday(&end,NULL);
        printf("time in usec is
%d\n",((end.tv_sec*1000000+end.tv_usec)-(begin.tv_sec*1000000+begin.tv_usec=
)));
        printf("bar is %d\n",bar);
}



On 8/22/07, David Miller <davem@davemloft.net> wrote:
> From: "jiaqi zhang" <zation.busy@gmail.com>
> Date: Wed, 22 Aug 2007 12:01:19 +1200
>
> > I don't really know if it is proper to post this topic here.
> >
> > In order to accelerate our applications, I adopted the PREFETCH
> > instruction of UltraSparc. However, the results are not expected: the
> > one with prefetch works even a little bit slower. The whole program is
> > listed below.
>
> Different processors can only have so many prefetches in flight at a
> time.  If you perform too many, they will only consume cpu cycles.
>
> UltraSPARC-I does not implement prefetch at all, and it just takes up
> an instruction issue slot.
>
> UltraSPARC-II, IIi and IIe implement prefetch, with up to 3 in flight,
> but they has several limitations and the prefetches are not as
> effective as they could be.
>
> UltraSPARC-III and IIIi can have up to 5 prefetches in flight and
> implements it very well.
>
> Niagara 1 and 2 can have up to about 3 prefetches in flight and it
> implements this reasonable well.
>
> Also, prefetches only help if there is a large amount of
> time between the prefetch and the actual access of the
> data.
>
> So what a loop will usually do is queue up a few prefetches
> before the loop, perhaps forward about 2 or 3 cachelines,
> and then the loop will end with a single prefetch that same
> number of cachelines forward.  See my suggested loop below.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                         for(j=3D0;j<100;j++) foo+=3Dj; //do some trivial
> things to pass time
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Since you don't really use foo or bar, the compiler can see that
> this loop does nothing, so it will be eliminated, at least by
> more recent versions of gcc.
>
> Also you are doing worthless prefetches, as the cacheline size
> is 64 bytes, so doing 16-byte offset prefetches accomplishes
> nothing.
>
> Reconstruct your loop as follows:
>
>         prefetch        buffer + (0 * 64)
>         prefetch        buffer + (1 * 64)
>         prefetch        buffer + (2 * 64)
>         while (buf < lastone) {
>                 *buf =3D i;
>                 *(buf+16)=3Di;
>                 *(buf+32)=3Di;
>                 *(buf+48)=3Di;
>                 buf +=3D 64;
>                 prefetch        buffer + (2 * 64);
>         }
>
> This should work significantly better than what your code
> is doing right now.
>
