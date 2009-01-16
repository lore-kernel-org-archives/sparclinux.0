From: Meelis Roos <mroos@linux.ee>
Date: Fri, 16 Jan 2009 10:48:55 +0000
Subject: Re: [PATCH] sparc64: fix modpost failure
Message-Id: <Pine.SOC.4.64.0901161237430.2120@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20090116101449.GA20332@uranus.ravnborg.org>
In-Reply-To: <20090116101449.GA20332@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Previously PeeCeeI.o was a library but it
> was always pulled in due to insw and friends being exported
> (at least for a modular kernel).
> 
> But this resulted in modpost failures if there where no in-kernel
> users because then insw & friends were not linked in.
> 
> Fix this by including PeeCeeI.o in the kernel unconditionally.
> 
> The only drawback for this solution is that a nonmodular kernel
> will always include insw & friends no matter if they are in use or not.
> 
> Reported-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

And it works too.

-- 
Meelis Roos (mroos@linux.ee)
