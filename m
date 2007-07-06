From: Dmitry Artamonow <mad_soft@inbox.ru>
Date: Fri, 06 Jul 2007 11:44:16 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <20070706114416.GA3772@sunflower.office.asoft.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jul 06, 2007 at 02:48:15AM -0700, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Fri, 06 Jul 2007 02:33:59 -0700 (PDT)
> 
> > But that works properly on my SB1500, so I'll try this test program
> > next on my ultra5.  It should print:
> > 
> > x0:0x8e100080
> > x8:0x00000006
> > 
> > and an strace of that test program shows good reads:
> > 
> > open("/proc/bus/pci/0000:00/00.0", O_RDONLY) = 3
> > lseek(3, 0, SEEK_SET)                   = 0
> > read(3, "\216\20\0\200", 4)             = 4
> > lseek(3, 8, SEEK_SET)                   = 8
> > read(3, "\0\0\0\6", 4)                  = 4
> > close(3)                                = 0
> 
> And this test program works on my ultra5 with 2.6.22 as well.
> 
> Perhaps we have a kernel miscompile here?  Can you guys try the test
> program on your systems with the failing kernel?
> 
Well, i've tried test program on 2.6.22-rc4 with your PCI patch
(cf58de958f939587637ea74cdc3382bc140a936b) and on plain 2.6.22-rc5. 
Here's the results.

2.6.22-rc4 + PCI patch:
x0:0x8e100020
x8:0x00000000

2.6.22-rc5:
x0:0x8e100080
x8:0x00000006

Seems that your patch was not the only related change between -rc4 and -rc5.
Anyway, X still doesn't work with -rc5 so probably problem is somewhere
else. I sent you privately strace logs for X with 2.6.22-rc5.

--
Best regards
Dmitry "MAD" Artamonow

