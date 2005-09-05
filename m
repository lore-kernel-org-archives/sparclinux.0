From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Mon, 05 Sep 2005 10:48:00 +0000
Subject: Re: [PATCH 2/2] Add OpenBoot magic SysRq command
Message-Id: <20050905104800.GA9564@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20050817205527.GA9362@palantir8>
In-Reply-To: <20050817205527.GA9362@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Sep 01, 2005 at 02:56:46PM -0700, David S. Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Wed, 17 Aug 2005 21:55:27 +0100
> 
> > This patch against 2.6.10 adds key 'o' to the Magic SysRq commands, which
> > drops down to the OpenBoot prompt.
> 
> This should be registered in a common place so that both
> sparc and sparc64 get this feature.

Unfortunately I'm not aware of such a common place. Could you (or someone
else) please enlighten me?
I was considering a similar patch for sparc64, but it would be great if
that is not needed.

Thanks,
-- 
Martin
