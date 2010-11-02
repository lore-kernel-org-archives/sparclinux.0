From: Jan Engelhardt <jengelh@medozas.de>
Date: Tue, 02 Nov 2010 19:02:38 +0000
Subject: Re: Linux 2.6.36-rc8 won't boot
Message-Id: <alpine.LNX.2.01.1011022000110.12346@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Tuesday 2010-11-02 14:54, David Miller wrote:
>> I tried bisecting today, booted a number of kernels already, and upon 
>> the latest reboot I only get this - very frustrating.
>> 
>> {0} ok boot
>> Boot device: disk  File and args: 
>> SILO Version 1.4.14
>> ERROR: Last Trap: Illegal Instruction
>> {0} ok
>
>Type "dis" and ".registers" so that you can see where it crashed
>and what the register values were at the time of the crash.

{0} ok .registers
        Normal          GL=1
0:                 0                0
1:                 0                5
2:          1029e3a0             1fff
3:          f130f52c                0
4:            3a8400        1ffffe000
5:                 0        1fff53a80
6:                 0        1fff53d00
7:                 0         f0245504
%PC  f0243ca8 %nPC f0243cac 
%TBA f0200000 %CCR 4414001e XCC:nzvC   ICC:NZVc

{0} ok dis
0000.0000.fef7.01c0    illtrap
0000.0000.fef7.01c4    illtrap
0000.0000.fef7.01c8    illtrap
0000.0000.fef7.01cc    illtrap
0000.0000.fef7.01d0    illtrap
0000.0000.fef7.01d4    illtrap
0000.0000.fef7.01d8    illtrap
0000.0000.fef7.01dc    illtrap
0000.0000.fef7.01e0    illtrap
0000.0000.fef7.01e4    illtrap
0000.0000.fef7.01e8    illtrap
0000.0000.fef7.01ec    illtrap
0000.0000.fef7.01f0    illtrap
0000.0000.fef7.01f4    illtrap
0000.0000.fef7.01f8    illtrap
0000.0000.fef7.01fc    illtrap
0000.0000.fef7.0200    illtrap
0000.0000.fef7.0204    illtrap
0000.0000.fef7.0208    illtrap
0000.0000.fef7.020c    illtrap
0000.0000.fef7.0210    illtrap
0000.0000.fef7.0214    illtrap
0000.0000.fef7.0218    illtrap 
0000.0000.fef7.021c    illtrap
0000.0000.fef7.0220    illtrap
0000.0000.fef7.0224    illtrap
0000.0000.fef7.0228    illtrap
0000.0000.fef7.022c    illtrap
0000.0000.fef7.0230    illtrap
0000.0000.fef7.0234    illtrap
0000.0000.fef7.0238    illtrap
0000.0000.fef7.023c    illtrap
0000.0000.fef7.0240    illtrap
0000.0000.fef7.0244    illtrap
0000.0000.fef7.0248    illtrap
0000.0000.fef7.024c    illtrap
0000.0000.fef7.0250    illtrap
0000.0000.fef7.0254    illtrap
0000.0000.fef7.0258    illtrap
0000.0000.fef7.025c    illtrap
0000.0000.fef7.0260    illtrap
0000.0000.fef7.0264    illtrap
0000.0000.fef7.0268    illtrap
0000.0000.fef7.026c    illtrap
0000.0000.fef7.0270    illtrap
0000.0000.fef7.0274    illtrap 
0000.0000.fef7.0278    illtrap
0000.0000.fef7.027c    illtrap
0000.0000.fef7.0280    illtrap
0000.0000.fef7.0284    illtrap
0000.0000.fef7.0288    illtrap
0000.0000.fef7.028c    illtrap
0000.0000.fef7.0290    illtrap
0000.0000.fef7.0294    illtrap
0000.0000.fef7.0298    illtrap
0000.0000.fef7.029c    illtrap
0000.0000.fef7.02a0    illtrap
0000.0000.fef7.02a4    illtrap
0000.0000.fef7.02a8    illtrap
0000.0000.fef7.02ac    illtrap
0000.0000.fef7.02b0    illtrap
0000.0000.fef7.02b4    illtrap
0000.0000.fef7.02b8    illtrap
0000.0000.fef7.02bc    illtrap
0000.0000.fef7.02c0    illtrap
0000.0000.fef7.02c4    illtrap
0000.0000.fef7.02c8    illtrap
0000.0000.fef7.02cc    st          %i0, [%l7 + %i0]
0000.0000.fef7.02d0    illtrap 
0000.0000.fef7.02d4    ???         [%o5 - 8ff] %asi, %i7
0000.0000.fef7.02d8    illtrap
0000.0000.fef7.02dc    illtrap
0000.0000.fef7.02e0    illtrap
0000.0000.fef7.02e4    illtrap
0000.0000.fef7.02e8    illtrap
0000.0000.fef7.02ec    illtrap
0000.0000.fef7.02f0    illtrap
0000.0000.fef7.02f4    illtrap
0000.0000.fef7.02f8    illtrap
0000.0000.fef7.02fc    illtrap
0000.0000.fef7.0300    illtrap
0000.0000.fef7.0304    illtrap
0000.0000.fef7.0308    illtrap
0000.0000.fef7.030c    illtrap
0000.0000.fef7.0310    illtrap
0000.0000.fef7.0314    illtrap
0000.0000.fef7.0318    illtrap
0000.0000.fef7.031c    illtrap
0000.0000.fef7.0320    illtrap
0000.0000.fef7.0324    illtrap
0000.0000.fef7.0328    illtrap
0000.0000.fef7.032c    illtrap 
0000.0000.fef7.0330    illtrap
0000.0000.fef7.0334    illtrap
0000.0000.fef7.0338    illtrap
0000.0000.fef7.033c    illtrap
0000.0000.fef7.0340    illtrap
0000.0000.fef7.0344    illtrap
0000.0000.fef7.0348    illtrap
0000.0000.fef7.034c    illtrap
0000.0000.fef7.0350    illtrap
0000.0000.fef7.0354    illtrap
0000.0000.fef7.0358    illtrap
0000.0000.fef7.035c    illtrap
0000.0000.fef7.0360    illtrap
0000.0000.fef7.0364    illtrap
0000.0000.fef7.0368    illtrap
0000.0000.fef7.036c    illtrap
0000.0000.fef7.0370    illtrap
0000.0000.fef7.0374    illtrap
0000.0000.fef7.0378    illtrap
0000.0000.fef7.037c    illtrap
0000.0000.fef7.0380    illtrap
0000.0000.fef7.0384    illtrap
0000.0000.fef7.0388    illtrap 
0000.0000.fef7.038c    illtrap
0000.0000.fef7.0390    illtrap
0000.0000.fef7.0394    illtrap
0000.0000.fef7.0398    illtrap
0000.0000.fef7.039c    illtrap
0000.0000.fef7.03a0    illtrap
0000.0000.fef7.03a4    illtrap
0000.0000.fef7.03a8    illtrap
0000.0000.fef7.03ac    illtrap
0000.0000.fef7.03b0    illtrap
0000.0000.fef7.03b4    illtrap
0000.0000.fef7.03b8    illtrap
0000.0000.fef7.03bc    illtrap
0000.0000.fef7.03c0    illtrap
0000.0000.fef7.03c4    illtrap
0000.0000.fef7.03c8    illtrap
0000.0000.fef7.03cc    st          %i0, [%l7 + %i0]
0000.0000.fef7.03d0    illtrap
0000.0000.fef7.03d4    ???         [%o5 - 8ff] %asi, %i7
0000.0000.fef7.03d8    illtrap
0000.0000.fef7.03dc    illtrap
0000.0000.fef7.03e0    illtrap
0000.0000.fef7.03e4    illtrap 
0000.0000.fef7.03e8    illtrap
0000.0000.fef7.03ec    illtrap
0000.0000.fef7.03f0    illtrap
0000.0000.fef7.03f4    illtrap
0000.0000.fef7.03f8    illtrap
0000.0000.fef7.03fc    illtrap
0000.0000.fef7.0400    illtrap
0000.0000.fef7.0404    illtrap
0000.0000.fef7.0408    call        0000.0000.fef7.0404
0000.0000.fef7.040c    ???         [%i7 - 8] %asi, %f62 

