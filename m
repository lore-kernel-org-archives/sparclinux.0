From: David Miller <davem@davemloft.net>
Date: Wed, 06 Aug 2014 21:42:38 +0000
Subject: Re: [PATCH 01/15] sparc: fix decimal printf format specifiers prefixed with 0x
Message-Id: <20140806.144238.2222819388942393951.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1407300096-32151-1-git-send-email-hans@hanshq.net>
In-Reply-To: <1407300096-32151-1-git-send-email-hans@hanshq.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hans@hanshq.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Hans Wennborg <hans@hanshq.net>
Date: Tue,  5 Aug 2014 21:41:36 -0700

> The prefix suggests the number should be printed in hex, so use
> the %x specifier to do that.
> 
> Found by using regex suggested by Joe Perches.
> 
> Signed-off-by: Hans Wennborg <hans@hanshq.net>

Applied, thank you.
