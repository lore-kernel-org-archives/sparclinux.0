From: "Leif Sawyer" <lsawyer@gci.com>
Date: Tue, 08 Sep 2009 17:38:30 +0000
Subject: RE: 2.6.31-rc1: sparc T2: Fast Data Access MMU Miss
Message-Id: <38D04BF3A4B7B2499D19EB1DB54285EA0BE5B560@FNB1EX01.gci.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090904.030857.98883610.davem@davemloft.net>
In-Reply-To: <20090904.030857.98883610.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> The problem is that is a missing "notrace" annotation.
> 
> It triggers with your config because some functions don't get 
> inlined by the compiler which normally would be (which is why 
> I've never seen this before).
> 
> Please try this patch, thanks!

rebuilding with the notrace patch as well as RTC and NMI patches.

Will reboot later today during local lunch hour in case I need to
run to the remote site for a power cycle.


