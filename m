From: Meelis Roos <mroos@linux.ee>
Date: Fri, 30 Jan 2004 19:17:37 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <Pine.GSO.4.44.0401302112300.2307-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Ok, your system isn't able to allocate the needed memory (must be an OBP
> 2.x thing). One thing you might try is upgrading your OBP, but in the
> mean time, give the attached second.b a try (put it in /boot/ and run
> "silo -f").

OK, found out that the old RARP server can not come back any time soon
and installed another netboot server.

Still Data Access Exception. This time PC(6760 and nPC(6764 but
other regs are the same as before.

-- 
Meelis Roos (mroos@linux.ee)

