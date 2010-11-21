From: David Miller <davem@davemloft.net>
Date: Sun, 21 Nov 2010 00:34:50 +0000
Subject: Re: handover boot console problem
Message-Id: <20101120.163450.193731467.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4CE81804.3000909@mydatex.cz>
In-Reply-To: <4CE81804.3000909@mydatex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Smolik <marvin@mydatex.cz>
Date: Sat, 20 Nov 2010 19:48:36 +0100

> Hi all,
> I upgrade my old E250 with RSC console to 2.6.36 an found that there
> is some broken with handover early console.
 ...
> I don't know why console is switched to tty0. With 2.6.26 console work
> normaly.

Ten releases is hundreds of megabytes worth of changes, and thus
makes it difficult to track down the problem.

Can you try some releases in between to try and bisect this down to
something more specific?

Also make sure you do have all the necessary drivers and serial
console options enabled.

Thanks.
