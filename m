From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 25 Oct 2007 14:58:08 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071025145808.GA1407@keid.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Oct 24, 2007 at 11:41:13PM -0700, David Miller wrote:
> Josip, give this debugging patch a try.  It is against 2.6.23.1
> but it should apply to most recent kernels.

OK, after resurrecting the machine once again (it had died in the meantime,
reliably as ever), I did:

patching file kernel/futex.c
Hunk #1 succeeded at 1877 (offset 3 lines).
Hunk #2 succeeded at 1903 (offset 3 lines).
Hunk #3 succeeded at 1926 (offset 3 lines).

> It should give you debugging messages in the kernel log that
> start with "FUTEX_BUG" if the debugging code triggers.
> 
> Please post just a few samples of whatever it spits out.

It's been running with the patched kernel for some 6.5 hours now, no
problems yet. I'll let you know as soon as it starts to misbehave.

-- 
     2. That which causes joy or happiness.
