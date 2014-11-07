From: David Miller <davem@redhat.com>
Date: Fri, 07 Nov 2014 20:52:14 +0000
Subject: Re: [PATCH] sparc32: Implement xchg and atomic_xchg using ATOMIC_HASH locks
Message-Id: <20141107.155214.85049633626458011.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1415199128-22339-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1415199128-22339-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andreas@gaisler.com
Cc: sparclinux@vger.kernel.org, sam@ravnborg.org, linux-kernel@vger.kernel.org, software@gaisler.com

From: Andreas Larsson <andreas@gaisler.com>
Date: Wed,  5 Nov 2014 15:52:08 +0100

> Atomicity between xchg and cmpxchg cannot be guaranteed when xchg is
> implemented with a swap and cmpxchg is implemented with locks.
> Without this, e.g. mcs_spin_lock and mcs_spin_unlock are broken.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Unfortunate, but obviously necessary.

Applied and queued up for -stable, thanks!
