From: David Miller <davem@davemloft.net>
Date: Wed, 21 Dec 2011 21:58:05 +0000
Subject: Re: sparc: __mcount_loc already exists
Message-Id: <20111221.165805.154231675155275590.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMuHMdUvnTWvaTndObFjA_pJXNWVpDBqxviyDpYvihc7pDiV3Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUvnTWvaTndObFjA_pJXNWVpDBqxviyDpYvihc7pDiV3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert@linux-m68k.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Dec 2011 08:59:03 +0100

> On Wed, Dec 21, 2011 at 08:51, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> Note that I deleted 5238 lines about "__mcount_loc already exists", to avoid
>> my email being rejected.
> 
> I anyone planning to fix this? It only happens for sparc64/sparc-allmodconfig,
> and appeared in v3.2-rc3.
> 
> linus: http://kisskb.ellerman.id.au/kisskb/buildresult/5167232/
> linux-next: http://kisskb.ellerman.id.au/kisskb/buildresult/5166753/

I'll look into this, thanks.
