From: Jarod Wilson <jwilson@redhat.com>
Date: Wed, 27 Feb 2008 20:21:04 +0000
Subject: Re: [PATCH 1/2] firewire: endianess fix
Message-Id: <200802271521.05099.jwilson@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<200802271458.28401.jwilson@redhat.com>
	<47C5C340.7080302@s5r6.in-berlin.de>
In-Reply-To: <47C5C340.7080302@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>, Harvey Harrison <harvey.harrison@gmail.com>

On Wednesday 27 February 2008 03:08:32 pm Stefan Richter wrote:
> Jarod Wilson wrote:
> > Works just fine with the Apple UniNorth controller in my powerbook in
> > cursory testing.
>
> Could you remove the OHCI1394_HCControl_postedWriteEnable flag from
> fw-ohci.c::ohci_enable() and test without and with the endianess patch?

Sure, added to the todo list along with making sure things survive bus resets.

-- 
Jarod Wilson
jwilson@redhat.com
