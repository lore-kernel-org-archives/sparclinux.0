From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 09 Jun 2016 17:33:56 +0000
Subject: Re: 4.6-rc*: Kernel unaligned access at pci_bus_read_config_dword+0x64/0x80
Message-Id: <CADxRZqwuOnz8Cyedjiamyxz1nE80HxmoFANPmtZy-svr8wKfvg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1606022203030.24438@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1606022203030.24438@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: sparclinux@vger.kernel.org, linux.pci@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

On Thu, Jun 2, 2016 at 10:11 PM, Meelis Roos <mroos@linux.ee> wrote:
> Between 4.5.0 and 4.6.0-rc3, my Spar Enterprise T5120 has started
> showing the following messages during bootup:
>
> [   64.564608] Kernel unaligned access at TPC[69fb04] pci_bus_read_config_dword+0x64/0x80
> [   64.564688] Kernel unaligned access at TPC[69fb04] pci_bus_read_config_dword+0x64/0x80
> [   64.564760] Kernel unaligned access at TPC[69fb04] pci_bus_read_config_dword+0x64/0x80
> [   64.564832] Kernel unaligned access at TPC[69fb04] pci_bus_read_config_dword+0x64/0x80
> [   64.564904] Kernel unaligned access at TPC[69fb04] pci_bus_read_config_dword+0x64/0x80

got the same messages on my t5120 with kernel 4.6.1 :

Jun 09 15:48:24 nvg5120 kernel: io scheduler cfq registered (default)
Jun 09 15:48:24 nvg5120 kernel: Kernel unaligned access at TPC[73b92c]
pci_bus_read_config_dword+0x6c/0x80
Jun 09 15:48:24 nvg5120 kernel: Kernel unaligned access at TPC[73b92c]
pci_bus_read_config_dword+0x6c/0x80
Jun 09 15:48:24 nvg5120 kernel: Kernel unaligned access at TPC[73b92c]
pci_bus_read_config_dword+0x6c/0x80
Jun 09 15:48:24 nvg5120 kernel: Kernel unaligned access at TPC[73b92c]
pci_bus_read_config_dword+0x6c/0x80
Jun 09 15:48:24 nvg5120 kernel: Kernel unaligned access at TPC[73b92c]
pci_bus_read_config_dword+0x6c/0x80
Jun 09 15:48:24 nvg5120 kernel: f0286d78: ttyS0 at I/O 0x0 (irq = 17,
base_baud = 115200) is a SUN4V HCONS

but 4.7.0-rc2+ (from git), does not have it, probably fixed.
