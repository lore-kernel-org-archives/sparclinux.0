From: David Miller <davem@davemloft.net>
Date: Thu, 14 Jan 2016 21:22:52 +0000
Subject: Re: [PATCH v2] sparc64: Fix numa node distance initialization
Message-Id: <20160114.162252.1081656514724716179.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1452062135-58381-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1452062135-58381-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Thu, 7 Jan 2016 18:24:35 -0700

> I don't mean to be nitpicking, just want to make sure "numa=off"
> behavior gets handled correctly. With this code change,
> node_distance() will return either LOCAL_DISTANCE or REMOTE_DISTANCE
> even when kernel is booted up with "numa=off". Would that end up not
> honoring "numa=off"? Should this loop initialize all numa_latency
> elements to LOCAL_DISTANCE if numa_enabled is not true, otherwise to
> LOCAL_DISTANCE and REMOTE_DISTANCE as appropriate? Please do let me
> know if it really is not a concern here.

Considering this further, we want to preserve the exact behavior that
occurs before the patch that got bisected to.

And that behavior is to use the default definition of node_distance()
which is:

#define node_distance(from,to)	((from) = (to) ? LOCAL_DISTANCE : REMOTE_DISTANCE)

which is completely not influenced by "numa_enabled" at all.

So, we should setup the default table values regardless of the
"numa_enabled" value when CONFIG_NUMA is enabled, and that is
exactly what this v2 patch is doing.

So I will apply this, and queue it up for -stable.  Thanks everyone.
