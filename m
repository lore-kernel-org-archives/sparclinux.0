From: Stefan Holst <mail@s-holst.de>
Date: Thu, 18 Mar 2004 00:09:36 +0000
Subject: Re: nonzero phys_base
Message-Id: <20040318000936.GC5754@spike>
List-Id: <sparclinux.vger.kernel.org>
References: <20040316114121.GA5170@spike>
In-Reply-To: <20040316114121.GA5170@spike>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03/16, Keith M Wesolowski wrote:
> On Tue, Mar 16, 2004 at 12:41:21PM +0100, Stefan Holst wrote:
> 
> > how do you think about this fix? any chances to get this into the
> > kernel? if yes, how? this is the first time i send kernel patches,
> > so hints and comments are very welcome :).
> 
> Yes, I'll consider this for inclusion.  You get patches into the
> kernel by sending them to this list, so you're off to a good start
> there.
> 
> Please use pfn_base the way sparc64 does.  Shifting every time this is
> used is unnecessarily expensive.  It would be nice if we could also

done, see patch in other post.

> dispense with making __va and __pa nonconstant, but unlike sparc64 we
> don't have the luxury of huge space to map into.

if phys_base is known at compile time, it could be a macro, at least 
in __pa and __va to make them constant. would that be an option?

> 
> Otherwise this looks pretty good at first glance.
> 
> Thanks for doing this, Stefan.

thanks :)
but that was not entirely my work. i just tied up to konrad's at
the moment.

-- 
RY  Stefan
+-----------------+----------------+
| mail@s-holst.de | www.s-holst.de |
+-----------------+----------------+
