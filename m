From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 24 Feb 2011 02:47:08 +0000
Subject: Re: [PATCH] of/pdt: allow DT device matching by fixing 'name'
Message-Id: <20110224024708.GA12139@angua.secretlab.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20110223150357.5a40793d@queued.net>
 <20110223232815.GC5404@angua.secretlab.ca>
 <20110223163442.2974bd66@queued.net>
In-Reply-To: <20110223163442.2974bd66@queued.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andres Salomon <dilinger@queued.net>
Cc: Daniel Drake <dsd@laptop.org>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Wed, Feb 23, 2011 at 04:34:42PM -0800, Andres Salomon wrote:
> 
> Commit e2f2a93b changed dp->name from using the 'name' property to
> using package-to-path.  This fixed /proc/device-tree creation by
> eliminating conflicts between names (the 'name' property provides
> names like 'battery', whereas package-to-path provides names like
> '/foo/bar/battery@0', which we stripped to 'battery@0').  However,
> it also breaks of_device_id table matching.
> 
> The fix that we _really_ wanted was to keep dp->name based upon
> the name property ('battery'), but based dp->full_name upon
> package-to-path ('battery@0').  This patch does just that.
> 
> This also changes OLPC behavior to use the full result from
> package-to-path for full_name, rather than stripping the directory
> out.  In practice, the strings end up being exactly the same; this
> change saves time, code, and memory.
> 
> v2: combine two patches and revert of_pdt_node_name to original version
> v3: use dp->phandle instead of passing around node
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>

This addresses one of my comments on v2; but it doesn't address the
comment that the broken implementation of of_pdt_node_name for
non-sparc still remains, or am I missing something?

g.

