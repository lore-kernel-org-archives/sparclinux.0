From: David Miller <davem@davemloft.net>
Date: Fri, 04 Apr 2014 20:53:41 +0000
Subject: Re: [PATCH 3/4 v2] sparc64, nmi: Add more flexible NMI back trace support
Message-Id: <20140404.165341.2082003037256406028.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1396644430-70649-1-git-send-email-dzickus@redhat.com>
	<1396644430-70649-4-git-send-email-dzickus@redhat.com>
In-Reply-To: <1396644430-70649-4-git-send-email-dzickus@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dzickus@redhat.com
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, x86@kernel.org, sparclinux@vger.kernel.org, mguzik@redhat.com, atomlin@redhat.com

From: Don Zickus <dzickus@redhat.com>
Date: Fri,  4 Apr 2014 16:47:09 -0400

> From: Aaron Tomlin <atomlin@redhat.com>
> 
> This patch introduces the sparc specific implementation
> changes to the arch_trigger_all_cpu_backtrace() routine.
> Now users have the ability to choose whether or not to
> issue an NMI back trace which includes current.
> 
> Update sysrq_handle_globreg() to use the new interface
> 
> [squash two sparc patches, update changelog - dcz]
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> Signed-off-by: Don Zickus <dzickus@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
