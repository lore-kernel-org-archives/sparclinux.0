From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Wed, 27 Feb 2008 20:08:32 +0000
Subject: Re: [PATCH 1/2] firewire: endianess fix
Message-Id: <47C5C340.7080302@s5r6.in-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>
	<tkrat.9e19fa31951506af@s5r6.in-berlin.de>
	<200802271458.28401.jwilson@redhat.com>
In-Reply-To: <200802271458.28401.jwilson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jarod Wilson <jwilson@redhat.com>
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>, Harvey Harrison <harvey.harrison@gmail.com>

Jarod Wilson wrote:
> Works just fine with the Apple UniNorth controller in my powerbook in cursory 
> testing.

Could you remove the OHCI1394_HCControl_postedWriteEnable flag from 
fw-ohci.c::ohci_enable() and test without and with the endianess patch?
-- 
Stefan Richter
-===-=--- --=- =-=
http://arcgraph.de/sr/
