From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 16 Mar 2004 16:55:28 +0000
Subject: Re: nonzero phys_base
Message-Id: <20040316165528.GA2858@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040316114121.GA5170@spike>
In-Reply-To: <20040316114121.GA5170@spike>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Mar 16, 2004 at 12:41:21PM +0100, Stefan Holst wrote:

> how do you think about this fix? any chances to get this into the
> kernel? if yes, how? this is the first time i send kernel patches,
> so hints and comments are very welcome :).

Yes, I'll consider this for inclusion.  You get patches into the
kernel by sending them to this list, so you're off to a good start
there.

Please use pfn_base the way sparc64 does.  Shifting every time this is
used is unnecessarily expensive.  It would be nice if we could also
dispense with making __va and __pa nonconstant, but unlike sparc64 we
don't have the luxury of huge space to map into.

Otherwise this looks pretty good at first glance.

Thanks for doing this, Stefan.

-- 
Keith M Wesolowski
