From: David Miller <davem@davemloft.net>
Date: Thu, 02 Aug 2007 09:42:22 +0000
Subject: Re: Build failures on a sparcstation10 with 2.6.23-rc1
Message-Id: <20070802.024222.101870178.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
In-Reply-To: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Thu, 2 Aug 2007 11:42:52 +0200

> On Thu, 02 Aug 2007 00:18:37 -0700 (PDT)
> David Miller <davem@davemloft.net> wrote:
> 
> > Since the issue is being forced, I made another attempt to make
> > modular floppy work on sparc32.  If people could test this patch I'd
> > apprecaite it.
> > 
> 
> The patch works on SS20 with UP kernel. A floppy can be built-in
> or build as a module. The floppy works in both cases.

Thanks for testing.
