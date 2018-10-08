From: David Miller <davem@davemloft.net>
Date: Mon, 08 Oct 2018 05:57:26 +0000
Subject: Re: [PATCH] sparc64: viohs: Remove VLA usage
Message-Id: <20181007.225726.457975328875903193.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180905220351.GA48213@beast>
In-Reply-To: <20180905220351.GA48213@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: keescook@chromium.org
Cc: allen.pais@oracle.com, pombredanne@nexb.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Wed, 5 Sep 2018 15:03:51 -0700

> In the quest to remove all stack VLA usage from the kernel[1], this
> allocates a fixed size array for the maximum number of cookies and
> adds a runtime sanity check.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1
> RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied.
