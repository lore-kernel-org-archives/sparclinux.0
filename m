From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 14 Jun 2016 13:02:39 +0000
Subject: Re: 4.6-rc*: Kernel unaligned access at pci_bus_read_config_dword+0x64/0x80
Message-Id: <CADxRZqzd3uDAAGsU0Tsg7vzxEvdtCv+QQDp8UM=6nVNk2VqO=A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1606022203030.24438@math.ut.ee>
 <CADxRZqwuOnz8Cyedjiamyxz1nE80HxmoFANPmtZy-svr8wKfvg@mail.gmail.com> <alpine.LRH.2.20.1606131548260.25241@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1606131548260.25241@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

On Mon, Jun 13, 2016 at 3:49 PM, Meelis Roos <mroos@linux.ee> wrote:
>> > Between 4.5.0 and 4.6.0-rc3, my Spar Enterprise T5120 has started
>> > showing the following messages during bootup:
> [...]
>>
>> got the same messages on my t5120 with kernel 4.6.1 :
> [...]
>> but 4.7.0-rc2+ (from git), does not have it, probably fixed.
>
> Nope, I still get them on 4.7-rc3:
>
> [ 4742.646120] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80
> [ 4742.646197] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80
> [ 4742.646265] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80
> [ 4742.646333] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80
> [ 4742.646401] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80


Still don't see it with current git (4.7.0-rc3+) kernel on my T5120.
Probably difference with kernel config file. Can you please share your
kernel config file, so I can try it on my t5120 ?

Thanks.
