From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2006 20:04:03 +0000
Subject: Re: NIC interrupt assignments under UltraSPARC-T1
Message-Id: <20060919.130403.82517897.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4509B8CB.2070103@hp.com>
In-Reply-To: <4509B8CB.2070103@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rick Jones <rick.jones2@hp.com>
Date: Thu, 14 Sep 2006 13:17:15 -0700

> Is it indeed not possible to alter the interrupt assignments or have
> I (as I'm wont to do) missed something quasi-obvious?

Unfortunately this feature had to be removed for the time
being.  The reason is that the "switch" used to occur
dynamically on the next received interrupt.  Ie. when
the next instance of that interrupt arrived, we would
program it to something in the newly configured affinity
mask.

That proved to be race prone and could jam up an interrupt,
so until I am able to diagnose that problem and re-add the
necessary logic, interrupt distribution is currently fixed.
