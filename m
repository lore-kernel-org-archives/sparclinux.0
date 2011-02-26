From: David Miller <davem@davemloft.net>
Date: Sat, 26 Feb 2011 02:10:01 +0000
Subject: Re: [PATCH] Don't build any of the sparc arch bits with -Werror
Message-Id: <20110225.181001.71112364.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1298678235-29164-1-git-send-email-dennis@ausil.us>
In-Reply-To: <1298678235-29164-1-git-send-email-dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dennis Gilmore <dennis@ausil.us>
Date: Fri, 25 Feb 2011 18:06:00 -0600

> This is due to gcc-4.6 it throws warnings for defined but unused variables. 
> without this we cant build the kernel at all.  i have buil tested but not 
> tried to run yet

Then fix the warnings since they are likely legitimate.

We've had -Werror there for _years_, don't just knee jerk remove
it because some new compiler notices new problems.
