From: David Miller <davem@davemloft.net>
Date: Mon, 21 Dec 2009 02:37:00 +0000
Subject: Re: [PATCH 1/2] sparc: us3_cpufreq.c: fix warnings/errors
Message-Id: <20091220.183700.71132007.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
In-Reply-To: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Sun, 20 Dec 2009 15:16:35 +0300

> Fix warnings which become build errors since -Werror is used.
> arch/sparc/kernel/us3_cpufreq.c:60: error: 'ret' may be used uninitialized in this function
> arch/sparc/kernel/us3_cpufreq.c:101: error: 'new_bits' may be used uninitialized in this function
> 
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>

The default switch case is BUG(), therefore the end of the function is
unreachable.

What changed recently to cause this to start generating a warning, it
never did before?

