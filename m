From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 21 May 2011 11:33:18 +0000
Subject: Re: [PATCH 1/2 v2] sparc32,leon: added LEON-common low-level PCI
Message-Id: <20110521113318.GA25723@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1305964529-8577-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1305964529-8577-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, May 21, 2011 at 09:55:28AM +0200, Daniel Hellstrom wrote:
> The LEON architecture does not have a BIOS or bootloader that
> initializes PCI for us, instead Linux generic PCI layer is used
> to set up resources and IRQ.
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> ---
>  arch/sparc/include/asm/pci_32.h   |    5 +
>  arch/sparc/include/asm/pci_leon.h |   36 ++++++
>  arch/sparc/include/asm/pcic.h     |    2 +-
>  arch/sparc/kernel/Makefile        |    4 +
>  arch/sparc/kernel/entry.S         |    2 +-
>  arch/sparc/kernel/leon_pci.c      |  252 +++++++++++++++++++++++++++++++++++++
>  drivers/pci/Makefile              |    1 +
>  7 files changed, 300 insertions(+), 2 deletions(-)
>  create mode 100644 arch/sparc/include/asm/pci_leon.h
>  create mode 100644 arch/sparc/kernel/leon_pci.c

Hi Daniel.

Reading through this patch it looks like LEOON pci support is bolted on top
of what we have rather than trying to integrate it a bit more.

I would like to see something like:

* include/asm/pcic.h intregated in pci_32.h
* leon specifics added to pci_32.h - with minimal ifdefs

Dunno abot the rest...

If i find time I will try to come up with a proposal later tonight.

	Sam
