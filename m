From: David Miller <davem@davemloft.net>
Date: Sun, 08 Feb 2009 03:04:21 +0000
Subject: Re: SILO problems
Message-Id: <20090207.190421.263432908.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <498D413B.2060009@neb.rr.com>
In-Reply-To: <498D413B.2060009@neb.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Matt Cole <mikaey@neb.rr.com>
Date: Sat, 07 Feb 2009 20:29:14 -0600

> David and Tom, one of the problems I've noticed is that, with having
> the boot partition start on cylinder 0, that creating anything on
> that partition results in overwriting the disklabel.  David, I
> noticed your fdisk readout has your boot partition starting on
> cylinder 0, is this just a dummy partition?  Or how did you get
> around this problem?

Most filesystems do not write their superblock into the initial
bytes of the partition, they leave it alone.

You can't put things like RAID and swap partitions there, because
those will in fact zap out your boot block and disk label.
