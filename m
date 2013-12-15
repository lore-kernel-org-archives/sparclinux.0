From: David Miller <davem@davemloft.net>
Date: Sun, 15 Dec 2013 03:29:07 +0000
Subject: Re: [PATCH 07/10] sparc: select ARCH_MIGHT_HAVE_PC_SERIO
Message-Id: <20131214.222907.1700289574170561336.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1387040376-26906-1-git-send-email-msalter@redhat.com>
	<1387040376-26906-8-git-send-email-msalter@redhat.com>
In-Reply-To: <1387040376-26906-8-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: msalter@redhat.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mark Salter <msalter@redhat.com>
Date: Sat, 14 Dec 2013 11:59:33 -0500

> Architectures which might use an i8042 for serial IO to keyboard,
> mouse, etc should select ARCH_MIGHT_HAVE_PC_SERIO.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
