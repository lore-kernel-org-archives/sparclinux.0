From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 14 Jun 2005 19:41:03 +0000
Subject: Re: [PATCH 2.4][SPARC64] fix sys32_utimes(somefile, NULL)
Message-Id: <20050614.124103.23013433.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050614192306.GC13702@fngna.oyu>
In-Reply-To: <20050614192306.GC13702@fngna.oyu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: qboosh@pld-linux.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Jakub Bogusz <qboosh@pld-linux.org>
Date: Tue, 14 Jun 2005 21:23:06 +0200

> This patch fixes utimes(somefile, NULL) syscalls on sparc64 kernel with
> 32-bit userland - use of uninitialized value resulted in making random
> timestamps, which confused e.g. sudo.
> It has been already fixed (by davem) in linux-2.6 tree 30 months ago.
> 
> Signed-off-by: Jakub Bogusz <qboosh@pld-linux.org>

Thanks a lot Jakub, I'll push this to Marcelo as soon as he
opens up his 2.4.x GIT tree.
