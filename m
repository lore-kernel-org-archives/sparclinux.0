From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 01 Sep 2005 21:56:46 +0000
Subject: Re: [PATCH 2/2] Add OpenBoot magic SysRq command
Message-Id: <20050901.145646.08249375.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050817205527.GA9362@palantir8>
In-Reply-To: <20050817205527.GA9362@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 17 Aug 2005 21:55:27 +0100

> This patch against 2.6.10 adds key 'o' to the Magic SysRq commands, which
> drops down to the OpenBoot prompt.

This should be registered in a common place so that both
sparc and sparc64 get this feature.
