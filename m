From: David Miller <davem@davemloft.net>
Date: Sun, 20 May 2012 21:24:01 +0000
Subject: Re: [RFC PATCH] sparc32: make srmmu helpers leon compatible
Message-Id: <20120520.172401.262640784293505852.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120519200321.GA7617@merkur.ravnborg.org>
In-Reply-To: <20120519200321.GA7617@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 23:18:39 +0200

> Updated RFC patch below.

Looks good.

Two small things.

First, you might want to make the LEON case the default,
because then it'll get tested more extensively.

Second, have you audited to make sure that none of this
code runs before the patchup code does?
