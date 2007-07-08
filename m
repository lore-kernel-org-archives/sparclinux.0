From: Dmitry Artamonow <mad_soft@inbox.ru>
Date: Sun, 08 Jul 2007 18:05:08 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <20070708180508.GB9834@rainbow>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 23:02 Fri 06 Jul     , David Miller wrote:
> 
> > Seems that your patch was not the only related change between -rc4 and -rc5.
> > Anyway, X still doesn't work with -rc5 so probably problem is somewhere
> > else. I sent you privately strace logs for X with 2.6.22-rc5.
> 
> Some more progress, there seems to be code in the X server that
> hard-codes the I/O and MEM space sizes based upon the PCI
> IDs of the Sun PCI host controller.  Barf...
> 
> Does it make further progress with the following patch?
> 
Well, no. I applied it against -rc7 and Xorg still doesn't work (as far as
I can tell by its console output - until tomorrow I have only remote access
to my U10). Sent you another portion of logs.
Just in case, here's results from your testcase program:

vanilla 2.6.22-rc7:
x0:0x8e100080
x8:0x00000006

2.6.22-rc7 + patch:
x0:0x8e100020
x8:0x00000000

--
Best regards,
Dmitry "MAD" Artamonow
