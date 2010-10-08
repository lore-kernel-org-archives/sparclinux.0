From: David Miller <davem@davemloft.net>
Date: Fri, 08 Oct 2010 17:17:59 +0000
Subject: Re: [PATCH 1/2 v2] of: move phandle/ihandle into types.h and
Message-Id: <20101008.101759.193728130.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20101008004354.13b5b254@debxo>
	<20101008171210.GE3863@angua.secretlab.ca>
In-Reply-To: <20101008171210.GE3863@angua.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: dilinger@queued.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org, devicetree-discuss@lists.ozlabs.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 8 Oct 2010 11:12:10 -0600

> On Fri, Oct 08, 2010 at 12:43:54AM -0700, Andres Salomon wrote:
>> 
>> We need phandle for some exported sparc headers; of.h isn't an
>> exported header, and it would be silly to export it when all we
>> really need is one or two types from it.  Also, later patches
>> use phandle in structs that are exported to userspace, so export
>> a __kernel_phandle type.
>> 
>> Signed-off-by: Andres Salomon <dilinger@queued.net>
> 
> Looks okay to me.  I'm build testing it now on powerpc and
> microblaze.  If davem agrees, then I'll pick it up into my
> devicetree-next branch.
> 
> Question though; since sparc userspace is the only user of this,
> should the types.h header avoid exposing it on non-sparc?

I can't think of anything in Sparc userspace that needs the
phandle_t type.

In fact I was a bit confused when you asked Andres to expose
it to userspace.

What I remember from a previous thread is that some other platforms
use the type in their DT device-tree building tools or whatever, but
they define phandle_t for themselves I remember specifically
mentioning sparc has no use for this currently.
