From: David Miller <davem@davemloft.net>
Date: Mon, 21 Dec 2009 02:37:41 +0000
Subject: Re: [PATCH 2/2] sparc: us2e_cpufreq.c: fix warnings/errors
Message-Id: <20091220.183741.104076950.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1261311396-609-2-git-send-email-a.beregalov@gmail.com>
In-Reply-To: <1261311396-609-2-git-send-email-a.beregalov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Sun, 20 Dec 2009 15:16:36 +0300

> Fix warnings which become build errors since -Werror is used.
> arch/sparc/kernel/us2e_cpufreq.c:180: error: control reaches end of non-void function
> arch/sparc/kernel/us2e_cpufreq.c:203: error: control reaches end of non-void function
> 
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>

Same problem as patch #1, the BUG() in the default switch
case makes the end of the function unreachable, GCC should
not warn about this.  And it never has before.

Something changed to make this start happening.
