From: David Miller <davem@davemloft.net>
Date: Tue, 13 Dec 2011 18:32:08 +0000
Subject: Re: [PATCH 02/17] UAPI: Don't include linux/compat.h in sparc's
Message-Id: <20111213.133208.1867222061450505776.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
	<1323770653-19177-3-git-send-email-dhowells@redhat.com>
In-Reply-To: <1323770653-19177-3-git-send-email-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dhowells@redhat.com
Cc: sfr@canb.auug.org.au, torvalds@linux-foundation.org, arnd@arndb.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Tue, 13 Dec 2011 10:03:58 +0000

> Don't include linux/compat.h in sparc's asm/siginfo.h as it leads to a circular
> dependency:
> 
> 	asm/siginfo.h -> linux/compat.h -> asm/siginfo.h
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
