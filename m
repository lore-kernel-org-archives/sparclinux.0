From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sat, 01 Mar 2008 12:36:05 +0000
Subject: Re: [PATCH 1/2] firewire: endianess fix
Message-Id: <tkrat.8be5d3017a57e1f0@s5r6.in-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<1203545913.25307.47.camel@brick>
	<tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>
	<tkrat.9e19fa31951506af@s5r6.in-berlin.de>
	<47C00DB0.20605@s5r6.in-berlin.de>
In-Reply-To: <47C00DB0.20605@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux1394-devel@lists.sourceforge.net
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, Jarod Wilson <jwilson@redhat.com>, Sam Ravnborg <sam@ravnborg.org>, Harvey Harrison <harvey.harrison@gmail.com>

On 23 Feb, I wrote:
>> This needs to be tested on different big endian PCs, if possible with
>> the Apple Uninorth FireWire controller and other types of controllers.

I tested it myself now with VT6306 on PPC32.

> it should be triggered by replacing
> 	&fw_high_memory_region
> by
> 	&fw_private_region
> in drivers/firewire/fw-sbp2.c and testing with any SBP-2 device

This indeed demonstrates the fix.  Any IO to SBP-2 devices fails with
timeouts.  Just removing the posted write enable bit in fw-ohci wasn't
sufficient to catch it though.  Maybe the controller has write posting
enabled by default.

However, this endianess bug was low-profile because there are currently
no kernelspace or userspace drivers for the firewire stack which need to
respond in split transactions.
-- 
Stefan Richter
-===-=--- --= ----http://arcgraph.de/sr/

