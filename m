From: "jiaqi zhang" <zation.busy@gmail.com>
Date: Wed, 22 Aug 2007 00:01:19 +0000
Subject: Problems of PREFETCH instruction on UltraSparc T1
Message-Id: <a8e8903d0708211701j47e6246eu57147ab1ab55e397@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi, everyone,

I don't really know if it is proper to post this topic here.

In order to accelerate our applications, I adopted the PREFETCH
instruction of UltraSparc. However, the results are not expected: the
one with prefetch works even a little bit slower. The whole program is
listed below.
I read the Ultrasparc specification and found that "when executed in
nonprivileged or privileged mode, PREFETCH has the same observable
effect as a NOP". I don't know how to understand this sentence. What
are the nonprivileged, privileged, and hyperprivileged modes in Linux?
Could that be user mode and kernel mode? I mean, does it mean I can
only make use of that instruction in kernel mode?

Thanks a lot!


testprefetch.c:

#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>

#define MEGA 1024*1024
#define TIMES 1
#define LASTITEM 100*MEGA-1

int main(){
        struct timeval begin,end;
        register int i,j;
        int foo, bar;

        int *data=3D(int *)malloc(100*sizeof(int)*MEGA); //400MB in
order to avoid being cached in L2 cache, which is 3M
        register int *buf, *lastone;
        lastone=3D&data[LASTITEM];

        gettimeofday(&begin,NULL);
        for(i=3D0;i<TIMES;i++){
                buf=DAta;
                while(buf<lastone){
                        __asm__ __volatile__("prefetch\t[%0],
#n_writes"::"r"(buf));
                        __asm__ __volatile__("prefetch\t[%0],
#n_writes"::"r"(buf+16));
                        __asm__ __volatile__("prefetch\t[%0],
#n_writes"::"r"(buf+32));
                        __asm__ __volatile__("prefetch\t[%0],
#n_writes"::"r"(buf+48));

                        for(j=3D0;j<100;j++) foo+=3Dj; //do some trivial
things to pass time
                        bar=3Dfoo;

                        *buf=3Di;
                        *(buf+16)=3Di;
                        *(buf+32)=3Di;
                        *(buf+48)=3Di;
                        buf+d;
                }
        }
        gettimeofday(&end,NULL);
        printf("time in usec is
%d\n",((end.tv_sec*1000000+end.tv_usec)-(begin.tv_sec*1000000+begin.tv_usec=
)));
}

--
Best regards,
Jiaqi
