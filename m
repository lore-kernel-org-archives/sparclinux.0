From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 28 Feb 2008 02:41:46 +0000
Subject: Re: [PATCH 1/2] firewire: endianess fix
Message-Id: <1204166506.15052.336.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<1203545913.25307.47.camel@brick>
	<tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>
	<tkrat.9e19fa31951506af@s5r6.in-berlin.de>
In-Reply-To: <tkrat.9e19fa31951506af@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, Jarod Wilson <jwilson@redhat.com>, linux1394-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>, Harvey Harrison <harvey.harrison@gmail.com>


On Sat, 2008-02-23 at 12:24 +0100, Stefan Richter wrote:
> The generation of incoming requests was filled in in wrong byte order on
> machines with big endian CPU.
> 
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Cc: sparclinux@vger.kernel.org
> Cc: linuxppc-dev@ozlabs.org
> ---
> 
> This patch is a shot in the dark, based on a warning when building with
> C=1 CHECKFLAGS="-D__CHECK_ENDIAN__".  Is it really a fix, or was the
> previous code accidentally correct?
> 
> This needs to be tested on different big endian PCs, if possible with
> the Apple Uninorth FireWire controller and other types of controllers.
> One test which involves ohci->request_generation is simply with an SBP-2
> device (harddisk, CD-ROM...).  Does SBP-2 login etc. work?

Do we have the workaround for the old Apple UniNorth in the new FW OHCI
driver (for selfID swapping iirc ?)

There are several variants of Apple OHCI's here, but afaik only one with
a "problem".

Cheers,
Ben.


