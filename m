From: daniel+devel-linux-sparclinux@flexserv.de
Date: Sat, 22 Jul 2006 08:45:54 +0000
Subject: Re: oops on e4k5
Message-Id: <873bcum3i5.fsf@xserver.flexserv.de>
List-Id: <sparclinux.vger.kernel.org>
References: <877j26m8kl.fsf@xserver.flexserv.de>
In-Reply-To: <877j26m8kl.fsf@xserver.flexserv.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello David,
thanks for your response

David Miller <davem@davemloft.net> writes:

> The OOPS is severely truncated where the most important
> information would normally appear.  Please reproduce with
> the following patch applied.

okay i will do so.

>
> It might also help if you turn off CONFIG_PROM_CONSOLE.
> The zilog serial driver should drive your console just fine,
> and your logs show it does register properly.
>
> Also, what kind of cpus are in this machine?  (/proc/cpuinfo
> output is sufficient)
>
> Thanks.
cpu             : TI UltraSparc II  (BlackBird)
fpu             : UltraSparc II integrated FPU
prom            : OBP 3.2.26 2000/05/09 19:07
type            : sun4u
ncpus probed    : 10
ncpus active    : 10
D$ parity tl1   : 0
I$ parity tl1   : 0
Cpu0Bogo        : 800.48
Cpu0ClkTck      : 0000000017d78400
Cpu1Bogo        : 800.05
Cpu1ClkTck      : 0000000017d78400
Cpu4Bogo        : 800.05
Cpu4ClkTck      : 0000000017d78400
Cpu5Bogo        : 800.05
Cpu5ClkTck      : 0000000017d78400
Cpu8Bogo        : 800.05
Cpu8ClkTck      : 0000000017d78400
Cpu9Bogo        : 800.05
Cpu9ClkTck      : 0000000017d78400
Cpu10Bogo       : 800.05
Cpu10ClkTck     : 0000000017d78400
Cpu11Bogo       : 800.05
Cpu11ClkTck     : 0000000017d78400
Cpu12Bogo       : 800.05
Cpu12ClkTck     : 0000000017d78400
Cpu13Bogo       : 800.05
Cpu13ClkTck     : 0000000017d78400
MMU Type        : Spitfire
State:
CPU0:           online
CPU1:           online
CPU4:           online
CPU5:           online
CPU8:           online
CPU9:           online
CPU10:          online
CPU11:          online
CPU12:          online
CPU13:          online

