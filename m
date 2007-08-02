From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Thu, 02 Aug 2007 09:42:52 +0000
Subject: Re: Build failures on a sparcstation10 with 2.6.23-rc1
Message-Id: <20070802114252.f65e2703.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
In-Reply-To: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 02 Aug 2007 00:18:37 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> Since the issue is being forced, I made another attempt to make
> modular floppy work on sparc32.  If people could test this patch I'd
> apprecaite it.
> 

The patch works on SS20 with UP kernel. A floppy can be built-in
or build as a module. The floppy works in both cases.

I haven't tested SMP kernel as the kernel is unstable in general (issues with prom).

Regards,
Krzysztof
