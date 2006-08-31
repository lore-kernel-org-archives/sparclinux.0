From: zhiyi huang <hzy@cs.otago.ac.nz>
Date: Thu, 31 Aug 2006 02:27:53 +0000
Subject: siginfo of SIGSEGV on UltraSPARC T1
Message-Id: <E871E344-53F7-466E-BBAB-4A809A5C93C0@cs.otago.ac.nz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,
Could anyone give me some information on how SIGSEGV is handled when  
a signal handler is installed. I need information about fault address  
and access type (read/write). I used the siginfo_t defined in bits/ 
siginfo.h, but the information I got from the handler arguments are  
not correct. Can anyone point out the right structure for the  
arguments of the signal handler.
I am using a Ubuntu port on Ultra Sparc T1, by the way.
Linux version 2.6.15-21-sparc64-smp (buildd@artigas) (gcc version  
4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 SMP Fri Apr 21 17:04:05 UTC 2006

Thanks for help:)
Zhiyi

