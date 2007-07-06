From: David Miller <davem@davemloft.net>
Date: Fri, 06 Jul 2007 09:48:15 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <20070706.024815.41637368.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 06 Jul 2007 02:33:59 -0700 (PDT)

> But that works properly on my SB1500, so I'll try this test program
> next on my ultra5.  It should print:
> 
> x0:0x8e100080
> x8:0x00000006
> 
> and an strace of that test program shows good reads:
> 
> open("/proc/bus/pci/0000:00/00.0", O_RDONLY) = 3
> lseek(3, 0, SEEK_SET)                   = 0
> read(3, "\216\20\0\200", 4)             = 4
> lseek(3, 8, SEEK_SET)                   = 8
> read(3, "\0\0\0\6", 4)                  = 4
> close(3)                                = 0

And this test program works on my ultra5 with 2.6.22 as well.

Perhaps we have a kernel miscompile here?  Can you guys try the test
program on your systems with the failing kernel?

While waiting for your test results I'm going to rebuild my
ultra5 kernel with Dmitry's kernel config.
