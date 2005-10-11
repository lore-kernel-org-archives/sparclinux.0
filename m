From: Dennis Stosberg <dennis@stosberg.net>
Date: Tue, 11 Oct 2005 21:04:28 +0000
Subject: linux-2.6.14-rc does not boot on Ultra 5
Message-Id: <20051011210428.GC2865@leonov.stosberg.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

Today I tried to update my Ultra 5 from 2.6.13 to 2.6.14-rc4 and
found that the kernel no longer boots.  The OpenBoot PROM reports an
"Illegal Instruction" after it has downloaded the kernel image:

  Sun Ultra 5/10 UPA/PCI (UltraSPARC-IIi 270MHz), Keyboard Present
  OpenBoot 3.11, 64 MB memory installed, Serial #xxxxxxxx.
  Ethernet address x:x:xx:xx:xx:xx, Host ID: xxxxxxxx.
  Rebooting with command: boot net
  Boot device: /pci@1f,0/pci@1,1/network@1,1  File and args:
  29e000 Illegal Instruction
  ok

My Ultra 5 loads its kernel via TFTP, and since it can not boot an
ELF image, I use to convert the kernel image to a.out format before
I put it to the tftp dir.

I narrowed down the change which triggers this behaviour to the
merge that Linus did from the sparc-2.6 tree between rc2-git6 and
rc2-git7.  So, the 2.6.14-rc2-git7 snapshot does not boot on my
Ultra 5, while -rc2-git6 still does.

My config is available at http://stosberg.net/tmp/config-2.6.14-rc

[Please CC me, I'm not subscribed to this list]

-Dennis
