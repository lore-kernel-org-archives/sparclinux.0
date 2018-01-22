From: David Miller <davem@davemloft.net>
Date: Mon, 22 Jan 2018 16:37:30 +0000
Subject: Re: [PATCH] sparc64: drop unneeded compat include
Message-Id: <20180122.113730.1454558371207370293.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <10175291.0E3267SrcQ@eto>
In-Reply-To: <10175291.0E3267SrcQ@eto>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Date: Wed, 03 Jan 2018 21:27:09 +0100

> From a806bbb6385d6428e8484722d7320f3f9c1d622e Mon Sep 17 00:00:00 2001
> From: Rolf Eike Beer <eike-kernel@sf-tec.de>
> Date: Wed, 3 Jan 2018 21:24:20 +0100
> Subject: [PATCH] sparc64: drop unneeded compat include
> 
> The last user of compat_old_sigset_t was removed in commit
> 2d7d5f05111a9d913131a2764d8b20157f8f758d.
> 
> Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

Applied to sparc-next, thank you.
