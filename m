From: David Miller <davem@davemloft.net>
Date: Sat, 26 Feb 2011 03:05:26 +0000
Subject: Re: [PATCH] Don't build any of the sparc arch bits with -Werror
Message-Id: <20110225.190526.183047616.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1298678235-29164-1-git-send-email-dennis@ausil.us>
In-Reply-To: <1298678235-29164-1-git-send-email-dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dennis Gilmore <dennis@ausil.us>
Date: Fri, 25 Feb 2011 20:48:33 -0600

> a shorter followup
> 
> grep Wunused-but-set-variable build.log |wc -l
> 1257
> 
> in pretty much every section of the kernel.  so yes while it will need fixing 
> its not something i have the time to do right now.

You haven't even looked into the build warnings, so you don't even
know the true and real extent of the problem.

Maybe it's one or two inline functions causing all of them, either
directly or indirectly, and if so then it's 15 minutes of your time,
no more.
