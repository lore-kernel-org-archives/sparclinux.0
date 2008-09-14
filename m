From: David Miller <davem@davemloft.net>
Date: Sun, 14 Sep 2008 09:25:37 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <20080914.022537.32432218.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Sun, 14 Sep 2008 11:39:19 +0300 (EEST)

> {7} ok .registers
>         Normal          Alternate       MMU               Vector
> 0:                 0                0                0                0
> 1:            781100                6         fff9f6d0 ffffffffffffffff
> 2:            798c00      1ccf8207c08         f0000000         f0000000
> 3:          fffd0000                1                1         fffd0000
> 4:          deadbeef      1ccf8207c10                1         f004c99c
> 5:          deadbeef                1                f               aa
> 6:          deadbeef           200000         fffd0000         fff9f000
> 7:                10                0               68                7
> %PC  5813c0 %nPC 5813c4
> %TBA f0000000 %CCR 44 XCC:nZvc   ICC:nZvc

Can you go into your build tree and say:

bash$ gdb ./vmlinux
(gdb) x/10i 0x5813c0

and send the output?

Thanks.
