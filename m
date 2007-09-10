From: Krzysztof Helt <krzysztof.h1@gmail.com>
Date: Mon, 10 Sep 2007 21:09:36 +0000
Subject: Re: [PATCH] restore_current o0 register clobber
Message-Id: <20070910230936.d8256d93.krzysztof.h1@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070826190858.bc86dea7.krzysztof.h1@wp.pl>
In-Reply-To: <20070826190858.bc86dea7.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 26 Aug 2007 19:08:58 +0200
Krzysztof Helt <krzysztof.h1@wp.pl> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch changes call definitions of the restore_current(void)
> to restore_current(int) to force usage of the o0 register. The o0
> register is used internally and compiler must not assume
> it is preserved during the call.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
[...] 
> The added parameter forces the gcc to
> load value into the o0 register before the
> restore_current() call thus force reloading it
> before the next call.
> 
> I don't know if it has something to do with the crash
> in the atomic_add_unless() which I observe sometimes
> on SMP kernel (SS20) around the floppy driver load
> (just before or just after the text about FDC driver).
> I can confirm it after few days of testing because it
> happens randomly.
> 

It does not help with this as it happened once again (with the patch applied).

Regards,
Krzysztof
