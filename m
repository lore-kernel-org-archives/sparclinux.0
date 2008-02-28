From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Thu, 28 Feb 2008 08:41:20 +0000
Subject: Re: [PATCH 1/2] firewire: endianess fix
Message-Id: <47C673B0.2070705@s5r6.in-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080220220326.GA22328@uranus.ravnborg.org>	<1203545913.25307.47.camel@brick>	<tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>	<tkrat.9e19fa31951506af@s5r6.in-berlin.de>
	<1204166506.15052.336.camel@pasglop>
In-Reply-To: <1204166506.15052.336.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>, Harvey Harrison <harvey.harrison@gmail.com>

Benjamin Herrenschmidt wrote:
> Do we have the workaround for the old Apple UniNorth in the new FW OHCI
> driver (for selfID swapping iirc ?)

According to ohci1394.c, it selfIDs and headers of incoming packets are 
not byte-swapped by the old Apple Uninorth FireWire part.  And no, 
firewire-ohci doesn't have the workaround yet.

It should be trivial to copy'n'paste ohci1394's workaround into fw-ohci, 
but it would be good if someone could test before and after.

BTW, since that code is touched everytime a packet is received, we 
should enclose such a workaround in #ifdef CONFIG_PPC_PMAC && 
CONFIG_PPC32, shouldn't we?  (As a second step after adding the workaround.)
-- 
Stefan Richter
-===-=--- --=- ==--
http://arcgraph.de/sr/
