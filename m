From: David Miller <davem@davemloft.net>
Date: Fri, 03 Jun 2011 23:20:38 +0000
Subject: Re: [PATCH v4 12/13] sparc: select HAVE_SECCOMP_FILTER and provide
Message-Id: <20110603.162038.1779131784008384755.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1307133252-23259-1-git-send-email-wad@chromium.org>
	<1307133252-23259-12-git-send-email-wad@chromium.org>
In-Reply-To: <1307133252-23259-12-git-send-email-wad@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wad@chromium.org
Cc: linux-kernel@vger.kernel.org, kees.cook@canonical.com, torvalds@linux-foundation.org, tglx@linutronix.de, mingo@elte.hu, rostedt@goodmis.org, jmorris@namei.org, paulmck@linux.vnet.ibm.com, sparclinux@vger.kernel.org

From: Will Drewry <wad@chromium.org>
Date: Fri,  3 Jun 2011 15:34:11 -0500

> Facilitate the use of CONFIG_SECCOMP_FILTER by wrapping compatibility
> system call numbering for execve and selecting HAVE_SECCOMP_FILTER.
> 
> Signed-off-by: Will Drewry <wad@chromium.org>

Acked-by: David S. Miller <davem@davemloft.net>
