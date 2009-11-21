From: David Miller <davem@davemloft.net>
Date: Sat, 21 Nov 2009 05:43:46 +0000
Subject: Re: 2.6.31.6 freezes on v210
Message-Id: <20091120.214346.172362197.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091120210249.A20906@linux.karinthy.hu>
In-Reply-To: <20091120210249.A20906@linux.karinthy.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Laszlo Valko <valko@linux.karinthy.hu>
Date: Sat, 21 Nov 2009 05:47:43 +0100

> Does it help if I try to narrow this down both the kernel version
> introducing this, and the minimum set of config options with which I
> can still reproduce it?

The most useful thing would be if you could use GIT to
bisect down to the exact commit which introduced the
problem.
