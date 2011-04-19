From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 19 Apr 2011 18:41:14 +0000
Subject: Re: [PATCH 5/7] sparc32,leon: code cleanup of timer/IRQ controller
Message-Id: <20110419184114.GE20041@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1303229239-21551-5-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303229239-21551-5-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Apr 19, 2011 at 06:07:17PM +0200, Daniel Hellstrom wrote:
> Cleaned up leon_init_timers() by removing unnecessary double checking
> and one indentation level. Changed LEON_IMASK to LEON_IMASK(cpu).
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>

I did not follow all the changes - but it looks like a nce cleanup.
Acked-by: Sam Ravnborg <sam@ravnborg.org>

