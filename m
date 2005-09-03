From: Bob Breuer <breuerr@mc.net>
Date: Sat, 03 Sep 2005 16:21:15 +0000
Subject: Re: sparc32 SMP under 2.6?
Message-Id: <4319CD7B.1070502@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5460e33305090209002d742242@mail.gmail.com>
In-Reply-To: <5460e33305090209002d742242@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Christian Joensson wrote:
> I'd just like to ask what the status is of sparc32 and SMP under the 2.6 kernel?
> 

Not much progress here.  I've only ported my SMP patch up to 2.6.12. 
Supersparc seems to be as stable under SMP as UP, but hypersparcs keep 
giving me problems.

I've tried an experiment of setting the cache mode to write-through on 
hypersparc and now it crashes early on.  Maybe someone might have some 
insight into what's happening:


Starting CPU 2 at f01e0960
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
               \|/ ____ \|/
               "@'/ ,. \`@"
               /_| \__/ |_\
                  \__U_/
swapper(0): Oops [#1]
PSR: 1e900fc5 PC: f0182b48 NPC: f0182b4c Y: 00000000    Not tainted
PC: <schedule+0x240/0x398>
%G: f1302000 f05f61b4  0000008c 0000000c  0001312c 00000001  fbf14000 
000003a
%O: f05f58a0 f018ba38  00000000 00002000  00000000 ffff8b0f  fbf15ec8 
f0182a00
RPC: <schedule+0xf8/0x398>
%L: 1e0000c6 00000002  0000006c f071c7c0  f05f5d54 f05f58a0  0098963a 
4c285180
%I: 00000004 f01a91d0  0000005b 000b7000  0c845880 f071c8e8  fbf15f38 
f00188f4
Caller[f00188f4]: cpu_idle+0x20/0x38
Caller[f001f05c]: smp_do_cpu_idle+0x0/0x10
Caller[00000000]: start+0xfffc000/0x10
Instruction DUMP: 82050001  c4006018  a400bfe0 <c204a018> 80a06063 
2480001f  c024a048  c204a048  80a06000
Kernel panic - not syncing: Attempted to kill the idle task!
  <0>Press Stop-A (L1-A) to return to the boot prom
