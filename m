From: "David S. Miller" <davem@redhat.com>
Date: Thu, 15 Jan 2004 18:58:10 +0000
Subject: Re: qlogicpti on 2.6.1
Message-Id: <20040115105810.72db07bb.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.58.0401141652170.15533@redfish.gatech.edu>
In-Reply-To: <Pine.GSO.4.58.0401141652170.15533@redfish.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 15 Jan 2004 11:17:05 -0500 (EST)
Chris Ricker <kaboom@gatech.edu> wrote:

> If I recompile without SMP support, 2.6.1-UP loads the driver, and I'm able 
> to mount and use the RAID 5 array on the D1000. No problems so far, in the 
> hour or so I've been pounding it.
> 
> So, it might be SMP vs UP, or it might just be that my second CPU is dodgy, 
> though I didn't have problems with 2.4 SMP on this box....

I very much think it is an SMP locking issue, thanks for getting this data point
which appears to confirm my suspicions.
