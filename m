From: Turbo Fredriksson <turbo@swe.net>
Date: Mon, 04 Jul 2005 09:49:02 +0000
Subject: Re: ipt_recent && spamd (!?) && kernel panic
Message-Id: <87vf3qx5o1.fsf@pumba.bayour.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87oeahuwt3.fsf@pumba.bayour.com>
In-Reply-To: <87oeahuwt3.fsf@pumba.bayour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>>>> "David" = David S Miller <davem@davemloft.net> writes:

    David> You're not the only person seeing this.
    David> Here is a temp fix:

Sorry for not replying sooner, but I didn't want to reboot for this
fix alone. But this morning I needed to rearrange the disks and
add some more memory, so I took the opportunity to upgrade the
kernel as well...

I've now been running with this patch for about ten minutes, and
so far so good. I.e. the kernel haven't crashed yet :)
So it seems that the fix works for me to... Thanx!
