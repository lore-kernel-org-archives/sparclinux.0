From: Bernd Zeimetz <bernd@bzed.de>
Date: Sat, 08 Dec 2007 00:14:46 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <4759E1F6.5050209@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


David Miller wrote:
> From: Bernd Zeimetz <bernd@bzed.de>
> Date: Thu, 06 Dec 2007 13:09:18 +0100
> 
>> ERROR(0): Cheetah error trap taken afsr[0000100000000000]
>> afar[0000040001c00000] TL1(0)
>> ERROR(0): TPC[4351dc] TNPC[4351e0] O7[4353b4] TSTATE[80001606]
>> ERROR(0): TPC<interpret_one_decode_reg+0x0/0xfc>
>> ERROR(0): M_SYND(0),  E_SYND(0)
> 
> Please try this patch:
[...]

titan:~# uname -a
Linux titan 2.6.23.9+davem-nonsmp #1 Fri Dec 7 10:02:01 UTC 2007 sparc64
GNU/Linux
titan:~# cat /proc/cpuinfo
cpu             : TI UltraSparc III (Cheetah)
fpu             : UltraSparc III integrated FPU
prom            : OBP 4.22.34 2007/07/23 13:01
type            : sun4u
ncpus probed    : 4
ncpus active    : 1
D$ parity tl1   : 0
I$ parity tl1   : 0
Cpu0ClkTck      : 000000002cb41780
MMU Type        : Cheetah
titan:~#

works well, thanks for fixing!

-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
