From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 26 May 2014 21:26:34 +0000
Subject: Re: [PATCH v2] sbus: Introduce the use of the managed version of kzalloc
Message-Id: <20140526212633.GA30752@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20140525105825.GA3437@himangi-Dell>
In-Reply-To: <20140525105825.GA3437@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Himangi Saraogi <himangi774@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr

Hi Himangi.

On Sun, May 25, 2014 at 04:28:25PM +0530, Himangi Saraogi wrote:
> This patch moves data allocated using kzalloc to managed data allocated
> using devm_kzalloc and cleans now unnecessary kfrees in probe and remove
> functions. The header file is added to make the devm function explicitly
> available.
This version looks much better.
If you in the subject replaces sbus: with display7seg: then you can add my:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

"sbus:" is very generic, but this patch touches only
this single driver.

	Sam
