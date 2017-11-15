From: David Miller <davem@davemloft.net>
Date: Wed, 15 Nov 2017 05:42:03 +0000
Subject: Re: [PATCH] sparc/led: Convert timers to use timer_setup()
Message-Id: <20171115.144203.2015410660429172361.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20171010220727.GA97619@beast>
In-Reply-To: <20171010220727.GA97619@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: keescook@chromium.org
Cc: geliangtang@gmail.com, mingo@kernel.org, sparclinux@vger.kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Tue, 10 Oct 2017 15:07:27 -0700

> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly. Adds a static variable to hold timeout
> value.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Geliang Tang <geliangtang@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied.
