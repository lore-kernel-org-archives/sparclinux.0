From: Eric Brower <ebrower@usa.net>
Date: Thu, 04 Mar 2004 20:02:43 +0000
Subject: [ANNOUNCE] a few cs patches for experimental Nell driver
Message-Id: <40478B63.3070707@usa.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Patches to a few PCMCIA cs drivers are available for use with the 
experimental Nell (PCMCIA-Sbus bridge) driver.  Both the driver and the 
patches can be found at:

	http://sparclinux.net/pub/patches/nell_v0.1.2.tgz
	http://sparclinux.net/pub/patches/nell_v0.1.2_cs_patches.tgz

The patches are for orinoco_cs (hermes.h) and axnet_cs.  Also included 
for reference is a 3c589_cs.c that has been converted to use the 
virtual_bus interface for educational purposes (not required for use). 
All drivers have been minimally tested and seem to work.

I've received feedback from a few folks that the Nell driver has worked 
for them.  Please note the virtual_bus interface required by this driver 
has been removed from late 2.5 and all 2.6 kernels.  Please see the 
README within the nell driver tar file for an explaination of what 
kernels are supported.

Many thanks to Uzi for hosting these files.

E

