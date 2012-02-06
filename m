From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 06 Feb 2012 14:46:21 +0000
Subject: Re: sparc32: enabled CONFIG_SPARC_LEON leads to compile error
Message-Id: <4F2FE7BD.6080200@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 01/22/2012 08:57 PM, Kirill Tkhai wrote:
> Hello!
>
> I've just tried to compile kernel with enabled CONFIG_SPARC_LEON option
> and I got a compile error. This is:
>
> CC      arch/sparc/kernel/leon_pci.o
> arch/sparc/kernel/leon_pci.c:156: error: redefinition of 'pci_device_to_OF_node'
> include/linux/pci.h:1623: error: previous definition of 'pci_device_to_OF_node' was here
> make[1]: *** [arch/sparc/kernel/leon_pci.o] Error 1
> make: *** [arch/sparc/kernel] Error 2
> make: *** Waiting for unfinished jobs....
>
> It seems it happened because of closeness of two commits:
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;hd099d981c9916ec4a485b3ffbb89fa877fc595f
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h&893c1368aeb96e06e4f9dce61bbde3351d5e9f
>
> It looks like it's enough to remove double function from leon_pci.c.
>
> Kirill
Hello,

Sorry for my later reply. I haven't investigated this but at first look the "pci/of: Consolidate .." patch seems bad. After the patch it does not longer return the prom node for PCIC PCI device?

When it comes to the LEON code I think it is safe to remove pci_device_to_OF_node() function.

Regards,
Daniel

