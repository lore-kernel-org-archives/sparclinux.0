From: Meelis Roos <mroos@ut.ee>
Date: Mon, 29 Jan 2007 15:08:06 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <Pine.SOC.4.61.0701291706130.5956@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Adding proper support for the e10K console would be a nice
> easy sparc64 kernel project for someone who wants to get
> involved and has access to such a machine.

Are the any specs available, or is it just reverse engineering?

> Don't bother with netconsole support.

Orthogonally from real console, this would be a nice-to-have. I have't 
looked what netpoll actually needs - some drivers get away with very 
simple patches. Would it be easy for sunhme too?

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
