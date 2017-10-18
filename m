From: Will Deacon <will.deacon@arm.com>
Date: Wed, 18 Oct 2017 17:06:51 +0000
Subject: Re: [PATCH v12 08/11] arm64/kasan: add and use kasan_map_populate()
Message-Id: <20171018170651.GG21820@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
 <20171013173214.27300-9-pasha.tatashin@oracle.com>
 <0ae84532-8dcb-10aa-9d69-79d7025b089e@virtuozzo.com>
 <ad8c5715-dc4f-1fa7-c25b-e08df68643d0@oracle.com>
In-Reply-To: <ad8c5715-dc4f-1fa7-c25b-e08df68643d0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Oct 18, 2017 at 01:03:10PM -0400, Pavel Tatashin wrote:
> I asked Will, about it, and he preferred to have this patched added to the
> end of my series instead of replacing "arm64/kasan: add and use
> kasan_map_populate()".

As I said, I'm fine either way, I just didn't want to cause extra work
or rebasing:

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/535703.html

> In addition, Will's patch stops using large pages for kasan memory, and thus
> might add some regression in which case it is easier to revert just that
> patch instead of the whole series. It is unlikely that regression is going
> to be detectable, because kasan by itself makes system quiet slow already.

If it causes problems, I'll just fix them. No need to revert.

Will
