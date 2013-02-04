From: David Miller <davem@davemloft.net>
Date: Mon, 04 Feb 2013 17:54:50 +0000
Subject: Re: [PATCH next] OF: convert devtree lock from rw_lock to raw spinlock
Message-Id: <20130204.125450.2011131720910598109.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1359993921-18145-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1359993921-18145-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: paul.gortmaker@windriver.com
Cc: rob.herring@calxeda.com, grant.likely@secretlab.ca, sam@ravnborg.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-rt-users@vger.kernel.org, tglx@linutronix.de

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon,  4 Feb 2013 11:05:21 -0500

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> With the locking cleanup in place (from "OF: Fixup resursive
> locking code paths"), we can now do the conversion from the
> rw_lock to a raw spinlock as required for preempt-rt.
> 
> The previous cleanup and the this conversion were originally
> separate since they predated when mainline got raw spinlock (in
> commit c2f21ce2e31286a "locking: Implement new raw_spinlock").
> 
> So, at that point in time, the cleanup was considered plausible
> for mainline, but not this conversion.  In any case, we've kept
> them separate as it makes for easier review and better bisection.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [PG: taken from preempt-rt, update subject & add a commit log]
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: David S. Miller <davem@davemloft.net>
