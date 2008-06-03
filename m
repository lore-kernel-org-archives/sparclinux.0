From: "Dave Airlie" <airlied@gmail.com>
Date: Tue, 03 Jun 2008 20:45:57 +0000
Subject: Re: [BUG] 2.6.26-rc1 broke X on SPARC Ultra5
Message-Id: <21d7e9970806031345u4e7838fdp60bbedadd65b5f2a@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <18500.62552.958244.633204@harpo.it.uu.se>
	 <20080603.062253.17158135.davem@davemloft.net>
	 <18501.39659.952880.727014@alkaid.it.uu.se>
In-Reply-To: <18501.39659.952880.727014@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

>  >
>  > > Fatal server error:
>  > > xf86MapPciMem: Could not mmap PCI memory [base=0xe2000000,hostbase=0xe2000000,size 00] (No such file or directory)
>  > >
>  > > I'll start digging through 2.6.25->2.6.26-rc1 later today,
>  > > meanwhile I've put Xorg.0.log, Xorg strace, dmesg, and .config
>  > > files for 2.6.25 (working) and 2.6.26-rc4 (failing) in
>  > > <http://user.it.uu.se/~mikpe/linux/sparc64-2.6.26-rcN-xorg-bug/>.
>  >
>  > It's likely this change below.  Unfortunately older versions of X
>  > seemingly cannot cope with a lack of PCI host controller in the PCI
>  > hierarchy exported by the kernel.
>  >
>  > That's really a bug in X, current libpciaccess based X servers work
>  > fine, and the bug fixed by this changeset is not solvable in any other
>  > reasonable way.  So unfortunately older X verions will stay not
>  > working.  Sorry.
>  >
>  > commit c26d3c0138970778fabe114df99dffb34a04b1d7
>  > Author: David S. Miller <davem@davemloft.net>
>  > Date:   Thu May 1 01:12:40 2008 -0700
>
> Confirmed. Reverting this patch from 2.6.26-rc1 made my Xorg-7.1.1 work again.
>
> It's a shame though that a bug fix needs to have such draconian consequences.
>

Wow thats a major userspace regression to ship, we'd never get away
with doing that on x86 platforms.

Dave.
