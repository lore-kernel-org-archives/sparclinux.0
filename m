From: Frans Pop <elendil@planet.nl>
Date: Mon, 09 Jun 2008 22:03:53 +0000
Subject: [panic] "Cheetah error trap taken" with Debian 2.6.24 kernel
Message-Id: <200806100003.54269.elendil@planet.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi sparclinux devs (AKA David),

We got a report on the Debian Sparc list of an installation issue 
involving a kernel panic. The thread so far is here:
- http://lists.debian.org/debian-sparc/2008/05/msg00020.html
- http://lists.debian.org/debian-sparc/2008/06/msg00000.html
  (month split; both have follow-ups)

Alexander Vlasov wrote:
> Frans Pop <elendil <at> planet.nl> writes:
>> You could also try booting with BOOT_DEBUG=3. That will give you a
>> debug shell at the earliest possible point. If the crash still happens,
>> it's definitely a kernel or hardware issue.
> 
> Haven't tried BOOT_DEBUG=3, but finally screenshoted the problem via KVM
> Here is it: http://zulu.in.ua/screenshot.png

OK, that seems pretty clear. This is still with the daily installer image, 
correct?

Let's ask the kernel developers for advice as this panic comes from there 
(arch/sparc64/kernel/traps.c).

First lines of the trap (see screenshot linked above for rest!):

Cheetah error trap taken afsr[0010080005000000] afar [000007f900800000]
TPC[553f94] TNPC[553f98] O7[554274] TSTATE[9980001606]
TPC<pci_get_rom_size+0x18/0xc4>

The kernel is either Debian kernel based on 2.6.24.4 (if the installer 
image is an older daily build) or 2.6.24.7 (if it is a current daily).
Exact version can be checked if needed.

I've added the original reporter in CC for easier follow-up.

Cheers,
FJP
