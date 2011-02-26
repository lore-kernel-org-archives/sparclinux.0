From: David Miller <davem@davemloft.net>
Date: Sat, 26 Feb 2011 06:59:37 +0000
Subject: Re: [PATCH 1/5] sparc32: fix build with leon or floppy enabled
Message-Id: <20110225.225937.193697998.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1298234400-22378-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1298234400-22378-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Feb 2011 21:39:56 +0100

> Add a few includes back required to build with floppy enabled
> Fix declaration of trapbase_cpu* so it is now consistent
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks Sam.
