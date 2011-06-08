From: Meelis Roos <mroos@linux.ee>
Date: Wed, 08 Jun 2011 07:20:26 +0000
Subject: Re: problem with newaliases & db
Message-Id: <alpine.SOC.1.00.1106081016030.8911@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1105131558530.20145@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1105131558530.20145@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > While trying to run postix's newaliases (specifically 
> > /usr/sbin/postalias hash:/etc/aliases as it is invoked by newaliases), I 
> > get the following error with 2.6.39-rc7 while it worked fine with 
> > 2.6.38. This is reproducible. postfix is from Debian unstable, using 
> > db-5.1 (ldd below). Nothing in dmesg, stderr and strace included. 
> 
> Definitely looks like garbage was read from the file for whatever
> reason, I really doubt a sparc specific change introduced this
> problem as we were pretty light on sparc64 changes during that time
> period.

I have had a look at it again. 2.6.39 packages from Debian also showed 
this problem on one machine, so 2 machines with different kernel 
configurations (Blade 100 and Ultra 10) out of 7 tested. 3.0.0-rc2 works 
fine on all of them so far. Debian has also been updated meanwhile.

If I see it again, I will try bisecting it.

-- 
Meelis Roos (mroos@linux.ee)
