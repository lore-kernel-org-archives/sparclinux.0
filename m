From: Meelis Roos <mroos@linux.ee>
Date: Wed, 16 Feb 2005 13:29:16 +0000
Subject: Re: framebuffer blanking
Message-Id: <Pine.SOC.4.61.0502161527080.17280@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0502151230350.2239@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0502151230350.2239@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Actually I spotted the cg3 problem already.  You'll need to add some
> debugging to the cg6 case as I can't find any problems with the blanking
> code there.  If the cg6 is not the primary console, probably the blank
> function simply isn't being invoked.

I redid my printks to be KERN_DEBUG and now unblanking does not happen, 
only one call to cg6_blank and this does the blanking case. But only 
cursor disappears.

-- 
Meelis Roos
