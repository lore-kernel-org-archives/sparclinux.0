From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jul 2014 04:37:57 +0000
Subject: Re: [PATCH] display7seg: Introduce the use of the managed version of kzalloc
Message-Id: <20140721.213757.334607182319263871.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140526213207.GA1815@himangi-Dell>
In-Reply-To: <20140526213207.GA1815@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: himangi774@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr, sam@ravnborg.org

From: Himangi Saraogi <himangi774@gmail.com>
Date: Tue, 27 May 2014 03:02:07 +0530

> This patch moves data allocated using kzalloc to managed data allocated
> using devm_kzalloc and cleans now unnecessary kfrees in probe and remove
> functions. The header file is added to make the devm function explicitly
> available.
> 
> The following Coccinelle semantic patch was used for making a part of
> the change:
 ...
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Applied to sparc-next.
