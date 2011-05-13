From: David Miller <davem@davemloft.net>
Date: Fri, 13 May 2011 18:17:47 +0000
Subject: Re: problem with newaliases & db
Message-Id: <20110513.141747.1961548973331929691.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1105131558530.20145@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1105131558530.20145@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 13 May 2011 16:03:49 +0300 (EEST)

> 
> While trying to run postix's newaliases (specifically 
> /usr/sbin/postalias hash:/etc/aliases as it is invoked by newaliases), I 
> get the following error with 2.6.39-rc7 while it worked fine with 
> 2.6.38. This is reproducible. postfix is from Debian unstable, using 
> db-5.1 (ldd below). Nothing in dmesg, stderr and strace included. 

Definitely looks like garbage was read from the file for whatever
reason, I really doubt a sparc specific change introduced this
problem as we were pretty light on sparc64 changes during that time
period.
