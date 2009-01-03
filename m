From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 02:48:45 +0000
Subject: Re: [PATCH 2/2] sparc: unify stat.h
Message-Id: <20090102.184845.178927673.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 28 Dec 2008 22:48:52 +0100

> To my suprise struct stat64 was not equal on sparc 32 and sparc64,
> so there was really nothing to share here.
> Unify the files by adding their respective content to stat.h.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Also applied, thanks Sam.
