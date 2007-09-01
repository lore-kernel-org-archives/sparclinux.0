From: "jiaqi zhang" <zation.busy@gmail.com>
Date: Sat, 01 Sep 2007 02:11:04 +0000
Subject: Re: perfctr on UltraSparcT1
Message-Id: <a8e8903d0708311911i187fec51m2e93cadbb0a21ba1@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a8e8903d0708311824s72f929d1rfcf3d2b953b21094@mail.gmail.com>
In-Reply-To: <a8e8903d0708311824s72f929d1rfcf3d2b953b21094@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Oops. I'm so sorry. It is solved and this is totally my fault.
However, there is still another question: Should I always bind the
thread to a specific virtual cpu? Because if it was rescheduled to
other cpu, the content in the registers would not be consistent. Or
does the kernel forbid  this kind of rescheduling when TIF_PERFCTR
flag is on?

On 9/1/07, jiaqi zhang <zation.busy@gmail.com> wrote:
> Hello,
>
> I'm doing performance experiments of my applications on UltraSparc T1.
> In order to test the data of cache miss or other things, I'm in need
> of some ways to access PIC and PCR. I wrote a simple module to read
> and set these registers using the macros found in
> asm-sparc64/system.h. However, no matter what I set to the pcr,
> read_pcr and read_pic (I understand this should be 0 when pcr is 0)
> always return 0.
>
> After that, I found a system call (sys_perfctr) that would do this. So
> in my program, I invoked this system call as below. (I also tried bind
> the thread to a specific processor using setaffinity) However, I've
> got the same problem. The output is below the program.
>
> Could anyone teach me this? Sorry for this naive question. Thanks a lot!
>
> btw, Linux kernel 2.6.20, gcc 4.2.1
>
>
>
> #include <linux/unistd.h>
> #include <syscall.h>
> #include <errno.h>
> #include <stdio.h>
> #include <asm-sparc64/perfctr.h>
>
>        int main(void)
>        {
>             int opcode;
>                 unsigned long arg0,arg1,arg2;
>             int error;
>                 unsigned long pcr;
>                 if(error=syscall(SYS_perfctr,PERFCTR_ON,0,0,0))
>                         printf("error is %d\n",error);
>                 if(error=syscall(SYS_perfctr,PERFCTR_SETPCR,0x04,0,0))
>                         printf("error is %d\n",error);
>                 if(error=syscall(SYS_perfctr,PERFCTR_GETPCR,&pcr,0,0))
>                         printf("error is %d and %s\n",error,strerror(error));
>                 printf("pcr is %d\n",pcr);
>                 return(0);
>        }
>
> output:
> $gcc tryperfctr.c
> $./a.out
> error is -1
> error is -1 and Unknown error 18446744073709551615
> pcr is 0
>
