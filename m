From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2014 23:38:23 +0000
Subject: Re: [PATCH] sparc: Let memset return the address argument
Message-Id: <20140909.163823.1969878759983159404.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1409324901-19291-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1409324901-19291-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andreas@gaisler.com
Cc: sparclinux@vger.kernel.org, sam@ravnborg.org, linux-kernel@vger.kernel.org, software@gaisler.com

From: Andreas Larsson <andreas@gaisler.com>
Date: Fri, 29 Aug 2014 17:08:21 +0200

> This makes memset follow the standard (instead of returning 0 on success). This
> is needed when certain versions of gcc optimizes around memset calls and assume
> that the address argument is preserved in %o0.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Applied, thanks Andreas.
