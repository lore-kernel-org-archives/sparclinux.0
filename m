From: David Miller <davem@davemloft.net>
Date: Wed, 01 Jun 2011 03:35:27 +0000
Subject: Re: [PATCH v3 12/13] sparc: select HAVE_SECCOMP_FILTER and provide
Message-Id: <20110531.203527.92431501.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <BANLkTimNcag-ZmVTXjUoTyiuJm6jtW0DgA@mail.gmail.com>
	<1306897845-9393-12-git-send-email-wad@chromium.org>
In-Reply-To: <1306897845-9393-12-git-send-email-wad@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wad@chromium.org
Cc: linux-kernel@vger.kernel.org, kees.cook@canonical.com, torvalds@linux-foundation.org, tglx@linutronix.de, mingo@elte.hu, rostedt@goodmis.org, jmorris@namei.org, sparclinux@vger.kernel.org

From: Will Drewry <wad@chromium.org>
Date: Tue, 31 May 2011 22:10:44 -0500

> Facilitate the use of CONFIG_SECCOMP_FILTER by wrapping compatibility
> system call numbering for execve and selecting HAVE_SECCOMP_FILTER.
> 
> Signed-off-by: Will Drewry <wad@chromium.org>

Acked-by: David S. Miller <davem@davemloft.net>
