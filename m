From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sat, 23 Feb 2008 12:12:32 +0000
Subject: Re: [PATCH 1/2] firewire: endianess fix
Message-Id: <47C00DB0.20605@s5r6.in-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<1203545913.25307.47.camel@brick>
	<tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>
	<tkrat.9e19fa31951506af@s5r6.in-berlin.de>
In-Reply-To: <tkrat.9e19fa31951506af@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux1394-devel@lists.sourceforge.net
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, Jarod Wilson <jwilson@redhat.com>, Sam Ravnborg <sam@ravnborg.org>, Harvey Harrison <harvey.harrison@gmail.com>

I wrote:
> This needs to be tested on different big endian PCs, if possible with
> the Apple Uninorth FireWire controller and other types of controllers.
> One test which involves ohci->request_generation is simply with an SBP-2
> device (harddisk, CD-ROM...).  Does SBP-2 login etc. work?

Hmm, no, tests with SBP-2 devices won't trigger that problem at all.
All of the requests from the device will be:
   - read requests to the host's config ROM, handled by the controller's
     physical response unit instead of the driver stack's response
     handlers,
   - read requests to ORBs and read and write requests to SCSI data
     buffers which are DMA-mapped at bus addresses below 4G, hence be
     handled by the physical response unit as well,
   - write requests to firewire-sbp2's status FIFO which is mapped into
     a FireWire address range for which PCI write posting is enabled,
     hence no response subaction will be generated (unified transaction)
     and therefore ohci->request_generation remain unused.

Alas I have no idea how to create a simple test setup which really 
triggers the questionable code.  Or wait, it should be triggered by 
replacing
	&fw_high_memory_region
by
	&fw_private_region
in drivers/firewire/fw-sbp2.c and testing with any SBP-2 device which is 
_not_ based on the PL3507 bridge chip.  This moves the status FIFO into 
an area outside of PCI write posting and forces the driver stack to 
generate response packets.  (Some PL-3507 only accept unified 
transactions, hence this test needs to be performed with other bridge 
chips.)
-- 
Stefan Richter
-===-=--- --=- =-=http://arcgraph.de/sr/
