From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Wed, 21 Apr 2004 20:06:03 +0000
Subject: Re: No luck booting latest 2.6.6-rc kernels
Message-Id: <20040421200603.GA484@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040421185159.GB7445@artsapartment.org>
In-Reply-To: <20040421185159.GB7445@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 21, 2004 at 02:28:41PM -0500, Art Haas wrote:

> No, I'm not using '-p' as a boot argument. I've found a bit of text
> about using a '-p' boot option in arch/sparc/prom/printf.c, but haven't

Please do.  It's as simple as telling silo "linux -p" or boot net
linux -p.

I haven't had much chance to look at this stuff the last week; it'll
be at least Saturday before I can.

-- 
Keith M Wesolowski
