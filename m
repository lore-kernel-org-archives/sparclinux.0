From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 24 Mar 2006 22:33:41 +0000
Subject: Re: Sun Enterprise 6500. 10xUltraSPARC/400MHz, 10Gb mem
Message-Id: <20060324.143341.87882843.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87d5gegxf3.fsf@pumba.bayour.com>
In-Reply-To: <87d5gegxf3.fsf@pumba.bayour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Lamar Owen <lowen@pari.edu>
Date: Fri, 24 Mar 2006 14:08:46 -0500

> On Thursday 23 March 2006 23:08, Dennis Jenkins wrote:
> > I have a 8 processor E3500.  Linux (Gentoo for me)
> > works great, except that it CAN NOT use the internal
> > Fiber Channel disk array.  
> 
> Where did this information come from?  I also have an E3500, and four 36.4GB 
> drives....

The SOC/SOC+ drivers are known to be busted. Ben Collins and
I have taken stabs recently to try and get it working with
only limited luck.

And even if we get it working, folks will need to extract the SOC/SOC+
firmware out of the Solaris driver by hand and include it into a
custom build of the Linux driver in order to get a working setup.
