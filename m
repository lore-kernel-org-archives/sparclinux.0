From: David Miller <davem@davemloft.net>
Date: Tue, 12 May 2020 20:06:33 +0000
Subject: Re: [PATCH 0/3] sparc: port to copy_thread_tls() and struct kernel_clone_args
Message-Id: <20200512.130633.293867428547074800.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200512171527.570109-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: christian.brauner@ubuntu.com
Cc: arnd@arndb.de, guoren@kernel.org, linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 12 May 2020 19:15:24 +0200

> I've tested this series with qemu-system-sparc64 and a Debian Sid image
> and it comes up no problem (Here's a little recording
> https://asciinema.org/a/329510 ).

Can you show how you put this environment together and also what
compilation tools you used?  Looks great.

> This is the sparc specific bit and _if_ you agree with the changes here
> it'd be nice if I could get your review, and if technically correct,
> your ack so I can fold this into a larger series and move on to the next
> arch.

With the delay slot instruction indentation fixed:

Acked-by: David S. Miller <davem@davemloft.net>

Thank you.
