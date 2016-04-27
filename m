From: David Miller <davem@davemloft.net>
Date: Wed, 27 Apr 2016 20:02:11 +0000
Subject: Re: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <20160427.160211.71829582702131634.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 27 Apr 2016 23:01:07 +0300 (EEST)

> System.map-4.5.0-rc4-00037-g65c23c6:0000000000408000 T swapper_tsb
> System.map-4.6.0-rc4-00007-g95d0c42:0000000000408028 T swapper_tsb
                                                    ^^

Yeah that's definitely wrong.

This confirms my theory, thanks!

