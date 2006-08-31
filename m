From: zhiyi huang <hzy@cs.otago.ac.nz>
Date: Thu, 31 Aug 2006 01:55:41 +0000
Subject: problem of Ubuntu on UltraSPARC T1
Message-Id: <77874758-B995-4BDE-8B5D-E6D15AD80FC2@cs.otago.ac.nz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi there,
I have made a shared memory module on UltraSPARC T1. It works well.  
It allows multiple processes to share pages. However, I got the  
following error message when starting parallel processes using rsh/ssh.

./is_dsm: relocation error: ./is_dsm: symbol sigaction, version  
GLIBC_2.0 not defined in file libc.so.6 with link time reference

When the program 'is_dsm' is started as a single instance, there is  
no problem. But when multiple processes are started within the  
program using the following command, the above message popped up  
sporadically.

rsh localhost -n "cd /home/zhiyi/mempage/dsmdrv/app ; ./is_dsm -- -n4  
-i1 -m-270794752 -d2"

I think it may not be related with the kernel. It may be related with  
gcc or glibc. Can anyone point out the possible reasons/solutions  
regarding the gcc and libc.so.6?

By the way, I am using
Linux version 2.6.15-21-sparc64-smp (buildd@artigas) (gcc  
version4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 SMP Fri Apr 21 17:04:05 UTC  
2006

Thanks for help:)
Zhiyi





