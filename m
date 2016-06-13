From: Meelis Roos <mroos@linux.ee>
Date: Mon, 13 Jun 2016 12:49:20 +0000
Subject: Re: 4.6-rc*: Kernel unaligned access at pci_bus_read_config_dword+0x64/0x80
Message-Id: <alpine.LRH.2.20.1606131548260.25241@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1606022203030.24438@math.ut.ee> <CADxRZqwuOnz8Cyedjiamyxz1nE80HxmoFANPmtZy-svr8wKfvg@mail.gmail.com>
In-Reply-To: <CADxRZqwuOnz8Cyedjiamyxz1nE80HxmoFANPmtZy-svr8wKfvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatoly Pugachev <matorola@gmail.com>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

> > Between 4.5.0 and 4.6.0-rc3, my Spar Enterprise T5120 has started
> > showing the following messages during bootup:
[...]
> 
> got the same messages on my t5120 with kernel 4.6.1 :
[...] 
> but 4.7.0-rc2+ (from git), does not have it, probably fixed.

Nope, I still get them on 4.7-rc3:

[ 4742.646120] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80
[ 4742.646197] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80
[ 4742.646265] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80
[ 4742.646333] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80
[ 4742.646401] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80

-- 
Meelis Roos (mroos@linux.ee)
