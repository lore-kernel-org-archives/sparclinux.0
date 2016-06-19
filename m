From: mroos@linux.ee
Date: Sun, 19 Jun 2016 11:42:55 +0000
Subject: Re: 4.6-rc*: Kernel unaligned access at pci_bus_read_config_dword+0x64/0x80
Message-Id: <alpine.LRH.2.20.1606191442230.5426@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqw4jG3kPz6wG5Yx5DoZV0h+Xak5j682c7stq0fNOiopZQ@mail.gmail.com> <CADxRZqw6Q-jLCnZzzq=akP5vqd3Y8RCF34pWQGNSuL2VscrbJg@mail.gmail.com> <20160618.210421.1400395696678491125.davem@davemloft.net>
 <20160618.234908.1671877676732375612.davem@davemloft.net>
In-Reply-To: <20160618.234908.1671877676732375612.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: matorola@gmail.com, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

> >> bisected to git commit 63e3027
> > 
> > That's a merge commit that adds 100 different commits, and this happened
> > way back in March.
> > 
> > Please find the exact dword access in:
> > 
> > 	drivers/pci/pcie/portdrv_{core,pci,bus}.c
> > 
> > that triggers this unaligned access so we can debug this further.
> 
> Meanwhile I figured it out, this should fix the bug:

Yes it does for me too - thank you!

-- 
Meelis Roos (mroos@linux.ee)
