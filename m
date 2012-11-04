From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 04 Nov 2012 13:53:06 +0000
Subject: Re: [PATCH] sparc32,leon: Check for existent irq_map entry in leon_handle_ext_irq
Message-Id: <20121104135306.GA7343@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1351591786-21024-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1351591786-21024-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Oct 30, 2012 at 11:09:46AM +0100, Andreas Larsson wrote:
> If an irq is being unlinked concurrently with leon_handle_ext_irq,
> irq_map[eirq] might be null in leon_handle_ext_irq. Make sure that
> this is not dereferenced.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
