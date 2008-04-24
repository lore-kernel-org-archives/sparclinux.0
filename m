From: David Miller <davem@davemloft.net>
Date: Thu, 24 Apr 2008 10:36:45 +0000
Subject: Re: [2.6 patch] sparc64: cleanup after SunOS/Solaris binary
Message-Id: <20080424.033645.54639130.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080423095151.GD28933@cs181133002.pp.htv.fi>
In-Reply-To: <20080423095151.GD28933@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bunk@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>
Date: Wed, 23 Apr 2008 12:51:51 +0300

> The following cleanups are now possible:
> - arch/sparc64/kernel/entry.S:ret_sys_call no longer has to be global
> - arch/sparc64/kernel/sparc64_ksyms.c:
>   remove no longer used prototypes
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Applied, thanks Adrian.
