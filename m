From: Meelis Roos <mroos@linux.ee>
Date: Fri, 13 Oct 2006 06:55:27 +0000
Subject: Re: serial console broken on Ultra 5
Message-Id: <Pine.SOC.4.61.0610130948190.3729@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I wonder if that is what causes the problems.  Just for a test
> can you retry with DEBUG_SPINLOCK enabled and the following
> patch?  I'm not very optimistic actually, because this double
> init should be harmless.

Still hangs :(

-- 
Meelis Roos (mroos@linux.ee)
