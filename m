From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 20 Apr 2016 15:08:02 +0000
Subject: Please advise on dealing with compiler issue
Message-Id: <57179B52.5090200@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I am adding code to the sparc64 kernel that would require 
reading/writing one of the new registers on M7 processor, namely MCDPER. 
There are three ways I know of to do this:

1. __asm__ __volatile__("rd %%mcdper, %0\n\t": "=r" (tmp)) - This is the 
best way to do it but the support for %%mcdper is available in binutils 
2.26 and newer only. Compiling the kernel with older binutils will cause 
build failure.

2. __asm__ __volatile__("rd %%asr14, %0\n\t": "=r" (tmp)) - This should 
work independent of binutils version but it does not due to two bugs in 
assembler that have been fixed recently but not in a released version 
yet - <https://sourceware.org/ml/binutils/2016-03/msg00302.html>, 
<https://sourceware.org/ml/binutils/2016-03/msg00303.html>.

3. .byte 0x83,0x43,0x80,0x00 - This is byte coded equivalent of "rd 
%asr14, %g1". This works independent of binutils version but is ugly and 
requires pre-assigning a register to read MCDPER into, which does not 
help compiler with optimization.

Of the three options, only option 3 can work without requiring everyone 
compiling kernel to update to latest binutils.

Please advise on best way to proceed.

Thanks,
Khalid
