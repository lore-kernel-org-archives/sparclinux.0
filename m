From: Chris Ricker <kaboom@gatech.edu>
Date: Thu, 15 Jan 2004 16:17:05 +0000
Subject: Re: qlogicpti on 2.6.1
Message-Id: <Pine.GSO.4.58.0401151112060.15394@redfish.gatech.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.58.0401141652170.15533@redfish.gatech.edu>
In-Reply-To: <Pine.GSO.4.58.0401141652170.15533@redfish.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 15 Jan 2004, David S. Miller wrote:

> On Wed, 14 Jan 2004 17:00:22 -0500 (EST)
> Chris Ricker <kaboom@gatech.edu> wrote:
> 
> > Does / should the SBUS qlogicpti driver work in the 2.6 kernels?
> 
> It's supposed to, but obviously it isn't from your report :)
> 
> I didn't see anything obvious by doing a cursory glance of the changes
> made to this driver in 2.6.x, I'll do some more auditing tomorrow.

Since it's supposed to work, I did a bit more testing. If I boot 2.6.1-SMP, 
it locks hard right after the qlogicpti driver loads and the disk drives are 
detected.

If I recompile without SMP support, 2.6.1-UP loads the driver, and I'm able 
to mount and use the RAID 5 array on the D1000. No problems so far, in the 
hour or so I've been pounding it.

So, it might be SMP vs UP, or it might just be that my second CPU is dodgy, 
though I didn't have problems with 2.4 SMP on this box....

later,
chris
