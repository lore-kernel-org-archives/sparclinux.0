From: Will Deacon <will.deacon@arm.com>
Date: Fri, 13 Oct 2017 16:18:09 +0000
Subject: Re: [PATCH v11 7/9] arm64/kasan: add and use kasan_map_populate()
Message-Id: <20171013161809.GE4746@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171010155619.GA2517@arm.com>
 <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
 <20171010171047.GC2517@arm.com>
 <CAOAebxtrSthSP4NAa0obBbsCK1KZxO+x0w5xNrpY6m2y9UZFvQ@mail.gmail.com>
 <CAOAebxu5WL-FQLgfCxNcWy36V6zsTO1v3LLqXv5rM1Pp9R-=YA@mail.gmail.com>
 <20171013144319.GB4746@arm.com>
 <CAOAebxv4h+8ej6JA_DZbXaNV5JsAk4MbcCLf1+2RvwKGF2+MxQ@mail.gmail.com>
 <20171013154426.GC4746@arm.com>
 <CAOAebxspETEqFXL1Ez_4TK9CAwwk+uhHbYOmZk2QR8b=GO80cQ@mail.gmail.com>
 <CAOAebxv=u4cKS=_Bvyqs7pDA=5Oi0HNWvC4zRmhCiaEUMgQu3w@mail.gmail.com>
In-Reply-To: <CAOAebxv=u4cKS=_Bvyqs7pDA=5Oi0HNWvC4zRmhCiaEUMgQu3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 13, 2017 at 12:00:27PM -0400, Pavel Tatashin wrote:
> BTW, don't we need the same aligments inside for_each_memblock() loop?

Hmm, yes actually, given that we shift them right for the shadow address.

> How about change kasan_map_populate() to accept regular VA start, end
> address, and convert them internally after aligning to PAGE_SIZE?

That's what my original patch did, but it doesn't help on its own because
kasan_populate_zero_shadow would need the same change.

Will
