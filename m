From: David Miller <davem@davemloft.net>
Date: Sat, 10 Nov 2012 03:48:46 +0000
Subject: Re: [PATCH] sparc32,leon: Check for existent irq_map entry in leon_handle_ext_irq
Message-Id: <20121109.224846.2150006980850595245.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1351591786-21024-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1351591786-21024-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andreas Larsson <andreas@gaisler.com>
Date: Tue, 30 Oct 2012 11:09:46 +0100

> If an irq is being unlinked concurrently with leon_handle_ext_irq,
> irq_map[eirq] might be null in leon_handle_ext_irq. Make sure that
> this is not dereferenced.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Applied.
