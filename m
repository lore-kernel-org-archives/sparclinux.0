From: David Miller <davem@davemloft.net>
Date: Thu, 05 Sep 2013 19:15:22 +0000
Subject: Re: [PATCH v2] sparc64: Export flush_ptrace_access() (needed by lustre)
Message-Id: <20130905.151522.845113235905620919.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1378372653-5822-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1378372653-5822-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert@linux-m68k.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu,  5 Sep 2013 11:17:33 +0200

> ERROR: "flush_ptrace_access" [drivers/staging/lustre/lustre/libcfs/libcfs.ko]
> undefined!
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2: Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL

Applied, thank you.
