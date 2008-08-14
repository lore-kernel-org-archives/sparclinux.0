From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Thu, 14 Aug 2008 10:47:23 +0000
Subject: Re: ultra5/10 bootup hang bug
Message-Id: <a4423d670808140347s7d7bffa3r71a7d72f88d8082b@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080814.013916.193700865.davem@davemloft.net>
In-Reply-To: <20080814.013916.193700865.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

2008/8/14 David Miller <davem@davemloft.net>:
>
> Hey guys, while snooping around some more trying to figure out
> what might be causing the MIGRATE_* value corruption and thus
> the crash, I found the following bug.
>
> In nid_range(), we can overshoot "end" if "start" begins on a
> non-page boundary.
>
> It may or may not fix the bug we're tracking down, I don't know,
> but it's worth testing :-)  Anyways, the patch is below.
>
> I also look forward to the tracing results from that debugging
> patch I gave you guys earlier.

I tried it with both your patches with the same result - it hangs with
the same BUG message.
