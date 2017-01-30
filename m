From: David Miller <davem@davemloft.net>
Date: Mon, 30 Jan 2017 22:33:13 +0000
Subject: Re: [PATCH] sparc32: mm: srmmu: add __ro_after_init to sparc32_cachetlb_ops structures
Message-Id: <20170130.173313.1658478542391677325.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1484397114-7705-1-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1484397114-7705-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bhumirks@gmail.com
Cc: julia.lawall@lip6.fr, sparclinux@vger.kernel.org, keescook@chromium.org, linux-kernel@vger.kernel.org

From: Bhumika Goyal <bhumirks@gmail.com>
Date: Sat, 14 Jan 2017 18:01:54 +0530

> The objects viking_ops, viking_sun4d_smp_ops and smp_cachetlb_ops of
> type sparc32_cachetlb_ops are not modified anywhere after getting modified 
> in the init functions. Inside init their reference is also stored in a
> pointer of type const struct sparc32_cachetlb_ops *. So these structures 
> are never modified after init, therefore add __ro_after to the declaration 
> of these structures.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied, thanks.
