From: Meelis Roos <mroos@linux.ee>
Date: Wed, 16 Feb 2005 07:34:37 +0000
Subject: Re: framebuffer blanking
Message-Id: <Pine.SOC.4.61.0502160932580.17280@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0502151230350.2239@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0502151230350.2239@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> You'll need to add some
> debugging to the cg6 case as I can't find any problems with the blanking
> code there.  If the cg6 is not the primary console, probably the blank
> function simply isn't being invoked.

Tried it with some printks and cg6 as the primary console. These printks 
show that when blanking, cg6_blank is entered twice, first time it 
actually goes into the blanking case and the second time into 
unblanking.

-- 
Meelis Roos (mroos@linux.ee)
