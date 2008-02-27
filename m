From: Jarod Wilson <jwilson@redhat.com>
Date: Wed, 27 Feb 2008 19:58:28 +0000
Subject: Re: [PATCH 1/2] firewire: endianess fix
Message-Id: <200802271458.28401.jwilson@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>
	<tkrat.9e19fa31951506af@s5r6.in-berlin.de>
In-Reply-To: <tkrat.9e19fa31951506af@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>, Harvey Harrison <harvey.harrison@gmail.com>

On Saturday 23 February 2008 06:24:17 am Stefan Richter wrote:
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

Works just fine with the Apple UniNorth controller in my powerbook in cursory 
testing. Tested with multiple sbp2 hard disks, plugging and unplugging, 
mounting and unmounting, etc.

> If possible, also test whether the device remains accessible after
> forcing a bus reset, e.g. by "echo br short > firecontrol".  You need
> the easy to build utility firecontrol and a libraw1394 with "juju"
> backend.  See wiki.linux1394.org for directions.

Forgot to check that it survived bus resets. Will try to double-check that 
tonight. I don't have any other ppc systems w/firewire controllers handy at 
the moment to try other controllers, but can probably manage to get one set 
up soon...

-- 
Jarod Wilson
jwilson@redhat.com
