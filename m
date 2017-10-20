From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 20 Oct 2017 12:12:27 +0000
Subject: qemu-system-sparc64: upcoming changes in 2.11
Message-Id: <cc20fc70-3a30-d511-b497-46da2bbb7175@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

As I know there are quite a few people on these lists using
qemu-system-sparc64 with Linux, I thought it would be worth writing a
quick email about some important changes to the sun4u machine in the
upcoming 2.11 release:

1) Change of default NIC from ne2k_pci to sunhme

This enables compatibility with more OSs out of the box, particularly as
some OSs don't compile all NIC drivers for SPARC, or if they do, they
are broken since they haven't been tested properly. There should be no
noticeable change for Linux users, other than you will need to make sure
that the sunhme module is included if you want basic networking without
changing any defaults.

2) Ensure devices are connected behind simba PCI bridges

Previous versions of QEMU connected all PCI devices directly onto the
sabre PCI bus and used various hacks to handle bridge windows and
interrupt routing. These have now been removed and devices connected
behind the simba bridges accordingly as per a real Ultra 5.

For Linux users the obvious change is that warnings about PCI window
overlaps will no longer appear on boot. One further point to note is
that if you are adding extra PCI devices on the command line, you must
specify bus=pciB to ensure that the device is connected behind the
appropriate simba PCI bridge; otherwise QEMU will exit with a message
along the lines of "PCI: no slot/function available for virtio-blk-pci,
all in use or reserved".

I've written this up in more detail on the QEMU wiki for people who want
further information at
https://wiki.qemu.org/Documentation/Platforms/SPARC#Changes_to_sun4u_machine_from_2.11_onwards.

Finally I'm pleased to announce that my fix for bochs_drm (commit
931e8c6 "drm/bochs: switch fb_ops over to use drm_fb_helper_cfb
helpers") which was otherwise causing a panic on boot if -nographic
wasn't supplied has been applied for the upcoming 4.14 LTS release. So
as this trickles down to the various distributions it will finally be
possible to boot Linux with a framebuffer under qemu-system-sparc64.


ATB,

Mark.
