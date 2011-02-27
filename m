From: David Miller <davem@davemloft.net>
Date: Sun, 27 Feb 2011 05:44:02 +0000
Subject: Re: [PATCH] sparc64: fix unused-but-set-variable warnings
Message-Id: <20110226.214402.104069197.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110226085151.GA23117@merkur.ravnborg.org>
In-Reply-To: <20110226085151.GA23117@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 Feb 2011 09:51:51 +0100

> I took a qucik stab on this - most look legitimate.
> Following is only build tested and needs a bit of review.

Thanks Sam.

I want to redo the cases where you remove the assignment of
hv_err, and make sure a comment is added that at least mentions
that we need to think about handling any potential hypervisor
errors.

I have a gcc-4.6.0 from GIT built and will validate the warning
cures.
