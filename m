From: David Miller <davem@davemloft.net>
Date: Tue, 03 Mar 2015 22:06:23 +0000
Subject: Re: [PATCH] sparc: semtimedop() unreachable due to comparison error
Message-Id: <20150303.170623.1690158421974979602.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1425363415-4154-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1425363415-4154-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Mon,  2 Mar 2015 23:16:55 -0700

> A bug was reported that the semtimedop() system call was always
> failing eith ENOSYS.
> 
> Since SEMCTL is defined as 3, and SEMTIMEDOP is defined as 4,
> the comparison "call <= SEMCTL" will always prevent SEMTIMEDOP
> from getting through to the semaphore ops switch statement.
> 
> This is corrected by changing the comparison to "call <= SEMTIMEDOP".
> 
> Orabug: 20633375
> 
> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>

Amazing how something like this can be broken for so long.

Applied and queued up for -stable, thanks Rob.
