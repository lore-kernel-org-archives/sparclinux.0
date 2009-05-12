From: "Hong H. Pham" <hong.pham@windriver.com>
Date: Tue, 12 May 2009 19:31:09 +0000
Subject: Re: [PATCH] sparc64: fix and optimize irq distribution
Message-Id: <4A09CE7D.2050606@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1242156589-14806-1-git-send-email-hong.pham@windriver.com>
In-Reply-To: <1242156589-14806-1-git-send-email-hong.pham@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Here's some benchmarks showing the effects of interrupt distribution on
a T2.  The test was done with iperf using a pair of T5220 boxes, each with
a 10GBe NIU (XAUI) connected back to back.  The kernel version is
2.6.30-rc5.

TCP     | Stock       Linear RR IRQ  Optimized IRQ
Streams | 2.6.30-rc5  Distribution   Distribution
         | Gbits/sec   Gbits/sec      Gbits/sec
--------+-----------------------------------------
   1       0.839       0.862          0.868
   8       1.16        4.96           5.88
  16       1.15        6.40           8.04
100       1.09        7.28           8.68


Regards,
Hong

