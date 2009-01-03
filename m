From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 05:32:43 +0000
Subject: Re: [PATCH 3/4] sparc: fix warning in userspace header traps.h
Message-Id: <20090102.213243.208722195.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1230849630-22482-3-git-send-email-sam@ravnborg.org>
In-Reply-To: <1230849630-22482-3-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu,  1 Jan 2009 23:40:29 +0100

> Fix following warning:
> traps.h:23: extern's make no sense in userspace
> 
> Add an ifdef __KERNEL__ block that cover the
> extern definition and a few related things that neither
> is for userspace.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
