From: "Christian Joensson" <christian.joensson@gmail.com>
Date: Tue, 09 May 2006 07:09:02 +0000
Subject: Re: Question on cross-compiler
Message-Id: <5460e3330605090009g370107b0sbb472c33fd3e4bbd@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C06015691BD@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C06015691BD@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 5/9/06, Rene Rebe <rene@exactcode.de> wrote:
> Hi,
>
> On Tuesday 09 May 2006 07:03, Jurzitza, Dieter wrote:
> > Dear listmembers,
> > is there anyone out who could give me a hint on how to build a
> > cross-compiler for Ultra Sparc 64 Bit on a native 32 Bit environment? My
> > build always barfs about incompatible libc.so - what is clear since it is
> > 32 and not 64 Bit. Any pointer to some FAQ / whatsoever would be highly
> > appreciated!
>
> Despite a bit off-topic here, crosstool (http://www.kegel.com/crosstool/) or
> Development Environments such as T2 (http://www.t2-project.org) can help you
> to build the cross compiler.

also from me, perhaps off-topic, but still, wouldn't it be neat to
have 64 bit Ada? :)

there's two gcc bugzilla PR about this, to my knowledge... pls have a
look at them also

http://gcc.gnu.org/bugzilla/show_bug.cgi?id%743

and

http://gcc.gnu.org/bugzilla/show_bug.cgi?id 035

If anyone gets to it, pls let me know...

--
Cheers,

/ChJ
