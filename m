From: David Miller <davem@davemloft.net>
Date: Tue, 30 Aug 2011 23:26:24 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110830.192624.1526383584670927062.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Faulkner <jfaulkne@ccs.neu.edu>
Date: Tue, 30 Aug 2011 19:01:10 -0400

> Well, I've made a little bit of progress.  linux-2.6.21.7 boots, while
> linux-2.6.22.19 does not.  With the latter kernel, this is the last
> message before the machine hangs:
> mem_init: Calling free_all_bootmem().
> 
> linux-2.6.23.17 exhibits the same symptom.  I'll start testing the
> 2.6.22-rc kernels until I narrow down the problem kernel.

Don't bother, I don't think this isn't going to help us.

The core issue is that devices are showing up multiple times in
the device tree, and the kernel gets really upset that we try
to register those PCI devices multiple times.

The two devices that show up twice are devfn=0x18 and devfn=0x38,
the 0x18 one is the PMU but I don't know what the 0x38 device is
since it doesn't show up in the sb100 example prtconf output we
have in the prtconf archive GIT tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/davem/prtconfs.git

To get the devfn for a PCI device tree node, take the first 32-bit
word in the 'reg' property and extract bits 15-8 (ie '(reg>>8)&0xff')

Can you give us "/usr/sbin/prtconf -pv" output from a working boot
so we can add it to our collection?  Thanks.

Try turning on the ofpci_verbose tracing facility by passing
'ofpci_debug=1' on the kernel command line.

Either something is wrong with the OF device tree we import into
memory, or for some reason we scan the PBM's PCI bus twice.  I
think the second is the most unlikely since there is special code
to prevent multiple PBMs from being probed in pci_sabre.c
