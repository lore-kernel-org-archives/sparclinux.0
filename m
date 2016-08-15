From: Jonathan Corbet <corbet@lwn.net>
Date: Mon, 15 Aug 2016 14:25:40 +0000
Subject: Re: [PATCH] Documentation: kprobes: Document jprobes stack copying limitations
Message-Id: <20160815082540.2b7a889b@lwn.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1471033484-2709-1-git-send-email-dave.long@linaro.org>
In-Reply-To: <1471033484-2709-1-git-send-email-dave.long@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 12 Aug 2016 16:24:44 -0400
David Long <dave.long@linaro.org> wrote:

> Some architectures (i.e.: sparc64 and arm64) make reasonable partial stack
> duplication for jprobes problematic. Document this.

Applied to the docs tree, thanks.

jon
