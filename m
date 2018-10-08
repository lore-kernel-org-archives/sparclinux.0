From: David Miller <davem@davemloft.net>
Date: Mon, 08 Oct 2018 18:10:46 +0000
Subject: Re: [PATCH sparc-next] sunvdc: Remove VLA usage
Message-Id: <20181008.111046.1103300226053324861.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181008154651.GA36881@beast>
In-Reply-To: <20181008154651.GA36881@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: keescook@chromium.org
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Mon, 8 Oct 2018 08:46:51 -0700

> In the quest to remove all stack VLA usage from the kernel[1], this moves
> the math for cookies calculation into macros and allocates a fixed size
> array for the maximum number of cookies and adds a runtime sanity check.
> (Note that the size was always fixed, but just hidden from the compiler.)
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied.
