From: Lamar Owen <lowen@pari.edu>
Date: Fri, 24 Mar 2006 19:08:46 +0000
Subject: Re: Sun Enterprise 6500. 10xUltraSPARC/400MHz, 10Gb mem
Message-Id: <200603241408.47256.lowen@pari.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <87d5gegxf3.fsf@pumba.bayour.com>
In-Reply-To: <87d5gegxf3.fsf@pumba.bayour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thursday 23 March 2006 23:08, Dennis Jenkins wrote:
> I have a 8 processor E3500.  Linux (Gentoo for me)
> works great, except that it CAN NOT use the internal
> Fiber Channel disk array.  

Where did this information come from?  I also have an E3500, and four 36.4GB 
drives....

> Just remember that the CPUs themselves run at 334MHz
> or 400 MHZ.  An E6500 only does 334MHz b/c the
> back-plane is too long to support faster CPUs.

The 400MHz/8MB cache CPU's can do a 5x multiplier with the right clock board, 
with the gigaplane running at 80MHz and the CPU's at 400.  This is what I 
have in mine.

> I/O.  In my opnion, the box would make a great
> database server, but would not be useful for high-end
> math or 3-d applications.

Mine is going to be a Plone ZEO client cluster, fronted by Pound.
-- 
Lamar Owen
Director of Information Technology
Pisgah Astronomical Research Institute
1 PARI Drive
Rosman, NC  28772
(828)862-5554
www.pari.edu
