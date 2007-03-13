From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
Date: Tue, 13 Mar 2007 21:57:26 +0000
Subject: Re: Linux 2.6.20.3
Message-Id: <29495f1d0703131457i43883529p5da1502b68ff0948@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070313183353.GA7434@kroah.com>
In-Reply-To: <20070313183353.GA7434@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org, davem@davemloft.net, sparclinux@vger.kernel.org

On 3/13/07, Greg KH <greg@kroah.com> wrote:
> We (the -stable team) are announcing the release of the 2.6.20.3 kernel.
> It contains a number of bugfixes and all 2.6.20 users are recommended to
> upgrade.
>
> The diffstat and short summary of the fixes are below.
>
> I'll also be replying to this message with a copy of the patch between
> 2.6.20.2 and 2.6.20.3.

Compared to 2.6.20.1 (will try 2.6.20.2 as well), I now get:

[  199.361347] BUG: soft lockup detected on CPU#2!

smp_percpu_timer_interrupt+0xd4/0x180
tl0_irq14+0x1c/0x20
journal_add_journal_head+0x2c/0x1e0
journal_write_metadata_buffer+0x480/0x500
journal_commit_transaction+0xc38/0x1040
kjournald+0xc0/0x1e0
kthread+0xb0/0xc0
kernel_thread+0x38/0x60
keventd_create_kthread+0x20/0xa0

shortly after the serial console prompts for login.

Thanks,
Nish
