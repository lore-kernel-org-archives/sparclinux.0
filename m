From: David Miller <davem@davemloft.net>
Date: Fri, 27 Jul 2007 01:42:23 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <20070726.184223.116353787.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 26 Jul 2007 18:23:55 -0700 (PDT)

> > open("/proc/bus/pci/0000:00/00.0", O_RDWR) = 5
> > ioctl(5, IIOCNETDIF, 0)                 = -1 ENOTTY (Inappropriate ioctl for device)

Mikael, this appears to be some 2.6.23 specific problem,
I had been testing 2.6.22 with the patch on my ultra5.

Please add my patch to 2.6.22 and it should work.

I'll try to figure out what broke this on 2.6.23 :-)
