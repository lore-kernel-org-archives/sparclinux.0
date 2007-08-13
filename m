From: David Miller <davem@davemloft.net>
Date: Mon, 13 Aug 2007 22:08:22 +0000
Subject: Re: Physical cpu number on UltrasparcT1
Message-Id: <20070813.150822.24610953.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a8e8903d0708131434j1c1e2b81m5f3fb6e9c6d1a0ab@mail.gmail.com>
In-Reply-To: <a8e8903d0708131434j1c1e2b81m5f3fb6e9c6d1a0ab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "jiaqi zhang" <zation.busy@gmail.com>
Date: Tue, 14 Aug 2007 09:34:26 +1200

> Since I have to do some more tests on the cache problem of UltraSPARC
> T1,

What is this "cache problem"?

> I have to know the exact physical cpu id of each strand. Could
> anyone give me some clues on how the physical cpu number, or the
> physical core number maps the 32 cpu id?

Only the hypervisor and the ALOM knows this, and there is no
Hypervisor API to easily obtain this information.

Why do you need to know the physical strand?

You'll be better off describing what you're trying to accomplish
rather than starting from the approach you've already selected.
