From: Robert Reif <reif@earthlink.net>
Date: Sun, 14 Sep 2008 14:38:47 +0000
Subject: Re: [PATCH]: Updated PROM sun4m IRQ register patch.
Message-Id: <48CD21F7.7070200@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080913.214526.47086017.davem@davemloft.net>
In-Reply-To: <20080913.214526.47086017.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Robert Reif wrote:
> I just tried SMP and I got a Watchdog Reset.  I'll back this one out 
> and see if the first one works SMP.
Current sparc-next works fine SMP so only this patch has SMP issues.
