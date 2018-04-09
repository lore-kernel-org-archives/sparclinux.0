From: Meelis Roos <mroos@linux.ee>
Date: Mon, 09 Apr 2018 10:47:09 +0000
Subject: Re: sparc64 PCI BAR allocation is still problematic
Message-Id: <alpine.LRH.2.21.1804091346290.16892@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee> <20180408.172152.113123578529151252.davem@davemloft.net> <041acadb-e35e-80e5-2461-13b016b22cd1@codeaurora.org>
In-Reply-To: <041acadb-e35e-80e5-2461-13b016b22cd1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sinan Kaya <okaya@codeaurora.org>
Cc: David Miller <davem@davemloft.net>, yinghai@kernel.org, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org

> >> This is a followup on the thread https://lkml.org/lkml/2015/10/7/135 and 
> >> corresponding https://bugzilla.kernel.org/show_bug.cgi?id7191 entry.
> >>
> >> I saw some sparc64 PCI allocation changes in yesterdays git and compiled 
> >> 4.16.0-10242-gf605ba9 on most of my sparc64 machines to test if the PCI 
> >> BAR allocation problems introduced in 4.3 were fixed on some of them. 
> >> Alas, no change at all - of the test machines, none showed any changes 
> >> in the error messages in "dmesg | grep BAR".
> >>
> >> There was one test machine, T1000 with no addon cards, that did not 
> >> encounter any problem, before or after the recent patch. All the other 
> >> test machines tried still have the BAR allocation problems.
> >>
> >> The errors seem to cluster into 3 categories:
> >>
> >> 1. many devices fail BAR allocations
> >> 2. one of the Davicom Ethernet devices fails BAR allocation
> >> 3. Uli ISA bridge fails BAR allocation.
> >>
> >> Full current dmesg and lspci info is also available if there is any 
> >> interest. I did not include it all here, which machines are interesting?
> > 
> > PCI folks, please look into this.
> > 
> > A regression like this should not linger since 4.3, thank you.
> > 
> 
> It sounds like a FW issue. Does the problem go away when you boot with
> pci=realloc kernel command line?

Tried it on T2000, still the same.

-- 
Meelis Roos (mroos@linux.ee)
