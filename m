From: David Miller <davem@davemloft.net>
Date: Mon, 21 May 2012 06:35:41 +0000
Subject: Re: [RFC PATCH] sparc32: make srmmu helpers leon compatible
Message-Id: <20120521.023541.782833985688988897.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120519200321.GA7617@merkur.ravnborg.org>
In-Reply-To: <20120519200321.GA7617@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 May 2012 07:51:55 +0200

> Anyway - as the merge window is now opened I will put this on hold
> until -rc2 or so unless you say otherwise.

I encourage you to keep working on it, getting rid of the LEON
config option would be a major improvement in maintainability.
