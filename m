From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 13 Oct 2017 16:00:27 +0000
Subject: Re: [PATCH v11 7/9] arm64/kasan: add and use kasan_map_populate()
Message-Id: <CAOAebxv=u4cKS=_Bvyqs7pDA=5Oi0HNWvC4zRmhCiaEUMgQu3w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
 <20171009221931.1481-8-pasha.tatashin@oracle.com>
 <20171010155619.GA2517@arm.com>
 <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
 <20171010171047.GC2517@arm.com>
 <CAOAebxtrSthSP4NAa0obBbsCK1KZxO+x0w5xNrpY6m2y9UZFvQ@mail.gmail.com>
 <CAOAebxu5WL-FQLgfCxNcWy36V6zsTO1v3LLqXv5rM1Pp9R-=YA@mail.gmail.com>
 <20171013144319.GB4746@arm.com>
 <CAOAebxv4h+8ej6JA_DZbXaNV5JsAk4MbcCLf1+2RvwKGF2+MxQ@mail.gmail.com>
 <20171013154426.GC4746@arm.com>
 <CAOAebxspETEqFXL1Ez_4TK9CAwwk+uhHbYOmZk2QR8b=GO80cQ@mail.gmail.com>
In-Reply-To: <CAOAebxspETEqFXL1Ez_4TK9CAwwk+uhHbYOmZk2QR8b=GO80cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

BTW, don't we need the same aligments inside for_each_memblock() loop?

How about change kasan_map_populate() to accept regular VA start, end
address, and convert them internally after aligning to PAGE_SIZE?

Thank you,
Pavel


On Fri, Oct 13, 2017 at 11:54 AM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>> Thanks for sharing the .config and tree. It looks like the problem is that
>> kimg_shadow_start and kimg_shadow_end are not page-aligned. Whilst I fix
>> them up in kasan_map_populate, they remain unaligned when passed to
>> kasan_populate_zero_shadow, which confuses the loop termination conditions
>> in e.g. zero_pte_populate and the shadow isn't configured properly.
>
> This makes sense. Thank you. I will insert these changes into your
> patch, and send out a new series soon after sanity checking it.
>
> Pavel
