From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 19 Aug 2010 13:15:16 +0000
Subject: Re: Userspace process crashes with PREEMPT
Message-Id: <Pine.LNX.4.64.1008190907280.19440@hs20-bc2-1.build.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

BTW. two years ago, I reported a bug that userspace programs on sparc64 
would randomly crash in a few hours with preempt enabled 
( http://marc.info/?l=linux-sparc&m1222607414906&w=4 )

Now I tried the same workload with 2.6.35 and it is stable with preempt.

Are you aware that the bug was fixed? Or if not, it may be still lurking 
there and some unrelated change hid the race condition. Should I bisect 
the kernel to find out which patch actually fixed (or hid) the bug?

Mikulas

