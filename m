From: Mikael Pettersson <mikpe@it.uu.se>
Date: Fri, 27 Jul 2007 11:36:00 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <200707271136.l6RBa05U003187@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 27 Jul 2007 12:11:57 +0200 (MEST), Mikael Pettersson wrote:
> On Thu, 26 Jul 2007 18:42:23 -0700 (PDT), David Miller wrote:
> > > > open("/proc/bus/pci/0000:00/00.0", O_RDWR) = 5
> > > > ioctl(5, IIOCNETDIF, 0)                 = -1 ENOTTY (Inappropriate ioctl for device)
> > 
> > Mikael, this appears to be some 2.6.23 specific problem,
> > I had been testing 2.6.22 with the patch on my ultra5.
> > 
> > Please add my patch to 2.6.22 and it should work.
> 
> Confirmed. X (xorg-6.8.1) works fine again with 2.6.22
> plus your sun4u/sabre fix.
> 
> Thanks.

With both the sun4u/sabre fix and the /proc/bus/pci/ ioctl fix
David posted on lkml applied, X now works for me on 2.6.23-rc1.

/Mikael
